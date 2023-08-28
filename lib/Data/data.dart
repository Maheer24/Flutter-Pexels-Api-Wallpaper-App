import 'package:pixel/Model/category_model.dart';

List<CategoryModel> getCategory() {
  List<CategoryModel> category = [];
  CategoryModel categoryModel = CategoryModel();

  categoryModel.imageUrl =
      "https://images.pexels.com/photos/57416/cat-sweet-kitty-animals-57416.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";
  categoryModel.categoryName = 'Cat';
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.imageUrl =
      "https://images.pexels.com/photos/997567/pexels-photo-997567.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";
  categoryModel.categoryName = 'Winter';
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.imageUrl =
      "https://images.pexels.com/photos/1137752/pexels-photo-1137752.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";
  categoryModel.categoryName = 'Street Art';
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.imageUrl =
      "https://images.pexels.com/photos/2662116/pexels-photo-2662116.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";
  categoryModel.categoryName = 'Landscape';
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.imageUrl =
      "https://images.pexels.com/photos/3694016/pexels-photo-3694016.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";
  categoryModel.categoryName = 'Purple';
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.imageUrl =
      "https://images.pexels.com/photos/20967/pexels-photo.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";
  categoryModel.categoryName = 'Museum';
  category.add(categoryModel);
  categoryModel = CategoryModel();

  return category;
}
