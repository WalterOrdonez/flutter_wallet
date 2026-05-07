import 'package:bam_wallet_transfers/features/dashboard/domain/entities/quick_action.dart';
import 'package:flutter/material.dart';

/// Modelo de datos de una acción rápida.
/// Simula la estructura que vendría de una API.
class QuickActionDataModel {
  final String id;
  final int iconCodePoint;
  final String label;
  final int iconColorHex;

  const QuickActionDataModel({
    required this.id,
    required this.iconCodePoint,
    required this.label,
    required this.iconColorHex,
  });

  /// Crea un modelo desde un mapa JSON
  factory QuickActionDataModel.fromJson(Map<String, dynamic> json) {
    return QuickActionDataModel(
      id: json['id'] as String? ?? '',
      iconCodePoint: json['iconCodePoint'] as int? ?? 0xe0b0,
      label: json['label'] as String? ?? '',
      iconColorHex: json['iconColorHex'] as int? ?? 0xFF000000,
    );
  }

  /// Convierte el modelo a la entidad de dominio
  QuickAction toEntity() {
    return QuickAction(
      id: id,
      icon: IconData(iconCodePoint, fontFamily: 'MaterialIcons'),
      label: label,
      iconColor: Color(iconColorHex),
    );
  }
}
