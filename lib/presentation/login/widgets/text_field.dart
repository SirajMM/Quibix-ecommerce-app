import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      this.comtroller,
      this.validator,
      this.eyeIcon,
      this.obscureText,
      this.labelText,
      this.keyBoardType,
      this.maxLines,
      this.textString,
      this.editeOrAdd});
  final TextEditingController? comtroller;
  final Widget? eyeIcon;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final String? labelText;
  final TextInputType? keyBoardType;
  final int? maxLines;
  final String? textString;
  final bool? editeOrAdd;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    if (widget.editeOrAdd != null) {
      if (!widget.editeOrAdd!) {
        widget.comtroller!.text = widget.textString ?? '';
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      maxLines: widget.maxLines ?? 1,
      keyboardType: widget.keyBoardType ?? TextInputType.text,
      controller: widget.comtroller,
      obscureText: widget.obscureText ?? false,
      decoration: InputDecoration(
        labelText: widget.labelText ?? '',
        suffixIcon: widget.eyeIcon,
        filled: true,
        fillColor: Colors.white.withOpacity(.7),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
