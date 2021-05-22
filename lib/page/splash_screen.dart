import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((_) => success());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orangeAccent,
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "🙏🏻",
              style: TextStyle(fontSize: 88),
            ),
            SizedBox(height: 24),
            Text(
              tr("app_name").toUpperCase(),
              style: TextStyle(fontSize: 42, color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ],
        )));
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
