class HospitalModel {
  String id;
  String image;
  String name;
  String city;
  String address;


  HospitalModel ({required this.id,required this.image, required this.name,required this.city,required this.address});

  factory HospitalModel .fromJson(Map<String, dynamic> json) {
    return HospitalModel (
      id: json['id'] ?? "",
      image: json['imageName'] ?? "",
      name: json['hospitalName'] ?? "",
      city: json['city'] ?? "",
      address: json['address']
    );
  }
}