import 'package:flutter/material.dart';
import '../../../../core/presentation/widgets/app_menu.dart';

class TransfersView extends StatelessWidget {
  const TransfersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transferencias')),
      drawer: const AppMenu(),
      body: const Center(
        child: Text('Transferencias Screen'),
      ),
    );
  }
}
