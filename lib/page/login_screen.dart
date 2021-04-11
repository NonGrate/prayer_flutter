import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prayer/logic/api.dart';
import 'package:prayer/logic/validators.dart';
import 'package:prayer/styles/styles.dart';
import 'package:prayer/widget/form_field.dart';
import 'package:prayer/widget/main_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Api api = Api();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr("login"),
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          heightFactor: 2,
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
              ),
              SizedBox(height: 24),
              ButtonMain(
                text: tr("login"),
                loading: loading,
                tap: success,
              ),
            ],
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
