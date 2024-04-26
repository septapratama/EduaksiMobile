import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final String labelText;
  final String? initialValue;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool obscureText;
  final IconData? prefixIcon;

  const CustomTextFieldWidget({
    Key? key,
    required this.labelText,
    this.initialValue,
    this.keyboardType = TextInputType.text,
    required this.controller,
    this.obscureText = false,
    this.prefixIcon,
  }) : super(key: key);

  @override
  _CustomTextFieldWidgetState createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  late FocusNode _focusNode;
  late TextEditingController _textEditingController;
  bool _isObscured = true;
  bool _isEditingEnabled = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _textEditingController = widget.controller;
    if (widget.initialValue != null) {
      _textEditingController.text = widget.initialValue!;
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  void _toggleObscureText() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  void _toggleEditing() {
    setState(() {
      _isEditingEnabled = !_isEditingEnabled;
      if (!_isEditingEnabled) {
        _focusNode.unfocus(); // Unfocus the text field when editing is disabled
      }
    });
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    // Check if the password contains at least one alphabet and one number
    if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).+$').hasMatch(value)) {
      return 'Password must contain at least one alphabet and one number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: TextFormField(
        controller: _textEditingController,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText ? _isObscured : false,
        focusNode: _focusNode,
        readOnly:
            !_isEditingEnabled, // Make the text field read-only when editing is not enabled
        validator: _passwordValidator, // Validate the password
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: _focusNode.hasFocus
                ? Color.fromRGBO(30, 84, 135, 1)
                : Colors.black,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
          alignLabelWithHint: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Color.fromRGBO(30, 84, 135, 1)),
          ),
          floatingLabelBehavior: FloatingLabelBehavior
              .always, // Ensure the label remains visible even after clicking on the input field
          prefixIcon:
              widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
          suffixIcon: widget.obscureText
              ? GestureDetector(
                  onTap: _toggleObscureText,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 27.0),
                        child: IconButton(
                          onPressed: _toggleObscureText,
                          icon: Icon(
                            _isObscured
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: _toggleEditing,
                            child: Icon(
                              _isEditingEnabled
                                  ? Icons
                                      .done // Change to a check mark when editing is enabled
                                  : Icons
                                      .edit, // Change to pencil icon when editing is disabled
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : GestureDetector(
                  onTap: _toggleEditing,
                  child: Icon(
                    _isEditingEnabled
                        ? Icons
                            .done // Change to a check mark when editing is enabled
                        : Icons
                            .edit, // Change to pencil icon when editing is disabled
                  ),
                ),
          suffixIconConstraints: BoxConstraints(
            minWidth: 40,
            minHeight: 40,
          ),
        ),
      ),
    );
  }
}
