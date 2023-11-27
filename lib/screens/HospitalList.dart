
import 'dart:convert';
import 'package:caawiye_app/screens/AddHospital.dart';
import 'package:caawiye_app/screens/CategoryList.dart';
import 'package:caawiye_app/widgets/catogorywidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/HospitalModel.dart';
import '../widgets/hospitals_list_widgets.dart';
import 'DoctorList.dart';
import 'taqasusyada_kalkaal.dart';

class kalkaalHospitals extends StatefulWidget {
  const kalkaalHospitals({Key? key}) : super(key: key);

  static const String id = 'HospitalsList2';


  @override
  _kalkaalHospitalsState createState() => _kalkaalHospitalsState();
}

class _kalkaalHospitalsState extends State<kalkaalHospitals> {
 static var connectivityResult;

  Future<void> checkConnectivity() async {


      connectivityResult = await Connectivity().checkConnectivity();


    debugPrint("Connection is *******************"+connectivityResult.toString());
  }

  List<dynamic> data=[];
  var isData;
  Future<List<dynamic>> fetchHospitalData() async {
    var response = await http.get(Uri.parse('http://192.168.1.3:8080/Hospital/GetHospitalData.php'));

    if (response.statusCode == 200) {
      // Parse the response body as a list of dynamic objects
      data =await jsonDecode(response.body);
      print(data);
      for (var item in data) {
        setState(() {
          isData=item['imageName'];
          print("===========================================");
        });

        for(int i=0;i<data.length;i++)



        print(item['name']);
      }
      return data;

    } else {
      throw Exception('Failed to load data from the API. Status code: ${response.statusCode}');
    }
  }



  void initState(){
    checkConnectivity();
    fetchHospitalData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Color(0xfff5f9ff),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Hospital List'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                Get.offAll(()=>kalkaalHospitals());



              },
              icon: Icon(Icons.refresh),
            ),

          ],
        ),
        body: connectivityResult.toString() == "ConnectivityResult.none"?

            Center(child:Text("Check you internet connection !",style: TextStyle(color: Colors.black),),):

        isData==null? Center(child: CircularProgressIndicator()):

        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              //----------------------Heres My code my Start
              for (var item in data)
                Column(children: [
                  const SizedBox(height: 10,),
                  Material(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {

                        Get.to(HospitalDepartments( hospitalId: item["id"].toString(),hospitalName: item["hospitalName"].toString()));
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 90,
                        decoration: BoxDecoration(
                          // border: Border.all(color: Colors.grey, width: 2),

                          borderRadius: BorderRadius.circular(10),


                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 120,
                              decoration: BoxDecoration(

                                borderRadius: BorderRadius.circular(10),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.grey,
                                //     blurRadius: 1,
                                //     spreadRadius: 1,
                                //     offset: Offset(2,2),
                                //   ),
                                // ],
                              ),

                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network("http://192.168.1.3:8080/Hospital/"+item['imageName']),
                              ),


                            ),

                            const SizedBox(width: 15),
                          Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 5),
                                  Text(
                                    item['hospitalName'],
                                    style: GoogleFonts.poppins(
                                      fontSize: 20, fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,color: Colors.blue,size: 20,
                                      ),
                                      Text(
                                        item['address']+","+item['city'],style: GoogleFonts.poppins(fontSize: 11,color: Colors.blue),

                                        textAlign: TextAlign.start,
                                      ),
                                    ],

                                  ),
                                  const SizedBox(height: 5),
                                  // Container(
                                  //   width: double.infinity,
                                  //   child: Row(
                                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //     children: [
                                  //       IconButton(
                                  //         onPressed: () {},
                                  //         icon: Icon(
                                  //           Icons.health_and_safety,
                                  //           color: Colors.red,
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  const SizedBox(height: 4),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
                ),




            ],
          ),
        ),





        floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.push(context, MaterialPageRoute(builder: (context){
            return AddHospital();
          }));
    },
    child: Icon(Icons.add), // Icon to be displayed on the button
    backgroundColor: Colors.blue, // Background color of the button
    ),


    );
  }
}
