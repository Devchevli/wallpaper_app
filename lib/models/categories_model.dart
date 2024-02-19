class CategoryModel {
  String catName;
  String catImgUrl;

  CategoryModel({required this.catName, required this.catImgUrl});

  static CategoryModel fromApi2App(Map<String, dynamic> category) {
    return CategoryModel(
        catImgUrl: category['imageUrl'], catName: category["CategoryName"]);
  }
}
