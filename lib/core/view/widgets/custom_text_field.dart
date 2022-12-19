import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../resources/resources.dart';
import '../../extensions/num_extensions.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Widget? prefix;
  final Widget? suffix;
  final bool readOnly;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final String? initialValue;
  final TextInputType? keyBoardType;
  final Color? fillColor;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String?)? onSaved;
  final void Function(String)? onSubmitted;
  final TextEditingController? controller;
  final List<TextInputFormatter>? formatters;
  final AutovalidateMode? autoValidateMode;
  final TextInputAction? textInputAction;

  const CustomTextField({
    this.hintText = "",
    this.prefix,
    this.suffix,
    this.validator,
    this.readOnly = false,
    this.obscureText = false,
    this.keyBoardType,
    this.controller,
    this.formatters,
    this.fillColor,
    this.onChanged,
    this.onTap,
    this.onSaved,
    this.onSubmitted,
    this.textInputAction,
    this.maxLines,
    this.minLines,
    this.initialValue,
    this.autoValidateMode,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autoValidateMode,
      cursorColor: AppColors.primary,
      textCapitalization: TextCapitalization.sentences,
      obscureText: obscureText,
      readOnly: readOnly,
      validator: validator,
      controller: controller,
      inputFormatters: formatters,
      onChanged: onChanged,
      onTap: onTap,
      onSaved: onSaved,
      onFieldSubmitted: onSubmitted,
      initialValue: initialValue,
      keyboardType: keyBoardType,
      maxLines: maxLines ?? 1,
      minLines: minLines ?? 1,
      textInputAction: textInputAction,
      style: const TextStyle(
        color: AppColors.black,
        fontFamily: FontConstants.fontFamily,
        fontSize: FontSize.s16,
        fontWeight: FontWeightManager.regular,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: fillColor,
        prefixIcon: prefix != null ? Padding(padding: EdgeInsets.all(AppPadding.p8.w), child: prefix) : null,
        prefixIconConstraints: const BoxConstraints(minWidth: AppSize.s0, minHeight: AppSize.s0),
        suffixIcon: suffix != null ? Padding(padding: EdgeInsets.all(AppPadding.p8.w), child: suffix) : null,
        suffixIconConstraints: const BoxConstraints(minWidth: AppSize.s0, minHeight: AppSize.s0),
      ),
    );
  }
}
