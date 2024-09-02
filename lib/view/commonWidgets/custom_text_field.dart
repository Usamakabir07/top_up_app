import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    required this.validation,
    required this.textController,
    required this.icon,
    required this.charLength,
    this.isPassword = false,
    this.isNumber = false,
    this.onTap,
  });

  final String hint;
  final IconData? icon;
  final int? charLength;
  final FormFieldValidator<String>? validation;
  final TextEditingController textController;
  final bool? isPassword;
  final bool? isNumber;
  final Function? onTap;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextFormField(
        autofocus: false,
        enableSuggestions: false,
        autocorrect: false,
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.charLength),
        ],
        scrollPadding: const EdgeInsets.all(10),
        style: const TextStyle(color: Colors.black),
        controller: widget.textController,
        validator: widget.validation,
        keyboardType:
            widget.isNumber! ? TextInputType.number : TextInputType.text,
        obscureText:
            (widget.isPassword == true && isVisibility == true) ? true : false,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            // borderSide: BorderSide(color: MyColors.activeColor, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              widget.icon,
              color: MyColors.activeColor,
            ),
          ),
          hintText: widget.hint,
          hintStyle: TextStyle(color: MyColors.greyColor),
          border: OutlineInputBorder(
            // borderSide: BorderSide(color: MyColors.activeColor, width: 1.0),
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon: (widget.isPassword == true)
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isVisibility = !isVisibility;
                    });
                  },
                  icon: Icon(
                      (isVisibility) ? Icons.visibility : Icons.visibility_off),
                  color: Colors.grey,
                )
              : const SizedBox(
                  width: 0,
                  height: 0,
                ),
        ),
      ),
    );
  }
}
