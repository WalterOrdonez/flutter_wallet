import 'package:flutter/material.dart';
import '../../../../core/presentation/widgets/app_menu.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historial')),
      drawer: const AppMenu(),
      body: const Center(
        child: Text('Historial Screen'),
      ),
    );
  }
}
