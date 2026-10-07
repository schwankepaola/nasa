import 'package:flutter/material.dart';

import 'cosmos_gallery_screen.dart';

class LuaScreen extends StatelessWidget {
  final Function(int)? onPaginaSelecionada;

  const LuaScreen({
    super.key,
    this.onPaginaSelecionada,
  });

  @override
  Widget build(BuildContext context) {
    return CosmosGalleryScreen(
      consulta: 'Moon',
      paginaSelecionada: 6,
      onPaginaSelecionada:
          onPaginaSelecionada,
    );
  }
}
