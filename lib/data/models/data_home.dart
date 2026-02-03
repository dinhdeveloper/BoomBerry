import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/data/models/category/category_model.dart';

final List<Category> categoriesDummy = [
  Category(
    categoryId: 0,
    categoryKey: 'ALL',
    categoryName: 'Tất cả',
    categoryImage: Assets.iconCoffeeMenu,
  ),
  Category(
    categoryId: 1,
    categoryKey: 'FOOD',
    categoryName: 'Món ăn',
    categoryImage: Assets.iconFood,
  ),
  Category(
    categoryId: 2,
    categoryKey: 'COFFEE',
    categoryName: 'Cà phê',
    categoryImage: Assets.iconLatteArt,
  ),
  Category(
    categoryId: 3,
    categoryKey: 'MILKTEA',
    categoryName: 'Trà sữa',
    categoryImage: Assets.iconSoftDrinks3d,
  ),
  Category(
    categoryId: 4,
    categoryKey: 'FLOAT',
    categoryName: 'Đá xay',
    categoryImage: Assets.iconFloat,
  ),
  Category(
    categoryId: 5,
    categoryKey: 'CAKE',
    categoryName: 'Bánh ngọt',
    categoryImage: Assets.iconChocolate,
  ),
  Category(
    categoryId: 6,
    categoryKey: 'CREAM',
    categoryName: 'Kem',
    categoryImage: Assets.iconIceCream,
  ),
  Category(
    categoryId: 7,
    categoryKey: 'OTHER',
    categoryName: 'Món thêm',
    categoryImage: Assets.iconReceptionBell,
  ),
];


final List<Map<String, dynamic>> itemsCategoryYouChoose = [
  {"title": "ĐỒ UỐNG CÀ PHÊ", "imageUrl": Assets.imgViewCoffeeCup},
  {"title": "ĐỒ UỐNG KHÔNG CÀ PHÊ", "imageUrl": Assets.imgJuiceCategory},
  {"title": "ĐỒ ĂN – BÁNH NGỌT", "imageUrl": Assets.imgFoodDesserts},
  {"title": "ĂN VẶT - ĂN KÈM", "imageUrl": Assets.imgSnacksSideDishes},
];

final banners = [Assets.imgBanner1, Assets.imgBanner2, Assets.imgBanner3, Assets.imgBanner4, Assets.imgBanner5];