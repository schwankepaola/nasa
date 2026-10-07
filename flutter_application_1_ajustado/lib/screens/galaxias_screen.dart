import 'package:flutter/material.dart';

import 'cosmos_gallery_screen.dart';

class GalaxiasScreen extends StatelessWidget {
  final Function(int)? onPaginaSelecionada;

  const GalaxiasScreen({
    super.key,
    this.onPaginaSelecionada,
  });

  @override
  Widget build(BuildContext context) {
    return CosmosGalleryScreen(
      consulta: 'galaxy',
      paginaSelecionada: 3,
      onPaginaSelecionada:
          onPaginaSelecionada,
    );
  }
}
