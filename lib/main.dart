import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/HospitalList.dart'; // Import the file containing kalkaalHospitals widget

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    supportedLocales: [
      Locale('so', 'SO'),
      Locale('en', 'US'), // Change the start locale to English
      Locale('ar', 'SA'), // Arabic
      Locale('tr', 'TR'), // Turkish
      Locale('ur', 'PK'), // Urdu
    ],
    fallbackLocale: Locale('so', 'SO'),
    path: 'assets/translations',
    startLocale: Locale('so', 'SO'), // Change the start locale to English
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Caawiye App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(body: kalkaalHospitals()),
    );
  }
}
