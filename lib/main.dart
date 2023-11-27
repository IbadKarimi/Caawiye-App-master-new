
import 'package:caawiye_app/screens/AddDoctor.dart';
import 'package:caawiye_app/screens/AddHospital.dart';
import 'package:caawiye_app/screens/CategoryList.dart';
import 'package:caawiye_app/screens/DoctorList.dart';
import 'package:caawiye_app/screens/homepages.dart';
import 'package:caawiye_app/screens/HospitalList.dart';
import 'package:caawiye_app/screens/spalsh_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity/connectivity.dart';

Future<void> main()async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  Future<void> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    print(connectivityResult);
  }

  void initState(){
    checkConnectivity();

  }


  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print("Connectivity Status: $result");
    });
    return GetMaterialApp(
      title: 'Caawiye App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       scaffoldBackgroundColor: Colors.white,
      ),
      home: kalkaalHospitals(),
      routes: {

        splash.id: (_) => splash(),
        // DoctorsListScreen.id: (_) => DoctorsListScreen(),
      },
    );
  }

}

