import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prayer/logic/api.dart';
import 'package:prayer/logic/auth_manager.dart';
import 'package:prayer/logic/validators.dart';
import 'package:prayer/widget/form_field.dart';
import 'package:prayer/widget/main_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Api api = Api();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
            tr("login"),
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        body: Form(
          key: formKey,
          child: Padding(
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
                    controller: passwordController,
                    validator: (value) => passwordFieldValidator(context, value),
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: autovalidateMode,
                    isPassword: true,
                    maxLines: 1,
                  ),
                  SizedBox(height: 24),
                  ButtonMain(
                    text: tr("login"),
                    loading: loading,
                    tap: login,
                  ),
                  SizedBox(height: 24),
                  Center(
                    child: InkWell(
                      child: Text(tr("dont_have_an_account")),
                      onTap: () => Navigator.of(context).pushReplacementNamed("/register"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    setState(() {
      autovalidateMode = AutovalidateMode.always;
    });
    if (formKey.currentState?.validate() == true) {
      AuthResult login = await AuthManager.instance.login(emailController.text, passwordController.text);
      if (login.success) {
        Navigator.of(context).pushReplacementNamed("/main");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            tr(login.error),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ));
      }
    }
  }
}
