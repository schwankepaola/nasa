
import 'package:flutter/material.dart';

import '../services/favoritos_service.dart';
import '../widgets/photo_card.dart';
import 'detalhe_screen.dart';

class SalvosScreen extends StatelessWidget {
  const SalvosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final escuro = tema.brightness == Brightness.dark;

    final corTexto = escuro
        ? Colors.white
        : const Color(0xFF17191C);

    final corTextoSecundario = escuro
        ? Colors.white54
        : Colors.black54;

    final corIconeVazio = escuro
        ? Colors.white38
        : Colors.black38;

    return Scaffold(
      backgroundColor: tema.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Salvos',
                style: TextStyle(
                  color: corTexto,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Suas imagens favoritas do universo.',
                style: TextStyle(
                  color: corTextoSecundario,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 25),

              Expanded(
                child: ValueListenableBuilder<List>(
                  valueListenable: FavoritosService.favoritos,
                  builder: (context, favoritos, child) {
                    if (favoritos.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.favorite_border,
                              color: corIconeVazio,
                              size: 55,
                            ),

                            const SizedBox(height: 15),

                            Text(
                              'Você ainda não tem favoritos.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: corTextoSecundario,
                                fontSize: 15,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              'Explore o universo e salve suas imagens preferidas.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: corTextoSecundario,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final largura = constraints.maxWidth;

                        final colunas = largura >= 1100
                            ? 4
                            : largura >= 650
                                ? 3
                                : largura >= 400
                                    ? 2
                                    : 1;

                        return GridView.builder(
                          padding: const EdgeInsets.only(
                            bottom: 20,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: colunas,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio:
                                colunas == 1 ? 1.4 : 1.0,
                          ),
                          itemCount: favoritos.length,
                          itemBuilder: (context, index) {
                            final foto = favoritos[index];

                            return PhotoCard(
                              foto: foto,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetalheScreen(
                                      foto: foto,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
