import 'package:remindbless/core/app_assets.dart';

class HomeCategoryItem {
  final String idCategory;
  final String assetPath;
  final String label;
  const HomeCategoryItem(this.idCategory, this.assetPath, this.label);
}

final List<HomeCategoryItem> itemsHomeCategory = [
  HomeCategoryItem("ALL", Assets.iconCoffeeMenu, 'Tất cả'),
  HomeCategoryItem("FOOD", Assets.iconFood, 'Món ăn'),
  HomeCategoryItem("COFFEE", Assets.iconLatteArt, 'Cà phê'),
  HomeCategoryItem("MILKTEA", Assets.iconSoftDrinks3d, 'Trà sữa'),
  HomeCategoryItem("FLOAT", Assets.iconFloat, 'Đá xay'),
  HomeCategoryItem("CAKE", Assets.iconChocolate, 'Bánh ngọt'),
  HomeCategoryItem("CREAM", Assets.iconIceCream, 'Kem'),
  HomeCategoryItem("OTHER", Assets.iconReceptionBell, 'Món thêm'),
];

final jsonMegaSale = {
  "items": [
    {"title": "Americano", "discount": "-10%", "oldPrice": 55000, "price": 49500, "imageUrl": Assets.iconColdCoffeeCup},
    {"title": "Hamburger", "discount": "-50%", "oldPrice": 65000, "price": 55000, "imageUrl": Assets.imgHamburger},
    {"title": "Buritto", "discount": "-30%", "oldPrice": 45000, "price": 40000, "imageUrl": Assets.imgBuritto},
    {"title": "Cake", "discount": "-20%", "oldPrice": 40000, "price": 32000, "imageUrl": Assets.imgCake},
    {"title": "Cold Brew", "discount": "-25%", "oldPrice": 38000, "price": 28500, "imageUrl": Assets.iconCoffee2},
    {"title": "Carrot Juice", "discount": "-15%", "oldPrice": 42000, "price": 35700, "imageUrl": Assets.imgCarrotJuice},
    {"title": "Spoghetti", "discount": "-35%", "oldPrice": 50000, "price": 32500, "imageUrl": Assets.imgSpoghetti},
  ],
};

final List<Map<String, dynamic>> itemsCategoryYouChoose = [
  {"title": "ĐỒ UỐNG CÀ PHÊ", "imageUrl": Assets.imgViewCoffeeCup},
  {"title": "ĐỒ UỐNG KHÔNG CÀ PHÊ", "imageUrl": Assets.imgJuiceCategory},
  {"title": "ĐỒ ĂN – BÁNH NGỌT", "imageUrl": Assets.imgFoodDesserts},
  {"title": "ĂN VẶT - ĂN KÈM", "imageUrl": Assets.imgSnacksSideDishes},
];

final banners = [Assets.imgBanner1, Assets.imgBanner2, Assets.imgBanner3, Assets.imgBanner4, Assets.imgBanner5];
