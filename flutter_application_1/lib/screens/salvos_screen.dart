import 'package:flutter/material.dart';

import '../services/favoritos_service.dart';
import '../widgets/photo_card.dart';
import 'detalhe_screen.dart';

class SalvosScreen extends StatelessWidget {
  const SalvosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF080A0C),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                'Salvos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Suas imagens favoritas do universo.',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 25),

              Expanded(
                child:
                    ValueListenableBuilder<
                        List>(
                  valueListenable:
                      FavoritosService.favoritos,
                  builder: (
                    context,
                    favoritos,
                    child,
                  ) {
                    if (favoritos.isEmpty) {
                      return const Center(
                        child: Column(
                          mainAxisSize:
                              MainAxisSize.min,
                          children: [
                            Icon(
                              Icons
                                  .favorite_border,
                              color:
                                  Colors.white38,
                              size: 55,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Você ainda não tem favoritos.',
                              style:
                                  TextStyle(
                                color:
                                    Colors.white54,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 1.15,
                      ),
                      itemCount:
                          favoritos.length,
                      itemBuilder:
                          (context, index) {
                        final foto =
                            favoritos[index];

                        return PhotoCard(
                          foto: foto,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}