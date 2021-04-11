import 'package:flutter/material.dart';
import 'package:prayer/styles/styles.dart';

class AppFormField extends StatefulWidget {
  final TextEditingController controller;
  final String Function(String) validator;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final AutovalidateMode autovalidateMode;
  // final String labelText;
  final int maxLines;

  final bool isPassword;
  final bool showChangeButton;
  final bool hasSuffixIcon;
  final bool showTooltip;
  final bool readOnly;
  final bool smallLabel;

  AppFormField({
    Key key,
    @required this.controller,
    @required this.validator,
    @required this.textCapitalization,
    @required this.keyboardType,
    @required this.autovalidateMode,
    // @required this.labelText,
    @required this.maxLines,
    this.hasSuffixIcon = false,
    this.isPassword = false,
    this.showChangeButton = false,
    this.showTooltip = false,
    this.readOnly = false,
    this.smallLabel = false,
  }) : super(key: key);

  @override
  _AppFormFieldState createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  final FocusNode _focusNode = FocusNode();

  bool obscureText = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusNodeEvent);
    if (widget.isPassword) {
      setState(() {
        obscureText = true;
      });
    }
  }

  _onFocusNodeEvent() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly,
      focusNode: _focusNode,
      controller: widget.controller,
      validator: widget.validator,
      textCapitalization: widget.textCapitalization,
      keyboardType: widget.keyboardType,
      obscureText: obscureText,
      autovalidateMode: widget.autovalidateMode,
      cursorColor: Colors.orange,
      cursorHeight: 18,
      style: mainStyle(),
      textAlign: TextAlign.start,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        focusColor: Colors.white,
        hoverColor: Colors.white,
        contentPadding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: 16,
          right: 16,
        ),
        // labelText: widget.labelText,
        labelStyle: mainStyle(),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        errorStyle: mainStyle().copyWith(
          fontSize: 12,
          color: Colors.red,
        ),
        suffixIcon: widget.isPassword
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: GestureDetector(
                  onTap: () => togglePasswordVisibility(),
                  child: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                    size: 24,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.1),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.1),
            width: 1,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.1),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              color: Colors.red,
            )),
      ),
    );
  }

  Color labelColor() {}
}
