import 'dart:convert';

class Customer{
  int pat_id;
  String fullname;
  String age;
  String gander;
  String address;
  String amount;
  String phone;
  String password;
  String refferalcode;
  String images;



  Customer(
      this.pat_id,
      this.fullname,
      this.age,
      this.gander,
      this.address,
      this.amount,
      this.phone,
      this.password,
      this.refferalcode,
      this.images,

      );

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(

      int.parse(json["pat_id"]),
         json["fullname"],
         json["age"],
         json["gander"],
         json["address"],
         json["amount"],
         json["phone"],
        json["password"],
        json["refferalcode"],
        json["images"],
      );

   Map<String, dynamic> toJson() =>
       {
         'pat_id': pat_id.toString(),
         'fullname': fullname,
         'age': age,
         'gander': gander,
         'address': address,
         'amount': amount,
         'phone': phone,
         'password': password,
         'refferalcode': refferalcode,
         'images': images,
       };

}