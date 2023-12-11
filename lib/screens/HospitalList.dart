
import 'dart:convert';
import 'package:caawiye_app/screens/AddHospital.dart';
import 'package:caawiye_app/screens/CategoryList.dart';
import 'package:caawiye_app/widgets/catogorywidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:easy_localization/easy_localization.dart';
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


 List<HospitalModel> data = [];
 var isData;
 Future<void> _fetchHospitalData() async {
   //create function in list type becoze we get data and set in _product array
   var response = await http
       .get(Uri.parse('http://192.168.43.238:8080/Hospital/GetHospitalData.php'));

   //the scope of the array is Inside the function
   if (response.statusCode == 200) {
     debugPrint("Api is Working !");
     var prJson = json.decode(response.body);
      //Mistake Identify Here

     for (var jsonData in prJson) {
       data.add(HospitalModel.fromJson(jsonData)); //set json data in productlist
     }

   } else {
     debugPrint("Api is not Working !");
   }
   for(int i=0;i<data.length;i++){
     setState(() {
       isData=data[i].name;

       print(data[i].name);
     });

   }
 }

 Future<void> checkConnectivity() async {


      connectivityResult = await Connectivity().checkConnectivity();


    debugPrint("Connection is *******************"+connectivityResult.toString());
  }






  void initState(){
    checkConnectivity();
_fetchHospitalData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(

debugShowCheckedModeBanner: false,
         home:Scaffold(

            backgroundColor: Color(0xfff5f9ff),
            appBar:
            AppBar(
              backgroundColor: Colors.blue,
              title: Text('Hospital_List').tr(),
              actions: [

                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                ),
                IconButton(
                  onPressed: () {
                   // Get.refresh();



                  },
                  icon: Icon(Icons.refresh),
                ),

                _buildPopupMenuButton(),

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
                  for (int i=0;i<data.length;i++)
                    Column(children: [
                      const SizedBox(height: 10,),
                      Material(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {

                            Get.to(HospitalDepartments( hospitalId: data[i].id.toString(),hospitalName: data[i].name.toString()));
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
                                    child: Image.network("http://192.168.43.238:8080/Hospital/"+ data[i].image),
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
                                        data[i].name,
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
                                            data[i].address+","+ data[i].city,style: GoogleFonts.poppins(fontSize: 11,color: Colors.blue),

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

              Get.to(()=>AddHospital());
        },
        child: Icon(Icons.add), // Icon to be displayed on the button
        backgroundColor: Colors.blue, // Background color of the button
        ),


        ),
    );

  }
 Widget _buildPopupMenuButton() {
   return PopupMenuButton<String>(
     onSelected: (String result) {
       if(result=="Somali")
       context.setLocale(Locale('so', 'SO'));
       if(result=="English")
         context.setLocale(Locale('en', 'US'));
       if(result=="Turkey")
         context.setLocale(Locale('tr', 'TR'));
       if(result=="Urdu")
         context.setLocale(Locale('ur', 'PK'));
       if(result=="Arabic")
         context.setLocale(Locale('ar', 'SA'));

     },
     itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
       PopupMenuItem<String>(
         value: 'Somali',
         child: Text('Somali'),
       ),
       PopupMenuItem<String>(
         value: 'English',
         child: Text('English'),
       ),
       PopupMenuItem<String>(
         value: 'Urdu',
         child: Text('Urdu'),
       ),
       PopupMenuItem<String>(
         value: 'Turkey',
         child: Text('Turkey'),
       ),
       PopupMenuItem<String>(
         value: 'Arabic',
         child: Text('Arabic'),
       ),
     ],
   );
 }

}
