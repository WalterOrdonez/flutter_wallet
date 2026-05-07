import 'package:bam_wallet_transfers/features/dashboard/presentation/state/dashboard_notifier.dart';
import 'package:bam_wallet_transfers/features/dashboard/presentation/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Carrusel de productos bancarios (Tarjetas, Cuentas, Préstamos).
/// Soporta drag horizontal y tap en los bordes para cambiar de página.
/// La lógica de navegación se delega al DashboardNotifier.
class ProductsCarouselWidget extends ConsumerStatefulWidget {
  const ProductsCarouselWidget({super.key});

  @override
  ConsumerState<ProductsCarouselWidget> createState() =>
      _ProductsCarouselWidgetState();
}

class _ProductsCarouselWidgetState
    extends ConsumerState<ProductsCarouselWidget> {
  final PageController _pageController = PageController(viewportFraction: 0.85);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(
      dashboardNotifierProvider.select((state) => state.products),
    );

    // Escucha cambios en el índice para animar el PageController
    ref.listen<int>(
      dashboardNotifierProvider.select((state) => state.currentProductIndex),
      (previous, next) {
        if (_pageController.hasClients &&
            _pageController.page?.round() != next) {
          _pageController.animateToPage(
            next,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
    );

    return SizedBox(
      height: 220,
      child: Stack(
        children: [
          // Carrusel de tarjetas
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: products.length,
            onPageChanged: (index) {
              ref
                  .read(dashboardNotifierProvider.notifier)
                  .updateCurrentProductIndex(index);
            },
            itemBuilder: (context, index) {
              final product = products[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ProductCardWidget(
                  productType: product.productType,
                  balance: product.balance,
                  accountNumber: product.accountNumber,
                  holderName: product.holderName,
                  backgroundColor: product.backgroundColor,
                  accentColor: product.accentColor,
                  icon: product.icon,
                ),
              );
            },
          ),

          // Zona de tap izquierda (ir a página anterior)
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: 40,
            child: GestureDetector(
              onTap: () {
                ref
                    .read(dashboardNotifierProvider.notifier)
                    .goToPreviousProduct();
              },
              behavior: HitTestBehavior.translucent,
              child: const SizedBox.expand(),
            ),
          ),

          // Zona de tap derecha (ir a página siguiente)
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: 40,
            child: GestureDetector(
              onTap: () {
                ref.read(dashboardNotifierProvider.notifier).goToNextProduct();
              },
              behavior: HitTestBehavior.translucent,
              child: const SizedBox.expand(),
            ),
          ),
        ],
      ),
    );
  }
}
