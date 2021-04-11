import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;
  final String separator;

  MaskedTextInputFormatter({
    @required this.mask,
    @required this.separator,
  }) { assert(mask != null); assert (separator != null); }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.text.length > 0) {
      if(newValue.text.length > oldValue.text.length) {
        if(newValue.text.length > mask.length) return oldValue;
        if(newValue.text.length < mask.length && mask[newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text: '${oldValue.text}$separator${newValue.text.substring(newValue.text.length-1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}

String ordinaryFieldValidator(BuildContext context, String value, int maxLength, bool req, {String customRequiredMessage}) {
  if (value.isEmpty && req) {
    return customRequiredMessage = tr('required_field'); //'This field is required'
  }
  // if (value.length > maxLength) {
  //   return 'Maximální délka je $maxLength znaků';
  // }
  return null;
}

String emailFieldValidator(BuildContext context, String value, {dynamic result, bool wrongEmail = false}) {
  Pattern pattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (wrongEmail == true) {
    return tr('wrong_email'); //'Email or password is not correct';
  }
  if (result != null && result.usedEmail) {
    return tr('email_already_used'); //'This email is already used';
  } else if (value.isEmpty) {
    return tr('email_empty'); //'Email is required';
  } else {
    if (!regex.hasMatch(value)) {
      return tr('wrong_email_format'); //'Please enter correct email';
    } else {
      return null;
    }
  }
}

// String originalPasswordFieldValidator(BuildContext context, String value, {dynamic result}) {
//   Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{1,}$';
//   RegExp regex = RegExp (pattern);
//   if ((result != null && result.wrongPassword)
//     || (value.isNotEmpty && value.length < 8)) {
//     return AppLocalizations.of(context).translate('password_short');//'Password is too short (min. 8 characters)';
//   } else if (value.isEmpty) {
//     return AppLocalizations.of(context).translate('enter_password');//'Please enter the original password';
//   } else if (!regex.hasMatch(value)) {
//     return AppLocalizations.of(context).translate('wrong_password_format');
//   }
//   return null;
// }

String passwordFieldValidator(BuildContext context, String value, {dynamic result}) {
  Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{1,}$';
  RegExp regex = RegExp (pattern);
  if ((result != null && result.wrongPassword)
    || (value.isNotEmpty && value.length < 8)) {
    return tr('password_short'); //'Password is too short (min. 8 characters)';
  } else if (value.isEmpty) {
    return tr('enter_password'); //'Please enter password';
  } else if (!regex.hasMatch(value)) {
    return tr('wrong_password_format');
  }
  return null;
}

String password2FieldValidator(BuildContext context, String value, TextEditingController firstPasswordController) {
  if (value.isNotEmpty && value != firstPasswordController.text) {
    return tr('passwords_not_match'); //'Passwords do not match';
  } else if (value.isEmpty) {
    return tr('enter_password'); //'Please enter password';
  } 
  return null;
}

String passwordBasicFieldValidator(BuildContext context, String value) {
  if (value.isEmpty) {
    return tr('enter_password'); //'Please enter password';
  } 
  return null;
}

/*
INFO: use in case app allows to change email.
*/
String currentEmailFieldValidator(BuildContext context, String value, {dynamic result, bool wrongEmail = false}) {
  Pattern pattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (wrongEmail == true) {
    return tr('wrong_email'); //'Email or password is not correct';
  }
  // if (result != null && result.usedEmail) {
  //   return AppLocalizations.of(context).translate('email_already_used'); //'This email is already used';
  // } else 
  if (value.isEmpty) {
    return tr('email_empty'); //'Email is required';
  } else {
    if (!regex.hasMatch(value)) {
      return tr('wrong_email_format'); //'Please enter correct email';
    } else {
      return null;
    }
  }
}

/*
INFO: use in case app allows to change password - meaning enter current password -> enter new password.
!!! Not the same as password recovery.
*/
String currentPasswordFieldValidator(BuildContext context, String value, {dynamic result}) {
  Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{1,}$';
  RegExp regex = RegExp (pattern);
  if ((result != null && result.wrongPassword)
    || (value.isNotEmpty && value.length < 8)) {
    return tr('password_short'); // Condition if password has less than min. required characters;
  } else if (value.isEmpty) {
    return tr('enter_password'); // Condition if text field is empty
  } else if (!regex.hasMatch(value)) {
    return tr('wrong_password_format'); // Condition if password does not match "pattern"
  }
  return null;
}
