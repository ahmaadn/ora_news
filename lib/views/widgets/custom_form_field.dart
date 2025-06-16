import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';
import 'package:ora_news/views/widgets/custom_field_label.dart';

// Enum untuk ukuran tinggi FormField, akan mempengaruhi tinggi kotak field
enum FormFieldSize { xSmall, small, medium, large, xLarge }

class CustomFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String? labelText; // Label yang tampil di atas field
  final String? hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool readOnly;
  final bool enabled;
  final AutovalidateMode autovalidateMode;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final FormFieldSize boxSize;
  final Color? backgroundColor;
  final Color? outlineColor;
  final Color? focusOutlineColor;
  final double? borderRadius;
  final bool collapseError;
  final Function(String)? onFieldSubmitted;

  const CustomFormField({
    super.key,
    this.controller,
    this.initialValue,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.textInputAction,
    this.focusNode,
    this.readOnly = false,
    this.enabled = true,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.onTap,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.boxSize = FormFieldSize.medium,
    this.backgroundColor,
    this.outlineColor = AppColors.greyMedium,
    this.focusOutlineColor = AppColors.neutral,
    this.borderRadius,
    this.collapseError = true,
    this.onFieldSubmitted,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  String? _errorText;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    if (mounted) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  double _getTargetBoxHeight() {
    switch (widget.boxSize) {
      case FormFieldSize.xSmall:
        return AppSpacing.boxXSmall;
      case FormFieldSize.small:
        return AppSpacing.boxSmall;
      case FormFieldSize.medium:
        return AppSpacing.boxMedium;
      case FormFieldSize.large:
        return AppSpacing.boxLarge;
      case FormFieldSize.xLarge:
        return AppSpacing.boxXLarge;
    }
  }

  EdgeInsetsGeometry _getEffectiveContentPadding(TextStyle textStyle) {
    final double targetBoxHeight = _getTargetBoxHeight();
    final double textHeight = textStyle.fontSize ?? AppTypography.bodyText1.fontSize!;
    final double lineHeight = textStyle.height ?? 1.2;
    final double singleLineTextActualHeight = textHeight * lineHeight;
    double verticalPadding = (targetBoxHeight - singleLineTextActualHeight) / 2;

    if (verticalPadding < AppSpacing.xs) {
      verticalPadding = AppSpacing.xs;
    }
    return EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: verticalPadding);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final InputDecorationTheme inputTheme = theme.inputDecorationTheme;
    final bool isEffectivelyEnabled = widget.enabled && !widget.readOnly;
    final TextStyle effectiveTextStyle = AppTypography.bodyText1.copyWith(
      color: isEffectivelyEnabled ? AppColors.textPrimary : AppColors.textDisabled,
    );
    final EdgeInsetsGeometry effectiveContentPadding = _getEffectiveContentPadding(
      effectiveTextStyle,
    );
    final double cursorHeight =
        (effectiveTextStyle.fontSize ?? AppTypography.bodyText1.fontSize!) + AppSpacing.xs;

    final Color fillColor = widget.backgroundColor ?? Colors.transparent;
    final Color defaultOutlineColor =
        widget.outlineColor ??
        (isEffectivelyEnabled ? AppColors.grey400 : AppColors.grey300);
    final Color focusedOutlineColor =
        widget.focusOutlineColor ?? widget.outlineColor ?? theme.colorScheme.primary;
    final Color errorOutlineColor = theme.colorScheme.error;
    final Color disabledOutlineColor = AppColors.grey300;

    // Menggunakan borderRadius kustom jika ada, jika tidak, gunakan default
    final BorderRadius borderRadius = BorderRadius.circular(
      widget.borderRadius ?? AppSpacing.roundedMedium,
    );

    OutlineInputBorder currentOutlineInputBorder = OutlineInputBorder(
      borderRadius: borderRadius, // Menggunakan borderRadius yang sudah ditentukan
      borderSide: BorderSide(
        color:
            _errorText != null && isEffectivelyEnabled
                ? errorOutlineColor
                : (_isFocused && isEffectivelyEnabled
                    ? focusedOutlineColor
                    : defaultOutlineColor),
        width: _isFocused && isEffectivelyEnabled ? 1.5 : 1.0,
      ),
    );

    OutlineInputBorder currentDisabledOutlineInputBorder = OutlineInputBorder(
      borderRadius: borderRadius, // Menggunakan borderRadius yang sudah ditentukan
      borderSide: BorderSide(color: disabledOutlineColor, width: 1.0),
    );

    InputDecoration effectiveDecoration = InputDecoration(
      hintText: widget.hintText,
      prefixIcon:
          widget.prefixIcon != null
              ? Icon(
                widget.prefixIcon,
                color: isEffectivelyEnabled ? AppColors.grey600 : AppColors.grey400,
              )
              : null,
      suffixIcon: widget.suffixIcon,
      hintStyle: inputTheme.hintStyle?.copyWith(
        color: isEffectivelyEnabled ? AppColors.grey500 : AppColors.grey400,
      ),
      errorStyle: const TextStyle(fontSize: 0, height: 12),
      filled: true,
      fillColor: fillColor,
      contentPadding: effectiveContentPadding,
      counterText: "",
      border:
          isEffectivelyEnabled
              ? currentOutlineInputBorder
              : currentDisabledOutlineInputBorder,
      enabledBorder:
          isEffectivelyEnabled
              ? currentOutlineInputBorder
              : currentDisabledOutlineInputBorder,
      focusedBorder:
          isEffectivelyEnabled
              ? currentOutlineInputBorder.copyWith(
                borderSide: BorderSide(color: focusedOutlineColor, width: 1.5),
              )
              : currentDisabledOutlineInputBorder,
      disabledBorder: currentDisabledOutlineInputBorder,
      errorBorder: currentOutlineInputBorder.copyWith(
        borderSide: BorderSide(color: errorOutlineColor, width: 1.5),
      ),
      focusedErrorBorder: currentOutlineInputBorder.copyWith(
        borderSide: BorderSide(color: errorOutlineColor, width: 1.5),
      ),
    );

    inputValidator(value) {
      if (!isEffectivelyEnabled || widget.validator == null) return null;
      final error = widget.validator!(value);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _errorText = error;
          });
        }
      });
      return error != null ? '' : null;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (widget.labelText != null && widget.labelText!.isNotEmpty)
          CustomFieldLabel(text: widget.labelText!, enabled: isEffectivelyEnabled),
        SizedBox(
          height: _getTargetBoxHeight(),
          child: TextFormField(
            controller: widget.controller,
            initialValue: widget.initialValue,
            decoration: effectiveDecoration,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            cursorHeight: cursorHeight,
            validator: inputValidator,
            onChanged: widget.onChanged,
            onSaved: widget.onSaved,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            maxLength: widget.maxLength,
            textInputAction: widget.textInputAction,
            focusNode: _focusNode,
            readOnly: widget.readOnly,
            enabled: widget.enabled,
            autovalidateMode: widget.autovalidateMode,
            onTap: widget.onTap,
            inputFormatters: widget.inputFormatters,
            textCapitalization: widget.textCapitalization,
            style: effectiveTextStyle,
            textAlignVertical: TextAlignVertical.center,
            onFieldSubmitted: widget.onFieldSubmitted,
          ),
        ),
        if (widget.collapseError && _errorText != null && isEffectivelyEnabled ||
            !widget.collapseError)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xs / 2, left: AppSpacing.s / 2),
            child: Text(
              _errorText != null ? _errorText! : '',
              style: AppTypography.caption.copyWith(color: AppColors.error),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
    );
  }
}
