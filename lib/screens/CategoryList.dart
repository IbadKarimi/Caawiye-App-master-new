
import 'package:caawiye_app/models/CategoryModel.dart';
import 'package:caawiye_app/screens/AddCategory.dart';
import 'package:caawiye_app/screens/AddSliderImage.dart';
import 'package:caawiye_app/screens/DoctorList.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import '../widgets/cart10.dart';
import '../widgets/cart11.dart';
import '../widgets/cart12.dart';
import '../widgets/home_carousel.dart';
import 'AddDoctor.dart';
import 'package:http/http.dart' as http;

class HospitalDepartments extends StatefulWidget {
  String hospitalId;
  String hospitalName;
  HospitalDepartments({required this.hospitalId,required this.hospitalName});

  @override
  State<HospitalDepartments> createState() => _HospitalDepartments();
}

class _HospitalDepartments extends State<HospitalDepartments> {

  static var connectivityResult;

  Future<void> checkConnectivity() async {


    connectivityResult = await Connectivity().checkConnectivity();


    debugPrint("Connection is *******************"+connectivityResult.toString());
  }
  String? _hospitalId;

  List<CategoryModel> data=[];
  var isCategoryData;

  Future<void> _fetchCategoryData() async {
    //create function in list type becoze we get data and set in _product array
    var response = await http
        .get(Uri.parse('http://192.168.1.7:8080/Hospital/GetCategoryDataWithHId.php?hospitalId=${widget.hospitalId}'));

    //the scope of the array is Inside the function
    if (response.statusCode == 200) {
      debugPrint("Api is Working !");
      var prJson = json.decode(response.body);
      //Mistake Identify Here

      for (var jsonData in prJson) {
        data.add(CategoryModel.fromJson(jsonData)); //set json data in productlist
      }

    } else {
      debugPrint("Api is not Working !");
    }
    for(int i=0;i<data.length;i++){
      setState(() {
        isCategoryData=data[i].categoryName;
        print(data[i].categoryName);
      });

    }
  }

  List<dynamic> hospitalData=[];
  List<dynamic> sliderImage=[];

  var isHospitalData;
  var isSliderData;





  Future<List<dynamic>> fetchSliderImage() async {
    var response1 = await http.get(Uri.parse('http://192.168.1.7:8080/Hospital/GetSliderImageHId.php?hospitalId=${widget.hospitalId}'));
    // var response = await http.get(Uri.parse('http://192.168.1.6:8080/Hospital/GetCategoryData.php'));

    if (response1.statusCode == 200) {
      // Parse the response body as a list of dynamic objects
      sliderImage =await jsonDecode(response1.body);

      for (var item in sliderImage)
        setState(() {
          isSliderData=item['imageName'];
          print("===========================================");

            });




      return sliderImage;

    } else {
      throw Exception('Failed to load data from the API. Status code: ${response1.statusCode}');
    }
  }








  void initState(){
    // _hospitalId = int.parse(widget.hospitalId) as String?;
    print("Hospital Id is :"+widget.hospitalId);
    print("Hospital Name is :"+widget.hospitalName);
    checkConnectivity();
    _fetchCategoryData();
    fetchSliderImage();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:  connectivityResult.toString() == "ConnectivityResult.none"?

        Center(child:Text("Check you internet connection !",style: TextStyle(color: Colors.black),),):

      isCategoryData==null && isSliderData==null? Center(child: CircularProgressIndicator()):





        ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 0, ),
              child: Stack(
                children: [
                  HomeCarousel(
                    images: [
                     /* 'https://i.imgur.com/Q7IxnQD.png',
                      'https://i.imgur.com/6qgdV42.png',
                      'https://i.imgur.com/tSYmKvQ.png',
                      'https://i.imgur.com/TunJzZJ.png',*/
                      for (var item in sliderImage)
                        "http://192.168.1.7:8080/Hospital/${item['imageName']}",
                    ],
                  ),






                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Positioned(
                      top: MediaQuery.of(context).padding.top,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          children: [

                            //back
                            IconButton(
                              onPressed: ()
                              {
                                Get.back();
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.blue,
                                size: 30,
                              ),
                            ),



                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),


            ),
            Row(

              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(10),
                      color: Colors.blue
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding( padding: EdgeInsets.only(left: 40) ,child: Text("13_specialties",style: TextStyle(color: Colors.white,fontSize: 18),).tr()),
                      Padding(padding: EdgeInsets.only(right: 40) ,child: Text("doctor",style: TextStyle(color: Colors.white,fontSize: 18),).tr()),
                    ],
                  ),
                ),

              ],
            ),

            InkWell(
              onTap: (){
                Get.to(()=>AddSliderImage(hospitalId: widget.hospitalId, hospitalName: widget.hospitalName));
              },
              child: Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Container(

                    child: Row(
                      children: [
                        Padding( padding: EdgeInsets.only(left: 10) ,child:
                        Text("slider_images",style: TextStyle(color: Colors.blue,fontSize: 18),).tr()),
                        Padding(
                          padding: const EdgeInsets.only(top:0),
                          child: IconButton(onPressed: (){}, icon: Icon(Icons.add_circle)),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(top:10,right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1,color: Colors.grey),
                      borderRadius: BorderRadius.circular(30)
                    ),
                  ),


                ],
              ),
            ),
            SizedBox(

              height:MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                  padding: EdgeInsets.only(top: 30,left: 20,right: 20),
                  child:





                  /*  Category10(),
                          Category11(),
                          Category12(),*/
                  // category starts here

                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Number of columns in the grid
                      crossAxisSpacing: 20.0, // Spacing between columns
                      mainAxisSpacing: 10.0, // Spacing between rows
                    ),
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      // You can check the type of the item and customize the widget accordingly
                      dynamic item;
                      dynamic categoryName;
                      dynamic id;

                      item = data[index].imageName;
                      categoryName = data[index].categoryName;
                      id = data[index].id;

                      return id==null ? Container():
                      Material(
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            print("Hospital Name is ===============?"+widget.hospitalName);
                           Get.to(()=>DoctorList(categoryName: categoryName, categoryId: id,hospitalName: widget.hospitalName,));// only need category id here

                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.blue.shade50),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),

                                      ),

                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),

                                      ),
                                      child: Image.network("http://192.168.1.7:8080/Hospital/" + item, fit: BoxFit.cover,),

                                    ),
                                  ),
                                  const SizedBox(height: 7),
                                  Center(
                                    child: Text(
                                      categoryName,
                                      style: TextStyle(fontSize: 12, color: Colors.black),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),

                                ],
                              )

                          ),
                        ),
                      );
                    },

                  )




              ),


            ),




          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {

            Navigator.push(context, MaterialPageRoute(builder: (context){
              return AddCategory(hospitalId:widget.hospitalId, hospitalName: widget.hospitalName);
            }));
          },
          child: Icon(Icons.add), // Icon to be displayed on the button
          backgroundColor: Colors.blue, // Background color of the button
        ),
      ),
    );
  }
}
