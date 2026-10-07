import 'package:flutter/material.dart';

import 'cosmos_gallery_screen.dart';

class TerraScreen extends StatelessWidget {
  final Function(int)? onPaginaSelecionada;

  const TerraScreen({
    super.key,
    this.onPaginaSelecionada,
  });

  @override
  Widget build(BuildContext context) {
    return CosmosGalleryScreen(
      consulta: 'Earth ISS aurora',
      paginaSelecionada: 5,
      onPaginaSelecionada:
          onPaginaSelecionada,
    );
  }
}
