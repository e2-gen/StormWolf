import 'package:flutter/material.dart';
import 'package:stormwolf/core/constants/app_constants.dart';
import 'package:stormwolf/presentation/theme/app_theme.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int? maxLines;
  final int? minLines;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmitted;
  final bool enabled;
  final String? hintText;
  final double? height;
  final EdgeInsetsGeometry? contentPadding;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
    this.minLines,
    this.autofocus = false,
    this.textInputAction,
    this.onSubmitted,
    this.enabled = true,
    this.hintText,
    this.height,
    this.contentPadding,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              widget.label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: _isFocused
                        ? AppColors.primaryColor
                        : AppColors.textSecondary,
                  ),
            ),
          ),
        ],
        Container(
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
            color: AppColors.darkSurface,
            border: Border.all(
              color: _isFocused
                  ? AppColors.primaryColor.withOpacity(0.5)
                  : Colors.transparent,
              width: 1.5,
            ),
            boxShadow: _isFocused
                ? [
                    BoxShadow(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            autofocus: widget.autofocus,
            textInputAction: widget.textInputAction,
            onFieldSubmitted: widget.onSubmitted,
            enabled: widget.enabled,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textPrimary,
                ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary.withOpacity(0.5),
                  ),
              contentPadding: widget.contentPadding ??
                  const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
              border: InputBorder.none,
              prefixIcon: widget.prefixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 16, right: 8),
                      child: Icon(
                        widget.prefixIcon,
                        color: _isFocused
                            ? AppColors.primaryColor
                            : AppColors.textSecondary,
                      ),
                    )
                  : null,
              suffixIcon: widget.suffixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: widget.suffixIcon,
                    )
                  : null,
            ),
            validator: widget.validator,
            onChanged: widget.onChanged,
          ),
        ),
      ],
    );
  }
}