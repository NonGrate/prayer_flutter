import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prayer/logic/api.dart';
import 'package:prayer/widget/main_button.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
            tr("logout"),
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
                ButtonMain(
                  text: tr("logout"),
                  loading: loading,
                  tap: success,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void success() {
    Navigator.of(context).pushReplacementNamed("/login");
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
