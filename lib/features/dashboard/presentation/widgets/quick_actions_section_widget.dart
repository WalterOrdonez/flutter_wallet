import 'package:bam_wallet_transfers/core/presentation/theme/app_colors.dart';
import 'package:bam_wallet_transfers/features/dashboard/presentation/state/dashboard_notifier.dart';
import 'package:bam_wallet_transfers/features/dashboard/presentation/widgets/quick_action_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Sección de acciones rápidas con carrusel horizontal
class QuickActionsSectionWidget extends ConsumerWidget {
  const QuickActionsSectionWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quickActions = ref.watch(
      dashboardNotifierProvider.select((state) => state.quickActions),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Acciones Rápidas',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textGeneral,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: quickActions.length,
              itemBuilder: (context, index) {
                final action = quickActions[index];
                return QuickActionWidget(
                  icon: action.icon,
                  label: action.label,
                  iconColor: action.iconColor,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
