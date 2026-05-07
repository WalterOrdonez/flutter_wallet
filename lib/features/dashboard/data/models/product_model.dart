import 'package:bam_wallet_transfers/features/dashboard/domain/entities/product.dart';
import 'package:flutter/material.dart';

/// Modelo de datos de un producto bancario.
/// Simula la estructura que vendría de una API.
class ProductDataModel {
  final String id;
  final String productType;
  final String balance;
  final String accountNumber;
  final String holderName;
  final int backgroundColorHex;
  final int accentColorHex;
  final int iconCodePoint;

  const ProductDataModel({
    required this.id,
    required this.productType,
    required this.balance,
    required this.accountNumber,
    required this.holderName,
    required this.backgroundColorHex,
    required this.accentColorHex,
    required this.iconCodePoint,
  });

  /// Crea un modelo desde un mapa JSON
  factory ProductDataModel.fromJson(Map<String, dynamic> json) {
    return ProductDataModel(
      id: json['id'] as String? ?? '',
      productType: json['productType'] as String? ?? '',
      balance: json['balance'] as String? ?? '',
      accountNumber: json['accountNumber'] as String? ?? '',
      holderName: json['holderName'] as String? ?? '',
      backgroundColorHex: json['backgroundColorHex'] as int? ?? 0xFF000000,
      accentColorHex: json['accentColorHex'] as int? ?? 0xFF000000,
      iconCodePoint: json['iconCodePoint'] as int? ?? 0xe0b0,
    );
  }

  /// Convierte el modelo a la entidad de dominio
  Product toEntity() {
    return Product(
      id: id,
      productType: productType,
      balance: balance,
      accountNumber: accountNumber,
      holderName: holderName,
      backgroundColor: Color(backgroundColorHex),
      accentColor: Color(accentColorHex),
      icon: IconData(iconCodePoint, fontFamily: 'MaterialIcons'),
    );
  }
}
