import 'dart:convert';

import 'package:caawiye_app/screens/CategoryList.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';
import 'package:like_button/like_button.dart';


import '../main.dart';
import '../widgets/Calaender.dart';
import '../widgets/SocialIconButton_icon.dart';
import 'package:http/http.dart' as http;

import 'Approver.dart';
class doctorAppointments extends StatefulWidget {
  String imagePath;
  String fullName;
  String fee;
  String experience;
  String categoryName;
  String nationality;
  String about;
  String hospitalName;
  // final hospitalDoctors doctorhospital;
  doctorAppointments(this.imagePath,this.fullName,this.fee,this.experience,this.categoryName,this.nationality,this.about,this.hospitalName);

  @override
  _doctorAppointmentsState createState() => _doctorAppointmentsState();
}

class _doctorAppointmentsState extends State<doctorAppointments> {

  var formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var addressController = TextEditingController();
  var tellController = TextEditingController();
  var AmountController = TextEditingController();
  var doctorController = TextEditingController();
  var bookingkk = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  Color _selectedColor = Colors.orange;
  static var connectivityResult;

  Future<void> checkConnectivity() async {


    connectivityResult = await Connectivity().checkConnectivity();


    debugPrint("Connection is *******************"+connectivityResult.toString());
  }

  // registerAppointments() async
  // {
  //
  //   var url=Uri.parse(API.booking);
  //
  //   var req=http.MultipartRequest("POST",url);
  //
  //   req.fields['fullname']=doctorhospital.doctorname;
  //   req.fields['age']=ageController.text;
  //   req.fields['address']=addressController.text;
  //   req.fields['phone']=tellController.text;
  //   req.fields['doctors']=doctorhospital.id.toString();
  //   // req.fields['appointment_date']=bookingkk.text;
  //
  //   await req.send().then((result) {
  //
  //     http.Response.fromStream(result).then((response) {
  //
  //       // var message = jsonDecode(response.body);
  //
  //     print(response.body);
  //     });
  //
  //   }).catchError((e) {
  //
  //     print(e);
  //
  //   });
  //
  //
  // }
  Future<void> AddAppointment(BuildContext context)async{
    try{
      String uri="http://192.168.1.3:8080/Hospital/PostAppointment.php";

      var res=await http.post(Uri.parse(uri),body: {

        "patientName":nameController.text.toString(),
        "address":addressController.text.toString(),
        "amount":AmountController.text.toString(),
        "age":ageController.text.toString(),
        "number":tellController.text.toString(),
        "appointmentDate":_selectedDate.toString(),
        "doctorName":widget.fullName.toString(),
        "paymentStatus":"Sucessfully".toString(),
        "hospitalName":widget.hospitalName,
        "category":widget.categoryName,


      });
      var response=jsonDecode(res.body);
      int lastInsertedId = response["id"]; // yahan string declare kiya wa tha id int me arahe thi
      if(response["success"]==true){


        if(lastInsertedId!=null){
          Get.offAll(()=>Aprovelshee());
        }

        // print("====================================>"+lastInsertedId.toString());
        //Get.to(()=>DoctorList(hospitalName: widget.hospitalName,categoryId:widget.categoryId,));
        print("Uploaded");
      }else{
        print("Error");
      }

    }catch(e){
      print("Error Appointment:"+e.toString());
    }

  }
 void makePaymentRequest(BuildContext context) async {
   String uri="http://192.168.1.3:8080/Hospital/Payment.php";// Replace with your actual PHP script URL

    Map<String, dynamic> postData = {
      'phone':tellController.text,
      'amount':AmountController.text,
      // Add any other required parameters here
    };


      final response = await http.post(Uri.parse(uri), body: postData);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);

        bool success = responseData['success'];
        String payStatus = responseData['payStatus'];

       debugPrint("Sucess********************************"+success.toString());

