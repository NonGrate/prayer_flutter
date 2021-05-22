import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prayer/logic/api.dart';
import 'package:prayer/logic/validators.dart';
import 'package:prayer/widget/form_field.dart';
import 'package:prayer/widget/main_button.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final Api api = Api();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            tr("register"),
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            heightFactor: 1.5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr("email"),
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 4),
                AppFormField(
                  controller: emailController,
                  validator: (value) => emailFieldValidator(context, value),
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: autovalidateMode,
                  maxLines: 1,
                ),
                SizedBox(height: 16),
                Text(tr("password"), style: TextStyle(fontSize: 16)),
                SizedBox(height: 4),
                AppFormField(
                  controller: emailController,
                  validator: (value) => passwordFieldValidator(context, value),
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: autovalidateMode,
                  maxLines: 1,
                  isPassword: true,
                ),
                SizedBox(height: 24),
                ButtonMain(
                  text: tr("register"),
                  loading: loading,
                  tap: success,
                ),
                SizedBox(height: 24),
                Center(
                  child: InkWell(
                    child: Text(tr("have_an_account")),
                    onTap: () => Navigator.of(context).pushReplacementNamed("/login"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void success() {
    Navigator.of(context).pushReplacementNamed("/main");
  }

// void login() async {
//   var _prayers;
//   if (selectedUse == PrayerCardUse.SELECTED) {
//     _prayers = await api.loadSelectedPrayers();
//   } else if (selectedUse == PrayerCardUse.FEED) {
//     _prayers = await api.loadPrayers();
//   } else if (selectedUse == PrayerCardUse.OWN) {
//     _prayers = await api.loadMyPrayers();
//   }
//
//   setState(() {
//     prayers = _prayers;
//   });
// }
}
