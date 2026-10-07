import 'package:flutter/material.dart';

import 'explorar_screen.dart';
import 'home_screen.dart';

class ExplorarFlowScreen extends StatefulWidget {
  final Function(int) onPaginaSelecionada;

  const ExplorarFlowScreen({
    super.key,
    required this.onPaginaSelecionada,
  });

  @override
  State<ExplorarFlowScreen> createState() =>
      _ExplorarFlowScreenState();
}

class _ExplorarFlowScreenState
    extends State<ExplorarFlowScreen> {
  bool mostrarGaleria = false;

  @override
  Widget build(BuildContext context) {
    if (mostrarGaleria) {
      return ExplorarScreen(
        onPaginaSelecionada:
            widget.onPaginaSelecionada,
      );
    }

    return HomeScreen(
      onExplorar: () {
        setState(() {
          mostrarGaleria = true;
        });
      },
    );
  }
}
