import 'package:flutter/material.dart';
import '../../../../core/presentation/widgets/app_menu.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),
      drawer: const AppMenu(),
      body: const Center(
        child: Text('Configuración Screen'),
      ),
    );
  }
}
