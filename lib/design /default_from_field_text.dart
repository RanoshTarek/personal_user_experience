
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final Key? keyText;
  final TextStyle? style;
  final Icon? prefixIcon;
  final IconButton? suffixIcon;
  final VoidCallback? suffixIconPressed;
  final FormFieldValidator<String>? validate;
  final VoidCallback? onTap;
  final Function(String)? onChange;
  final String? labelText;
  final String? hintText;
  final bool readOnly;
  final bool? isObscureText;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final double? padding;
  final Color? fillColor;
  final TextDirection? textDirection;
  final Widget? prefix;
  final Widget? suffix;
  final EdgeInsets? contentPadding;
  final bool? isCollapsed;
  final bool? enabled;
  final int? errorMaxLines;
  final bool? withBorder;
  final int? minLines;

  final FloatingLabelBehavior? floatingLabelBehavior;

  const DefaultTextFormField(this.controller, this.textInputType,
      {Key? key,
      this.keyText,
      this.style,
      this.labelText,
      this.prefixIcon,
      this.suffixIcon,
      this.withBorder = true,
      this.padding = 16,
      this.readOnly = false,
      this.suffixIconPressed,
      this.validate,
      this.onTap,
      this.onFieldSubmitted,
      this.textInputAction,
      this.onChange,
      this.isObscureText,
      this.hintText,
      this.inputFormatters,
      this.focusNode,
      this.textAlign = TextAlign.center,
      this.fillColor,
      this.textDirection,
      this.prefix,
      this.suffix,
      this.contentPadding,
      this.isCollapsed,
      this.enabled,
      this.errorMaxLines,
      this.floatingLabelBehavior,
      this.minLines
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: keyText,
      controller: controller,
      keyboardType: textInputType,
      textAlign: textAlign,
      obscureText: isObscureText ?? false,
      validator: validate,
      onTap: onTap,
      onChanged: onChange,
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      textDirection: textDirection,
      style: style,
      enabled: enabled,

      decoration: InputDecoration(
          isCollapsed: isCollapsed ?? false,
          prefix: prefix,
          suffix: suffix,
          floatingLabelBehavior: floatingLabelBehavior,
          fillColor: fillColor,
          filled: fillColor != null,
          errorMaxLines: errorMaxLines,
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(horizontal: 16),
         floatingLabelStyle: const TextStyle(color: Colors.blue),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.red), //AppColors.infoLinksColors[1]
          ),
         enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: (withBorder == true)
                    ? const Color(0xFFCED4DA)
                    : Colors.white), //AppColors.infoLinksColors[1]
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:
                  (withBorder == true) ? Colors.blue : Colors.white,
            ), // we
          ),
          prefixIcon: prefixIcon,
          suffixIcon: (suffixIcon != null)
              ? IconButton(onPressed: suffixIconPressed, icon: suffixIcon!)
              : null,
          labelText: hintText,

          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: (withBorder == true)
                    ? const Color(0xFFCED4DA)
                    : Colors.white),
          )),
        maxLines: (minLines != null && (minLines! > (minLines ?? 0)))
            ? minLines
            : (minLines ?? 1)
    );
  }
}
