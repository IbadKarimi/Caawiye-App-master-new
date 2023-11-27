

import 'dart:convert';
import 'package:caawiye_app/screens/bookingpage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;




class DoctorList extends StatefulWidget {
  String categoryName;
  String categoryId;


  DoctorList({required this.categoryName,required this.categoryId});

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

  double rating = 0;
  List<dynamic> data=[];
  var isData;
  Future<List<dynamic>> fetchDoctorData() async {
    var response = await http.get(Uri.parse('http://192.168.1.3:8080/Hospital/GetDoctorData.php'));

    if (response.statusCode == 200) {
      // Parse the response body as a list of dynamic objects
      data =await jsonDecode(response.body);
      print(data);
      for (var item in data) {
        setState(() {
          isData=item['imageName'];
          print("===========================================");
        });


      }
      return data;

    } else {
      throw Exception('Failed to load data from the API. Status code: ${response.statusCode}');
    }
  }

  List<dynamic> hospitalData=[];
// coursel image get from here




  void initState(){
    checkConnectivity();
    fetchDoctorData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f9ff),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Dalbo Dhaqtarka',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600) ),
        centerTitle: true,

        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {

              Get.offAll(()=>DoctorList(categoryName: widget.categoryName, categoryId: widget.categoryId));

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
            for(var item in data)
              if(item["categoryId"]==widget.categoryId)

                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Material(
                        color: Colors.brown.shade50,
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)
                            => doctorAppointments("http://192.168.1.3:8080/Hospital/"+item['imageName']
                                ,item['fullName'],item['fee'],item['experience'],""),

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
                                    child: Image.network("http://192.168.1.3:8080/Hospital/"+item['imageName'],fit: BoxFit.cover,),
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
                                            item['fullName'],
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
                                              Text(
                                                "Experience:"+item['experience'],
                                                style: TextStyle(fontSize: 14, color: Colors.black54),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),

                                              const SizedBox(height: 5),
                                              Text(
                                                "Fee:"+item['fee'],
                                                style: TextStyle(fontSize: 14,  color: Colors.black54),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
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

    );
  }
}


