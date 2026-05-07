import 'package:bam_wallet_transfers/core/presentation/theme/app_colors.dart';
import 'package:bam_wallet_transfers/features/dashboard/presentation/state/dashboard_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Indicador de puntos del carrusel de productos.
/// Soporta tap en cada punto para navegar a esa página via el notifier.
class PageIndicatorWidget extends ConsumerWidget {
  const PageIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsCount = ref.watch(
      dashboardNotifierProvider.select((state) => state.products.length),
    );
    final currentIndex = ref.watch(
      dashboardNotifierProvider.select((state) => state.currentProductIndex),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        productsCount,
        (index) => GestureDetector(
          onTap: () {
            ref.read(dashboardNotifierProvider.notifier).goToProduct(index);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: currentIndex == index ? 20 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: currentIndex == index
                    ? AppColors.primary
                    : AppColors.divider.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
