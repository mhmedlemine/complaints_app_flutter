import 'package:flutter/material.dart';

class TextFieldRoundedWidget extends StatelessWidget {
  final String? initialValue;
  final String? hint;
  final IconData? icon;
  final String? errorText;
  final TextAlign? textAlign;
  final bool isObscure;
  final bool isIcon;
  final bool readOnly;
  final TextInputType? inputType;
  final TextEditingController? textController;
  final EdgeInsets padding;
  final Color hintColor;
  final Color iconColor;
  final int? maxLength;
  final int? maxLines;
  final TextStyle? style;
  final InputDecoration? decoration;
  final FocusNode? focusNode;
  final ValueChanged? onFieldSubmitted;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final bool autoFocus;
  final TextInputAction? inputAction;
  final Widget? suffix;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        initialValue: initialValue,
        textAlign: textAlign ?? TextAlign.start,
        controller: textController,
        focusNode: focusNode,
        enabled: enabled,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        onTap: onTap,
        autofocus: autoFocus,
        readOnly: readOnly,
        textInputAction: inputAction,
        obscureText: this.isObscure,
        maxLength: this.maxLength,
        maxLines: this.maxLines,
        keyboardType: this.inputType,
        validator: this.validator,
        style: this.style ??
            Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.black),
        decoration: this.decoration ??
            InputDecoration(
              filled: true,
              fillColor: Colors.grey[300],
              hintText: this.hint,
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: hintColor),
              errorText: errorText,
              //suffixIcon: suffix,
              suffix: suffix,
              counterText: '',
              icon: icon != null ? Icon(this.icon, color: iconColor) : null,
              contentPadding: const EdgeInsets.only(
                top: 4.0,
                bottom: 6.0,
                left: 14.0,
                right: 14.0,
              ),
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12.0),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
      ),
    );
  }

  const TextFieldRoundedWidget({
    Key? key,
    this.initialValue,
    required this.errorText,
    this.textController,
    this.inputType,
    this.hint,
    this.isObscure = false,
    this.readOnly = false,
    this.textAlign,
    this.isIcon = true,
    this.enabled = true,
    this.padding = const EdgeInsets.all(0),
    this.hintColor = Colors.grey,
    this.iconColor = Colors.grey,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.validator,
    this.autoFocus = false,
    this.inputAction,
    this.decoration,
    this.maxLines,
    this.maxLength,
    this.style,
    this.onTap,
    this.icon,
    this.suffix,
  }) : super(key: key);
}