        if (success==true )  {

          if(payStatus=="Success"){
            AddAppointment(context);
          }




      } else {
        // Handle error response
        print('Transaction Errorssssss: ${response.statusCode}');
      }

  }}




  @override
  Widget build(BuildContext context) {
    String fullName=widget.fullName;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xfff5f9ff),


        body: connectivityResult.toString() == "ConnectivityResult.none"?

        Center(child:Text("Check you internet connection !",style: TextStyle(color: Colors.black),),):

        fullName==null? Center(child: CircularProgressIndicator()):
        ListView(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 250,

                  // tag: widget.doctorhospital.id,
                  child: CachedNetworkImage(
                    imageUrl: widget.imagePath,

                    fit: BoxFit.cover,
                  ),

                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.blue,
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(top: 5),
                //   child: Positioned(
                //     top: MediaQuery.of(context).padding.top,
                //     left: 0,
                //     right: 0,
                //     child: Container(
                //       color: Colors.transparent,
                //       child: Row(
                //         children: [
                //
                //           //back
                //           IconButton(
                //             onPressed: ()
                //             {
                //               Get.back();
                //             },
                //             icon: const Icon(
                //               Icons.arrow_back,
                //               color: Colors.blue,
                //             ),
                //           ),
                //
                //
                //
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),


            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.7,
                        child: Row(
                          children: [
                            Text(
                              widget.fullName,
                              style: TextStyle(fontSize: 14,
                                  fontWeight: FontWeight.w700),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 10,),
                            Padding(padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Icon(Icons.verified, color: Colors.blue,
                                  size: 20,)),
                          ],

                        ),


                      ),
                      // Icon(Icons.verified,color: Colors.blue,),
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                // RatingBar.builder(
                                //   minRating: 1,
                                //   itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
                                //   updateOnDrag: true,
                                //   onRatingUpdate: (rating) =>
                                //   this.rating = rating,
                                //
                                //
                                //
                                //
                                //
                                //   itemSize: 13,
                                //
                                //
                                // ),

                              ],
                            ),
                          ],
                        ),
                      )


                    ],
                  ),
                  const SizedBox(height: 5,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SocialIconButton1(
                              icon: Icon(
                                FontAwesomeIcons.stethoscope,
                                color: Colors.blue,
                              ),
                              onPressed: () {},
                            ),
                            const SizedBox(height: 10,),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Text("cardiology",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.blue),
                                textAlign: TextAlign.justify,
                              ),
                            ),


                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width:10),
                            Padding(
                              padding: const EdgeInsets.only(left:5),
                              child: Text(
                                "fee",
                                style: TextStyle(fontSize: 15,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w800),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ).tr(),
                            ),
                            Text(
                              ":"+widget.fee,
                              style: TextStyle(fontSize: 15,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w800),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ],

                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: 130,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                    ),
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          widget.nationality,
                          style: GoogleFonts.poppins(
                            fontSize: 14, letterSpacing: 1,),)),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 165,
                        height: 40,

                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(

                          child: Row(
                            children: [
                              SizedBox(width: 30,),
                              Text("experience", style:
                              TextStyle(fontSize: 14,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                              ).tr(),
                              Text(':'+widget.experience, style:
                              TextStyle(fontSize: 14,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 165,
                        height: 40,

                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('nationality', style:
                            TextStyle(fontSize: 14,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                            ).tr(),
                            Text(":"+widget.nationality.toString(), style:
                            TextStyle(fontSize: 14,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("the_patient", style: TextStyle(fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),).tr(),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 165,
                            height: 40,

                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(right: 105),
                              child: TextButton(
                                onPressed: () {},
                                child: Text("Aniga", style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),).tr(),
                              ),
                            ),

                          ),

                        ],
                      ),
                SizedBox(height:5),
                Column(
                  children: [
                    HorizontalCalendar(
                      date: DateTime.now(),
                      textColor: Colors.black45,
                      backgroundColor: Colors.white,
                      selectedColor: Colors.blue,
                      showMonth:true,
                      locale: Localizations.localeOf(context),
                      onDateSelected: (date) {
                        setState(() {
                          _selectedDate=date;
                        });
                        print(date.toString());
                      },
                    ),

                    SizedBox(height: 20),

                    SizedBox(height: 20),
                    // Add your time-related widgets here
                    // For example, you can use a TimePicker or build your own time selection UI
                  ],
                ),
                      const SizedBox(height: 10),
                      Form(
                        key: formkey,
                        child: Column(
                          children: [
                            TextFormField(

                              controller: nameController,


                              decoration: InputDecoration(
                                label: Text("fullName").tr(),
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(

                              controller: ageController,


                              decoration: InputDecoration(
                                label: Text("age").tr(),
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.date_range),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: addressController,



                              decoration: InputDecoration(
                                label: Text("Address").tr(),
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.location_on),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: AmountController,
                              validator: (value){

                              },
                              keyboardType: TextInputType.streetAddress,
                              decoration: InputDecoration(
                               label:Text("fee").tr(),
                                hintStyle: TextStyle(
                                    color: Colors.white, fontSize: 22),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),

                                disabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                prefixIcon: Icon(FontAwesomeIcons.dollarSign,
                                  color: Colors.white,),
                                filled: true,
                                fillColor: Colors.blue.shade400,

                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: tellController,


                              decoration: InputDecoration(
                                label: Text("phone").tr(),
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.call),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),


                    ],
                  ),
                  const SizedBox(height: 16),
                  // Container(
                  //   width: double.infinity,
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Text(
                  //             'SubProducts',
                  //             style:TextStyle(
                  //               fontWeight: FontWeight.w500,
                  //               fontSize: 20,
                  //             ),
                  //           ),
                  //           TextButton(
                  //             onPressed: () =>
                  //                 Navigator.pushNamed(context, DoctorScreen.id),
                  //             child: Text(
                  //               'View all',
                  //               style: TextStyle(),
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //       const SizedBox(height: 10),
                  //       SizedBox(
                  //         height: 210,
                  //         child: FutureBuilder<List<Doctors>>(
                  //             future: getDoctors(),
                  //             builder: (context, snapshot)  {
                  //               switch (snapshot.connectionState) {
                  //                 case ConnectionState.waiting:
                  //                   return Center(child:  CircularProgressIndicator(),);
                  //                 default:
                  //                   if(snapshot.data != null ){
                  //                     List<Doctors> data = snapshot.data!;
                  //                     return ListView.builder(
                  //                         scrollDirection: Axis.horizontal,
                  //                         shrinkWrap: true,
                  //                         itemCount: data.length,
                  //                         itemBuilder: (context, index) =>
                  //                             Padding(padding: EdgeInsets.symmetric(horizontal: 6),
                  //                               child: DoctorDeitls(doctor: data[index],),
                  //                             )
                  //
                  //
                  //                     );
                  //                   }else{
                  //                     return Center(child: Text('No Data Found..'),);
                  //                   }
                  //               }
                  //
                  //
                  //             }
                  //         ),
                  //       ),
                  //       // const SizedBox(height: 10),
                  //       // SizedBox(
                  //       //   height: 200,
                  //       //   width: double.infinity,
                  //       //   child: ListView.builder(
                  //       //     scrollDirection: Axis.horizontal,
                  //       //     itemCount: 5,
                  //       //     itemBuilder: (context, index) => Padding(
                  //       //       padding: const EdgeInsets.only(right: 4),
                  //       //       // child: ProductCard(),
                  //       //       child: Text('Product'),
                  //       //     ),
                  //       //   ),
                  //       // ),
                  //       const SizedBox(height: 16),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),


        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Material(
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        // color: Theme.of(context).primaryColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: LikeButton(
                        // onTap: (val) async {
                        //   return true;
                        // },
                        isLiked: true,
                        size: 40,
                        circleColor: CircleColor(
                          start: Color(0xff00ddff),
                          end: Color(0xff0099cc),
                        ),
                        bubblesColor: BubblesColor(
                          dotPrimaryColor: Colors.red,
                          dotSecondaryColor:
                          Theme
                              .of(context)
                              .primaryColor
                              .withOpacity(0.15),
                        ),
                        likeBuilder: (bool isLiked) =>
                            Icon(
                              Icons.health_and_safety,
                              color: isLiked
                                  ? Colors.red
                                  : Colors.grey,
                              size: 40,
                            ),
                        likeCount: 0,
                        countBuilder: (count, isLiked, text) => Text(''),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 4,
                child: InkWell(
                  onTap: () {
                    if (formkey.currentState!.validate()) {

                      makePaymentRequest(context);

                    }

                    // Get.to(PaymentPage());
                    // saveNewOrderInfo();


                    // Get.to(CaawiyeLoginScreen());
                    // c.addBooking(widget.doctorhospital);
                  },

                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade400,
                      borderRadius: BorderRadius.circular(5),

                    ),
                    child: Center(
                      child: Text("pay", style:
                      TextStyle(
                        fontSize: 20, color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      ).tr(),
                    ),
                  ),

                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
