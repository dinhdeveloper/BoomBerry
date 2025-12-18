import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/core/app_theme.dart';
import 'package:remindbless/data/models/data_home.dart';
import 'package:remindbless/data/models/products/product_item.dart';
import 'package:remindbless/presentation/utils/formatters.dart';
import 'package:remindbless/presentation/widgets/common/bottom_bar_widget.dart';
import 'package:remindbless/presentation/widgets/common/ticket_common.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  int _selectedIndex = 0;
  bool _loading = true;

  final ScrollController _categoryScrollController = ScrollController();
  final List<GlobalKey> _categoryKeys = List.generate(itemsHomeCategory.length, (_) => GlobalKey());

  List<ProductItem> _products = [];

  // ---------------- INIT ----------------
  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final categoryId = args?['categoryId'];

    if (categoryId != null) {
      final index = itemsHomeCategory.indexWhere((e) => e.idCategory == categoryId);

      if (index != -1) {
        _selectedIndex = index;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToSelectedCategory();
        });
      }
    }
  }

  @override
  void dispose() {
    _categoryScrollController.dispose();
    super.dispose();
  }

  // ---------------- LOAD DATA ----------------
  Future<void> _loadProducts() async {
    _products = await ProductRepository.loadProducts();
    setState(() => _loading = false);
  }

  // ---------------- FILTER PRODUCT ----------------
  List<ProductItem> get filteredProducts {
    final categoryId = itemsHomeCategory[_selectedIndex].idCategory;

    if (categoryId == 'ALL') return _products;

    return _products.where((e) => e.categoryId == categoryId).toList();
  }

  // ---------------- AUTO SCROLL ----------------
  void _scrollToSelectedCategory() {
    final ctx = _categoryKeys[_selectedIndex].currentContext;
    if (ctx == null) return;

    Scrollable.ensureVisible(ctx, duration: const Duration(milliseconds: 320), curve: Curves.easeOutCubic, alignment: 0.5);
  }

  // ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    final currentCategory = itemsHomeCategory[_selectedIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(currentCategory.label),
            _buildCategoryHorizontal(),
            const SizedBox(height: 10),
            Expanded(child: _loading ? const Center(child: CircularProgressIndicator()) : _buildProductGrid()),
          ],
        ),
      ),
      bottomNavigationBar: bottomBarDetail(onTap: () => Navigator.of(context).pop()),
    );
  }

  // ---------------- HEADER ----------------
  Widget _buildHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: UnitText(text: title, fontSize: 18, fontFamily: Assets.sfProSemibold),
    );
  }

  // ---------------- CATEGORY BAR ----------------
  Widget _buildCategoryHorizontal() {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        controller: _categoryScrollController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemCount: itemsHomeCategory.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final isSelected = index == _selectedIndex;

          return GestureDetector(
            onTap: () {
              setState(() => _selectedIndex = index);
              WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToSelectedCategory());
            },
            child: Container(
              key: _categoryKeys[index],
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: isSelected ? AppColors.colorButtonHome : Colors.grey[100], borderRadius: BorderRadius.circular(20)),
              child: UnitText(text: itemsHomeCategory[index].label, fontSize: 14, color: isSelected ? Colors.white : Colors.black87),
            ),
          );
        },
      ),
    );
  }

  // ---------------- PRODUCT GRID ----------------
  Widget _buildProductGrid() {
    if (filteredProducts.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(Assets.iconEmptyData, width: 100),
            const SizedBox(height: 10),
            UnitText(text: 'Không có sản phẩm', fontFamily: Assets.sfProThin, fontSize: 15),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
      itemCount: filteredProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 120 / 170,
      ),
      itemBuilder: (context, index) {
        final product = filteredProducts[index];

        return CouponCard(
          curvePosition: 145,
          curveRadius: 15,
          borderRadius: 10,
          decoration: const BoxDecoration(color: Colors.white),
          borderColor: Colors.black12,
          firstChild: _productImage(product),
          secondChild: _productInfo(product),
        );
      },
    );
  }

  Widget _productImage(ProductItem product) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(product.image, height: 140, width: double.infinity, fit: BoxFit.cover),
      ),
    );
  }

  Widget _productInfo(ProductItem product) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: double.maxFinite,
      decoration: const BoxDecoration(
        border: DashedBorder(dashLength: 2, top: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UnitText(text: product.name, fontFamily: Assets.sfProLight, fontWeight: FontWeight.w500, fontSize: 15, maxLines: 2),
          const Spacer(),
          if (product.priceSale.isNotEmpty)
            Row(
              children: [
                UnitText(text: "-50%", fontFamily: Assets.sfProMedium, fontSize: 12, color: Colors.green[500]),
                const SizedBox(width: 5),
                UnitText(
                  text: formatVND(int.parse(product.priceSale)),
                  fontFamily: Assets.sfProMedium,
                  fontSize: 12,
                  lineThrough: true,
                  color: Colors.grey,
                  lineThroughColor: Colors.grey,
                ),
              ],
            ),
          UnitText(
            text: "${formatVND(int.parse(product.price))} VNĐ",
            fontFamily: Assets.sfProMedium,
            fontWeight: FontWeight.w700,
            fontSize: 16,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
