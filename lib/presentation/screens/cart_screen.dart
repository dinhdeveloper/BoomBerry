import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/core/base_screen.dart';
import 'package:remindbless/data/models/banks/bank_model.dart';
import 'package:remindbless/data/models/products/product_item.dart';
import 'package:remindbless/data/models/products/product_model.dart';
import 'package:remindbless/presentation/providers/background_controller.dart';
import 'package:remindbless/presentation/utils/formatters.dart';
import 'package:remindbless/presentation/widgets/common/app_image.dart';
import 'package:remindbless/presentation/widgets/common/common_glass.dart';
import 'package:remindbless/presentation/widgets/common/header_delegate.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';
import 'package:remindbless/viewmodel/cart_view_model.dart';

class CartScreen extends BaseScreen<CartViewModel> {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}


class _CartScreenState  extends BaseScreenState<CartViewModel, CartScreen>  {
  int quantity = 1;
  List<Bank> bankList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> loadBanks() async {
    bankList = await ProductRepository.loadBanks();
    if (!mounted) return;
    setState(() {});
  }


  @override
  Widget buildChild(BuildContext context) {
    final bgController = context.watch<BackgroundController>();
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: bgController.background,
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: CustomScrollView(
            slivers: [
              /// ===== HEADER PINNED =====
              SliverPersistentHeader(pinned: true, delegate: HeaderDelegate(title: "Giỏ Hàng")),

              /// ===== CART LIST =====
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(delegate: SliverChildBuilderDelegate(
                      (context, index) =>
                      _cartItem(provider.items[index]),
                  childCount: provider.items.length,
                ),),
              ),
            ],
          ),
        ),

        /// ===== BOTTOM CHECKOUT =====
        bottomNavigationBar: provider.items.isNotEmpty ? _bottomCheckout() : SizedBox.shrink(),
      ),
    );
  }

  /// ================= CART ITEM =================
  Widget _cartItem(Product product) {
    return Dismissible(
      key: ValueKey(product.productId),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const UnitText(
          text: "Xóa",
          color: Colors.white,
          fontSize: 16,
          fontFamily: Assets.sfProMedium,
        ),
      ),
      onDismissed: (_) {
        // TODO: remove item khỏi list
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: CommonGlass(
          blur: 40,
          //height: 110,
          //margin: const EdgeInsets.only(bottom: 12),
          paddingChild: 8,
          // decoration: BoxDecoration(
          //   color: Colors.white,
          //   borderRadius: BorderRadius.circular(12),
          //   boxShadow: [
          //     BoxShadow(
          //       color: Colors.black.withOpacity(0.09),
          //       blurRadius: 10,
          //       offset: const Offset(0, 4),
          //     ),
          //   ],
          // ),
          child: Row(
            children: [
              /// IMAGE
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AppImage(
                  imageUrl: product.imagesProduct.isNotEmpty ? product.imagesProduct[0].imageUrl : Assets.imgViewCoffeeCup,
                  width: 80,
                  height: 80,
                ),
              ),

              const SizedBox(width: 12),

              /// INFO
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UnitText(
                      text: product.productName,
                      fontFamily: Assets.sfProLight,
                    ),

                    const SizedBox(height: 6),

                    /// PRICE
                    Row(
                      children: [
                        UnitText(
                          text: formatVND(product.productPriceSale),
                          fontSize: 16,
                          color: Colors.orange,
                          fontFamily: Assets.sfProBold,
                        ),
                        SizedBox(width: 8),
                        UnitText(
                          text: formatVND(product.productPrice),
                          fontSize: 13,
                          color: Colors.black54,
                          lineThrough: true,
                          fontFamily: Assets.sfProRegular,
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    /// QUANTITY
                    Row(
                      children: [
                        _qtyButton(
                          icon: Icons.remove,
                          onTap: () => provider.decrease(product),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: UnitText(
                            text: "${product.quantity}",
                            fontSize: 15,
                            fontFamily: Assets.sfProMedium,
                          ),
                        ),

                        _qtyButton(
                          icon: Icons.add,
                          onTap: () => provider.increase(product),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _qtyButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 28,
        width: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.white),
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }

  /// ================= BOTTOM CHECKOUT =================
  Widget _bottomCheckout() {
    return CommonGlass(
      height: 105,
      colorBlur: Colors.white24,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              /// TOTAL
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const UnitText(text: "Tổng thanh toán", fontSize: 13, color: Colors.white),
                  const SizedBox(height: 4),
                  UnitText(text: formatVND(provider.totalAmount), fontSize: 18, color: Colors.orange, fontFamily: Assets.sfProBold),
                ],
              ),

              const Spacer(),

              /// CHECKOUT BUTTON
              ElevatedButton(
                onPressed: (){
                  loadBanks().then((value) async {
                    final bank = await showBankBottomSheet(context, bankList);
                    if (bank != null) {
                      debugPrint("Selected bank: ${bank.shortName} - BIN: ${bank.bin}");
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
                child: const UnitText(text: "Thanh toán", color: Colors.white, fontSize: 15, fontFamily: Assets.sfProMedium),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Bank?> showBankBottomSheet(
      BuildContext context,
      List<Bank> banks,
      ) {
    return showModalBottomSheet<Bank>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return FractionallySizedBox(
          heightFactor: 0.66, // ⭐ 2/3 màn hình
          child: BankBottomSheet(banks: banks),
        );
      },
    );
  }

}

class BankBottomSheet extends StatelessWidget {
  final List<Bank> banks;

  const BankBottomSheet({super.key, required this.banks});

  @override
  Widget build(BuildContext context) {
    return CommonGlass(
      radius: 16,
      paddingChild: 12,
      colorBlur: Colors.white38,
      child: Column(
        children: [
          /// Drag handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          UnitText(
            text: "Chọn ngân hàng",
            fontSize: 16,
            fontFamily: Assets.sfProBold,
            color: Colors.orange,
          ),

          const SizedBox(height: 12),

          /// LIST SCROLL
          Expanded(
            child: ListView.separated(
              itemCount: banks.length,
              separatorBuilder: (_, __) => const Divider(height: 1,color: Colors.grey),
              itemBuilder: (context, index) {
                final bank = banks[index];

                return InkWell(
                  onTap: () => Navigator.pop(context, bank),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            bank.logo,
                            width: 50,
                            height: 50,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              UnitText(
                                text: bank.shortName,
                                fontSize: 15,
                                fontFamily: Assets.sfProMedium,
                              ),
                              const SizedBox(height: 2),
                              UnitText(
                                text: bank.name,
                                fontSize: 13,
                                color: Colors.white70,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                        UnitText(
                          text: bank.code,
                          fontSize: 12,
                          color: Colors.white54,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

