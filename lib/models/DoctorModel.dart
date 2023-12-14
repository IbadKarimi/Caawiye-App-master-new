class DoctorModel {
  String id;
  String imageName;
  String fullName;

  String experience;
  String fee;
  String categoryId;

  String ? about;
  String ? nationality;


  DoctorModel ({this.nationality,this.about,required this.id,required this.imageName, required this.fullName,required this.experience,required this.fee,required this.categoryId});

  factory DoctorModel .fromJson(Map<String, dynamic> json) {
    return DoctorModel (
      id: json['id'] ?? "",
      imageName: json['imageName'] ?? "",
      fullName: json['fullName'] ?? "",
        experience: json['experience'] ?? "",
        fee: json['fee']??"",
      categoryId: json['categoryId'] ?? "",
      about: json['about'] ?? "",
      nationality: json['nationality'] ?? "",
    );
  }
}