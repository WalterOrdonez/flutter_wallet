import 'package:bam_wallet_transfers/core/presentation/theme/app_colors.dart';
import 'package:bam_wallet_transfers/features/dashboard/presentation/state/dashboard_notifier.dart';
import 'package:bam_wallet_transfers/features/dashboard/presentation/state/dashboard_state.dart';
import 'package:bam_wallet_transfers/features/dashboard/presentation/widgets/page_indicator_widget.dart';
import 'package:bam_wallet_transfers/features/dashboard/presentation/widgets/products_carousel_widget.dart';
import 'package:bam_wallet_transfers/features/dashboard/presentation/widgets/quick_actions_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/presentation/widgets/app_menu.dart';

/// Vista principal del dashboard.
/// Compone los widgets de productos y acciones rápidas.
/// Todo el estado se maneja a través de Riverpod.
class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardNotifierProvider);

    // Escucha errores para mostrar snackbar
    ref.listen<DashboardState>(dashboardNotifierProvider, (previous, next) {
      if (next.status == DashboardStatus.error && next.errorMessage != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.errorMessage!)));
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      drawer: const AppMenu(),
      body: dashboardState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  ProductsCarouselWidget(),
                  SizedBox(height: 12),
                  PageIndicatorWidget(),
                  SizedBox(height: 28),
                  QuickActionsSectionWidget(),
                  SizedBox(height: 24),
                ],
              ),
            ),
    );
  }
}
