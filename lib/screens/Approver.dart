
import 'package:caawiye_app/screens/HospitalList.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';


import 'homepages.dart';
class Aprovelshee extends StatefulWidget {
  const Aprovelshee({super.key});

  @override
  State<Aprovelshee> createState() => _AprovelsheeState();
}

class _AprovelsheeState extends State<Aprovelshee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  Column(
          children: [

            Padding(
              padding: EdgeInsets.only(top: 110),
              child: Center(

                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.blue,width: 7),
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: Image(
                        image: AssetImage("assets/verify.png"),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text("Waad ku guulaysatay lacag bixinta",style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.blue),),
                    const SizedBox(height: 20),
                    Text(
                      'Waad ku guulaysatay inaad balan u qabsato..',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'dhaqtarkaga Mahadsanid',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 50),
                    Material(
                      child: InkWell(
                        onTap: () {
                          Get.to(kalkaalHospitals());
                        },
                        child: Container(
                          height: 50,
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(50),

                          ),
                          child: Center(
                            child: Text("Arag balantaada",style:
                            TextStyle(
                              fontSize: 20,color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                          ),
                        ),

                      ),
                    ),
                    const SizedBox(height: 140),
                    Column(
                      children: [
                        Text("Waxaad nagala socon kartaa:",style: TextStyle(fontSize: 15),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(onPressed: () {
                              launch('https://wa.me/252770835142?text=');
                            },
                                icon: Icon(FontAwesomeIcons.whatsapp,size: 40,color: Colors.green,)
                            ),
                            IconButton(onPressed: () {
                              launch('https://www.facebook.com/caawiye2030');
                            },
                                icon: Icon(FontAwesomeIcons.facebook,size: 40,color: Colors.blue,)
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10,top: 10),
                              child: InkWell(
                                onTap: () {
                                  launch('https://caawiyeapp.com/');
                                },
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(

                                  ),
                                  child: Image(
                                    height: 30,
                                    image: AssetImage('assets/web2.png'),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )

                  ],
                ),
              ),
            ),
          ],

        )
    );
  }
}
