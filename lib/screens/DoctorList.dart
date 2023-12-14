

import 'dart:convert';
import 'package:caawiye_app/screens/bookingpage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../models/DoctorModel.dart';




class DoctorList extends StatefulWidget {
  String categoryName;
  String categoryId;
  String hospitalName;


  DoctorList({required this.categoryName,required this.categoryId,required this.hospitalName});

  //static const String id = 'DoctorsListScreen';


  @override
  _DoctorList createState() => _DoctorList();
}

class _DoctorList extends State<DoctorList> {
  // final MyController c = Get.put(MyController());

  static var connectivityResult;

  Future<void> checkConnectivity() async {


    connectivityResult = await Connectivity().checkConnectivity();


    debugPrint("Connection is *******************"+connectivityResult.toString());
  }

  List<DoctorModel> data=[];
  var isData;
  Future<void> _fetchDoctorData() async {
    //create function in list type becoze we get data and set in _product array
    var response = await http
        .get(Uri.parse('http://192.168.1.7:8080/Hospital/GetDoctorData.php'));

    //the scope of the array is Inside the function
    if (response.statusCode == 200) {
      debugPrint("Api is Working !");
      var prJson = json.decode(response.body);
      //Mistake Identify Here

      for (var jsonData in prJson) {
        data.add(DoctorModel.fromJson(jsonData)); //set json data in productlist
      }

    } else {
      debugPrint("Api is not Working !");
    }
    for(int i=0;i<data.length;i++){
      setState(() {
        isData=data[i].fullName;
        print(data[i].fullName);
        print(data[i].categoryId);
      });

    }
  }
  double rating = 0;



  List<dynamic> hospitalData=[];
// coursel image get from here




  void initState(){
    checkConnectivity();
    _fetchDoctorData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xfff5f9ff),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('order_doctor',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600) ).tr(),
          centerTitle: true,

          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {

                Get.offAll(()=>DoctorList(categoryName: widget.categoryName, categoryId: widget.categoryId,hospitalName: "",));

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
              for(int i=0;i<data.length;i++)
                if(data[i].categoryId==widget.categoryId)

                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Material(
                          color: Colors.brown.shade50,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)
                              => doctorAppointments("http://192.168.1.7:8080/Hospital/"+data[i].imageName
                                  ,data[i].fullName,data[i].fee,data[i].experience,widget.categoryName,data[i].nationality!,data[i].about!,widget.hospitalName)

                            )),
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 110,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 10),
                                    width: 100,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      // color: Colors.blue,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network("http://192.168.1.7:8080/Hospital/"+data[i].imageName,fit: BoxFit.cover,),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 150),
                                          child: Row(
                                            children: [
                                              Row(
                                                children: [
                                                  RatingBar.builder(
                                                    minRating: 1,
                                                    itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
                                                    updateOnDrag: true,
                                                    onRatingUpdate: (rating) =>
                                                    this.rating = rating,





                                                    itemSize: 13,


                                                  ),

                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data[i].fullName,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              widget.categoryName,
                                              style: TextStyle(fontSize: 13, color: Colors.blue),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                            const SizedBox(height: 5,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "experience",
                                                      style: TextStyle(fontSize: 14, color: Colors.black54),
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    ).tr(),
                                                    Text(
                                                      ":"+data[i].experience,
                                                      style: TextStyle(fontSize: 14, color: Colors.black54),
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    )
                                                  ],
                                                ),

                                                const SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "fee",
                                                      style: TextStyle(fontSize: 14,  color: Colors.black54),
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    ).tr(),
                                                    Text(
                                                      ":"+data[i].fee,
                                                      style: TextStyle(fontSize: 14,  color: Colors.black54),
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    )
                                                  ],
                                                ),


                                                Padding(
                                                  padding: EdgeInsets.only(right: 10),
                                                  child: Icon(
                                                    Icons.video_call, color: Colors.blue,
                                                  ),
                                                )

                                              ],
                                            ),
                                          ],
                                        ),






                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
            ],
          ),
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


