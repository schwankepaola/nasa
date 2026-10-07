import 'package:flutter/material.dart';

import 'cosmos_gallery_screen.dart';

class MarteScreen extends StatelessWidget {
  final Function(int)? onPaginaSelecionada;

  const MarteScreen({
    super.key,
    this.onPaginaSelecionada,
  });

  @override
  Widget build(BuildContext context) {
    return CosmosGalleryScreen(
      consulta: 'Curiosity Mars rover',
      paginaSelecionada: 4,
      onPaginaSelecionada:
          onPaginaSelecionada,
    );
  }
}
