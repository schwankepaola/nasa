import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/favoritos_service.dart';
import '../widgets/photo_card.dart';
import 'detalhe_screen.dart';

class FavoritosScreen extends StatelessWidget {
  final VoidCallback? onExplorar;

  const FavoritosScreen({
    super.key,
    this.onExplorar,
  });

  static const Color verde =
      Color(0xFFC6FF00);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF08090B),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            42,
            35,
            42,
            45,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 18,
                              height: 1,
                              color: verde,
                            ),
                            const SizedBox(
                                width: 8),
                            Text(
                              'SUA COLEÇÃO PESSOAL',
                              style:
                                  GoogleFonts.inter(
                                color: verde,
                                fontSize: 7,
                                fontWeight:
                                    FontWeight.w700,
                                letterSpacing:
                                    1.1,
                              ),
                            ),
                            const SizedBox(
                                width: 8),
                            Text(
                              '/ 002',
                              style:
                                  GoogleFonts.inter(
                                color:
                                    Colors.white24,
                                fontSize: 7,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        RichText(
                          text: TextSpan(
                            style:
                                GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 38,
                              fontWeight:
                                  FontWeight.w300,
                              letterSpacing: -1.8,
                            ),
                            children: const [
                              TextSpan(
                                text: 'Seus ',
                              ),
                              TextSpan(
                                text: 'favoritos.',
                                style: TextStyle(
                                  color: verde,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          'As descobertas que você escolheu guardar.',
                          style:
                              GoogleFonts.inter(
                            color:
                                Colors.white54,
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable:
                        FavoritosService.favoritos,
                    builder: (
                      context,
                      favoritos,
                      child,
                    ) {
                      return Row(
                        children: [
                          Text(
                            favoritos.length
                                .toString()
                                .padLeft(2, '0'),
                            style:
                                GoogleFonts.inter(
                              color: verde,
                              fontSize: 26,
                              fontWeight:
                                  FontWeight.w300,
                            ),
                          ),
                          const SizedBox(
                              width: 6),
                          Text(
                            '/ OBJETOS',
                            style:
                                GoogleFonts.inter(
                              color:
                                  Colors.white38,
                              fontSize: 7,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Container(
                height: 1,
                color:
                    const Color(0xFF202328),
              ),

              const SizedBox(height: 18),

              ValueListenableBuilder(
                valueListenable:
                    FavoritosService.favoritos,
                builder: (
                  context,
                  favoritos,
                  child,
                ) {
                  if (favoritos.isEmpty) {
                    return _vazio(context);
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 28,
                      childAspectRatio: 0.92,
                    ),
                    itemCount: favoritos.length,
                    itemBuilder:
                        (context, index) {
                      final foto =
                          favoritos[index];

                      return PhotoCard(
                        foto: foto,
                        compact: true,
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
              ),

              const SizedBox(height: 55),

              Container(
                height: 1,
                color:
                    const Color(0xFF202328),
              ),

              const SizedBox(height: 30),

              Row(
                children: [
                  Text(
                    'órbita.',
                    style:
                        GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Uma forma de se perder e se encontrar no universo.\n'
                    'Imagens e dados: NASA Open APIs.',
                    style:
                        GoogleFonts.inter(
                      color: Colors.white30,
                      fontSize: 7,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(width: 70),
                  Text(
                    'VOLTAR AO TOPO ↑',
                    style:
                        GoogleFonts.inter(
                      color: Colors.white38,
                      fontSize: 7,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _vazio(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 270,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF24292E),
        ),
        borderRadius:
            BorderRadius.circular(4),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.favorite_border,
              color: verde,
              size: 32,
            ),
            const SizedBox(height: 18),
            Text(
              'Sua coleção começa aqui.',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 17,
                fontWeight:
                    FontWeight.w500,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              'Salve as imagens que chamarem sua atenção para\n'
              'encontrá-las aqui depois.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white54,
                fontSize: 9,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 14),
            GestureDetector(
              onTap: onExplorar,
              child: Text(
                'Explorar imagens  →',
                style: GoogleFonts.inter(
                  color: verde,
                  fontSize: 10,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
