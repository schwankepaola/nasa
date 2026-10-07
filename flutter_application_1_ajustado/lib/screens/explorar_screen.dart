import 'package:flutter/material.dart';

import 'cosmos_gallery_screen.dart';

class ExplorarScreen extends StatelessWidget {
  final Function(int)? onPaginaSelecionada;

  const ExplorarScreen({
    super.key,
    this.onPaginaSelecionada,
  });

  @override
  Widget build(BuildContext context) {
    return CosmosGalleryScreen(
      consulta: 'nebula',
      paginaSelecionada: 1,
      onPaginaSelecionada:
          onPaginaSelecionada,
    );
  }
}
