import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:prayer/page/login_screen.dart';
import 'package:prayer/page/main_screen.dart';
import 'package:prayer/page/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('ru', 'RU')],
        path: 'assets/translations',
        fallbackLocale: Locale('en', 'US'),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: tr('app_name'),
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.orange[200],
        fontFamily: 'OpenSans',
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/main': (context) => MainPage(),
        '/login': (context) => LoginPage(),
        // '/create': (context) => CreatePage(),
        // '/settings': (context) => SettingsPage(),
      },
    );
  }
}
