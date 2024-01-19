import 'package:flutter/material.dart';
import 'package:go_super/utils/constants.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class CustomEmailFormField extends StatelessWidget {
  final TextEditingController controller;
  const CustomEmailFormField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      obscureText: false,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.email),
        prefixIconColor: Constants.primaryColor,
        labelText: 'Email',
        labelStyle: TextStyle(
            fontFamily: 'Gagalin', color: Constants.primaryColor, fontSize: 20),
        hintText: 'Enter your email',
        contentPadding: EdgeInsetsDirectional.only(top: 25, bottom: 10),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Constants.primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Constants.primaryColor),
        ),
      ),
      validator: Validators.email('Invalid email address'),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  final bool obscureText;
  final IconData prefixIcon;
  final String hintText;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.labelText,
    required this.obscureText,
    required this.prefixIcon,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        prefixIconColor: Constants.primaryColor,
        labelText: labelText,
        labelStyle: const TextStyle(
            fontFamily: 'Gagalin', color: Constants.primaryColor, fontSize: 20),
        hintText: hintText,
        contentPadding: const EdgeInsetsDirectional.only(top: 25, bottom: 10),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Constants.primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Constants.primaryColor),
        ),
      ),
      validator: Validators.required('Please fill in this field'),
    );
  }
}

class DOBTextField extends StatelessWidget {
  final TextEditingController controller;

  const DOBTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.calendar_month),
        prefixIconColor: Constants.primaryColor,
        labelText: 'Date of Birth',
        labelStyle: TextStyle(
            fontFamily: 'Gagalin', color: Constants.primaryColor, fontSize: 20),
        hintText: 'YYYY-MM-DD',
        contentPadding: EdgeInsetsDirectional.only(top: 25, bottom: 10),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Constants.primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Constants.primaryColor),
        ),
      ),
      keyboardType: TextInputType.datetime,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your date of birth';
        }
        return null;
      },
    );
  }
}

// class CustomDOBFormField extends StatefulWidget {
//   final TextEditingController dobController;
//   final Function(String?)? onTapDate;

//   const CustomDOBFormField({
//     Key? key,
//     required this.dobController,
//     this.onTapDate,
//   }) : super(key: key);

//   @override
//   _CustomDOBFormFieldState createState() => _CustomDOBFormFieldState();
// }

// class _CustomDOBFormFieldState extends State<CustomDOBFormField> {
//   Future<String?> _onTapDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );

//     if (picked != null) {
//       final formattedDate =
//           '${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
//       setState(() {
//         widget.dobController.text = formattedDate;
//       });
//       return formattedDate;
//     }
//     return null;
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final String? selectedDate = await _onTapDate(context);
//     if (selectedDate != null && widget.onTapDate != null) {
//       widget.onTapDate!(selectedDate);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: widget.dobController,
//       keyboardType: TextInputType.datetime,
//       readOnly: true,
//       onTap: () {
//         _selectDate(context);
//       },
//       decoration: const InputDecoration(
//         // Your decoration properties
//       ),
//       validator: (value) {
//         // Your validation logic
//       },
//     );
//   }
// }

class CustomPassFormField extends StatefulWidget {
  final TextEditingController controller;

  const CustomPassFormField({
    super.key,
    required this.controller,
  });

  @override
  State<CustomPassFormField> createState() => _CustomPassFormFieldState();
}

class _CustomPassFormFieldState extends State<CustomPassFormField> {
  bool _obscureText = true;
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.text,
      obscureText: _obscureText,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_open_outlined),
        prefixIconColor: Constants.primaryColor,
        suffixIcon: IconButton(
          onPressed: _togglePasswordVisibility,
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Constants.primaryColor,
          ),
        ),
        suffixIconColor: Constants.primaryColor,
        labelText: 'Password',
        labelStyle: const TextStyle(
            fontFamily: 'Gagalin', color: Constants.primaryColor, fontSize: 20),
        hintText: 'Enter your password',
        contentPadding: const EdgeInsetsDirectional.only(top: 25, bottom: 10),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Constants.primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Constants.primaryColor),
        ),
      ),
      validator: Validators.compose([
        Validators.required('Password is required'),
        Validators.patternString(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
            'Invalid Password')
      ]),
    );
  }
}

class ConfirmPassFormField extends StatefulWidget {
  final TextEditingController controller;

  const ConfirmPassFormField({
    super.key,
    required this.controller,
  });

  @override
  State<ConfirmPassFormField> createState() => _ConfirmPassFormState();
}

class _ConfirmPassFormState extends State<ConfirmPassFormField> {
  bool _obscureText = true;
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.text,
      obscureText: _obscureText,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_open_outlined),
        prefixIconColor: Constants.primaryColor,
        suffixIcon: IconButton(
          onPressed: _togglePasswordVisibility,
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Constants.primaryColor,
          ),
        ),
        suffixIconColor: Constants.primaryColor,
        labelText: 'Confirm Password',
        labelStyle: const TextStyle(
            fontFamily: 'Gagalin', color: Constants.primaryColor, fontSize: 20),
        hintText: 'Confirm your password',
        contentPadding: const EdgeInsetsDirectional.only(top: 25, bottom: 10),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Constants.primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Constants.primaryColor),
        ),
      ),
      validator: Validators.compose([
        Validators.required('Password is required'),
        Validators.patternString(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
            'Invalid Password')
      ]),
    );
  }
}
