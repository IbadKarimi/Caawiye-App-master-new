class CategoryModel {
  String id;
  String imageName;
  String categoryName;
  String categoryId;


  CategoryModel ({required this.id,required this.imageName, required this.categoryName,required this.categoryId});

  factory CategoryModel .fromJson(Map<String, dynamic> json) {
    return CategoryModel (
        id: json['id'] ?? "",
        imageName: json['imageName'] ?? "",
        categoryName: json['categoryName'] ?? "",
      categoryId: json['categoryId'] ?? "",

    );
  }
}