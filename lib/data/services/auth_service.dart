import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stormwolf/core/utils/shared_prefs.dart';
import 'package:stormwolf/data/models/user_model.dart';
import 'package:stormwolf/core/constants/app_constants.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // تسجيل مستخدم جديد بالبريد الإلكتروني وكلمة المرور
  Future<UserModel> registerWithEmail({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required double weight,
    required double height,
    required BodyType bodyType,
  }) async {
    try {
      // إنشاء الحساب في Firebase
      final UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // إنشاء نموذج المستخدم
      final newUser = UserModel(
        id: credential.user!.uid,
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password, // Note: Hash this in production
        weight: weight,
        height: height,
        bodyType: bodyType,
      );

      // حفظ بيانات المستخدم محلياً
      await SharedPrefs.saveUser(newUser);

      return newUser;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseError(e.code);
    } catch (e) {
      throw 'حدث خطأ غير متوقع';
    }
  }

  // تسجيل الدخول بالبريد الإلكتروني وكلمة المرور
  Future<UserModel> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      // جلب بيانات المستخدم من Firestore أو أي مصدر آخر
      // هنا نستخدم البيانات المحفوظة كمثال
      final user = SharedPrefs.getUser();

      if (user == null) {
        throw 'بيانات المستخدم غير موجودة';
      }

      // تحديث آخر تاريخ دخول
      final updatedUser = user.updateLastLogin();
      await SharedPrefs.saveUser(updatedUser);

      return updatedUser;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseError(e.code);
    } catch (e) {
      throw 'حدث خطأ غير متوقع';
    }
  }

  // تسجيل الدخول بحساب Google
  Future<UserModel> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) throw 'تم إلغاء العملية';

      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = 
          await _firebaseAuth.signInWithCredential(credential);

      if (userCredential.user == null) throw 'فشل تسجيل الدخول';

      // إنشاء نموذج مستخدم جديد من بيانات Google
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: userCredential.user!.displayName?.split(' ').first ?? 'مستخدم',
        lastName: userCredential.user!.displayName?.split(' ').last ?? 'جديد',
        email: userCredential.user!.email ?? '',
        password: '', // لا نحتاج كلمة مرور مع Google Sign-In
        weight: AppConstants.defaultWeight,
        height: AppConstants.defaultHeight,
        bodyType: BodyType.mesomorph, // افتراضي
      );

      await SharedPrefs.saveUser(newUser);
      return newUser;
    } catch (e) {
      throw 'فشل تسجيل الدخول باستخدام Google: ${e.toString()}';
    }
  }

  // تسجيل الخروج
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
      await SharedPrefs.clearUser();
    } catch (e) {
      throw 'فشل تسجيل الخروج';
    }
  }

  // إعادة تعيين كلمة المرور
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseError(e.code);
    } catch (e) {
      throw 'حدث خطأ غير متوقع';
    }
  }

  // التحقق من حالة المصادقة الحالية
  Future<bool> isLoggedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null && await SharedPrefs.isLoggedIn();
  }

  // الحصول على مستخدم Firebase الحالي
  User? getCurrentFirebaseUser() {
    return _firebaseAuth.currentUser;
  }

  // معالجة أخطاء Firebase
  String _handleFirebaseError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'البريد الإلكتروني مستخدم بالفعل';
      case 'invalid-email':
        return 'بريد إلكتروني غير صالح';
      case 'operation-not-allowed':
        return 'عملية غير مسموح بها';
      case 'weak-password':
        return 'كلمة المرور ضعيفة';
      case 'user-disabled':
        return 'الحساب معطل';
      case 'user-not-found':
        return 'الحساب غير موجود';
      case 'wrong-password':
        return 'كلمة المرور خاطئة';
      case 'too-many-requests':
        return 'طلبات كثيرة جداً، حاول لاحقاً';
      default:
        return 'حدث خطأ في المصادقة';
    }
  }

  // تحديث بيانات المستخدم
  Future<UserModel> updateUserProfile(UserModel updatedUser) async {
    try {
      // هنا يمكنك إضافة تحديث بيانات المستخدم في Firestore أو أي قاعدة بيانات
      await SharedPrefs.saveUser(updatedUser);
      return updatedUser;
    } catch (e) {
      throw 'فشل تحديث الملف الشخصي';
    }
  }

  // تغيير كلمة المرور
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) throw 'لم يتم العثور على المستخدم';

      // إعادة المصادقة قبل تغيير كلمة المرور
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);

      // تحديث بيانات المستخدم المحلية
      final currentUser = SharedPrefs.getUser();
      if (currentUser != null) {
        await SharedPrefs.saveUser(currentUser.copyWith(password: newPassword));
      }
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseError(e.code);
    } catch (e) {
      throw 'فشل تغيير كلمة المرور';
    }
  }
}