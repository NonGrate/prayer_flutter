import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prayer/logic/api.dart';
import 'package:prayer/logic/validators.dart';
import 'package:prayer/styles/styles.dart';
import 'package:prayer/widget/form_field.dart';
import 'package:prayer/widget/main_button.dart';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final Api api = Api();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  TextEditingController textController = TextEditingController(text: '');
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool loading = false;

  String selectedLanguage = "English";

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
            tr("create_prayer"),
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
                  tr("what_to_pray_about"),
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 4),
                AppFormField(
                  controller: textController,
                  validator: (value) => ordinaryFieldValidator(context, value, 1000, true),
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.multiline,
                  autovalidateMode: autovalidateMode,
                  maxLines: 5,
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      tr("select_language"),
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 16),
                    DropdownButton(
                      value: selectedLanguage,
                      items: [
                        DropdownMenuItem<String>(child: Text("English"), value: "English",),
                        DropdownMenuItem<String>(child: Text("Русский"), value: "Русский",),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedLanguage = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 24),
                ButtonMain(
                  text: tr("create_prayer"),
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
