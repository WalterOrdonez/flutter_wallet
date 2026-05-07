import 'package:flutter/material.dart';

/// Entidad de dominio que representa una acción rápida del dashboard
class QuickAction {
  final String id;
  final IconData icon;
  final String label;
  final Color iconColor;

  const QuickAction({
    required this.id,
    required this.icon,
    required this.label,
    required this.iconColor,
  });
}
