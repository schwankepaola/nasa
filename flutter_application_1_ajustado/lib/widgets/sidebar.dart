import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Sidebar extends StatelessWidget {
  final int paginaSelecionada;
  final Function(int) onPaginaSelecionada;
  final VoidCallback? onVisitarNasa;

  const Sidebar({
    super.key,
    required this.paginaSelecionada,
    required this.onPaginaSelecionada,
    this.onVisitarNasa,
  });

  static const Color verde = Color(0xFFC6FF00);
  static const Color fundo = Color(0xFF0A0B0D);
  static const Color fundoSelecionado = Color(0xFF182218);
  static const Color linha = Color(0xFF202328);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: fundo,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ============================================================
          // LOGO
          // ============================================================

          Container(
            height: 64,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: linha,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: verde,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.all_inclusive,
                    color: Colors.black,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 9),
                Text(
                  'órbita.',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),

          // ============================================================
          // CONTEÚDO DA SIDEBAR
          // ============================================================

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),

                  // ======================================================
                  // MENU PRINCIPAL
                  // ======================================================

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 17,
                    ),
                    child: Text(
                      'MENU PRINCIPAL',
                      style: GoogleFonts.inter(
                        color: Colors.white30,
                        fontSize: 7,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  _itemMenu(
                    icone: Icons.grid_view_outlined,
                    texto: 'Explorar',
                    indice: 1,
                    mostrarSeta: true,
                  ),

                  _itemMenu(
                    icone: Icons.favorite_border,
                    texto: 'Salvos',
                    indice: 2,
                  ),

                  const SizedBox(height: 20),

                  // ======================================================
                  // LINHA
                  // ======================================================

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Container(
                      height: 1,
                      color: linha,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // ======================================================
                  // EXPLORE O COSMOS
                  // ======================================================

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 17,
                    ),
                    child: Text(
                      'EXPLORE O COSMOS',
                      style: GoogleFonts.inter(
                        color: Colors.white30,
                        fontSize: 7,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  _itemCosmos(
                    texto: 'Galáxias',
                    indice: 3,
                  ),

                  _itemCosmos(
                    texto: 'Marte',
                    indice: 4,
                  ),

                  _itemCosmos(
                    texto: 'Terra',
                    indice: 5,
                  ),

                  _itemCosmos(
                    texto: 'Lua',
                    indice: 6,
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          // ============================================================
          // CARD ALÉM DO HORIZONTE
          // ============================================================

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 13,
            ),
            child: Container(
              height: 215,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  color: const Color(0xFF283329),
                ),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF17251A),
                    Color(0xFF101913),
                  ],
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  // Círculos decorativos
                  Positioned(
                    right: -30,
                    top: -30,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white12,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    right: -15,
                    top: -15,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white10,
                        ),
                      ),
                    ),
                  ),

                  // Ponto luminoso
                  Positioned(
                    right: 28,
                    top: 38,
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: verde,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  // Texto
                  Padding(
                    padding: const EdgeInsets.all(13),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ALÉM DO HORIZONTE',
                          style: GoogleFonts.inter(
                            color: verde,
                            fontSize: 6,
                            fontWeight: FontWeight.w700,
                            letterSpacing: .8,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          'Há sempre mais\npara descobrir.',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14,
                            height: 1.15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        const Spacer(),

                        GestureDetector(
                          onTap: onVisitarNasa,
                          child: Text(
                            'Visitar a NASA  →',
                            style: GoogleFonts.inter(
                              color: Colors.white70,
                              fontSize: 7,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 8),

          // ============================================================
          // RODAPÉ DA SIDEBAR
          // ============================================================

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 17,
            ),
            child: Text(
              'FEITO PARA CURIOSOS  •  2026',
              style: GoogleFonts.inter(
               color: Colors.white24,
                fontSize: 6,
                letterSpacing: .5,
              ),
            ),
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }

  // ==================================================================
  // ITEM PRINCIPAL
  // ==================================================================

  Widget _itemMenu({
    required IconData icone,
    required String texto,
    required int indice,
    bool mostrarSeta = false,
  }) {
    final bool selecionado = paginaSelecionada == indice;

    return GestureDetector(
      onTap: () {
        onPaginaSelecionada(indice);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 9,
          vertical: 2,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 9,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: selecionado
              ? fundoSelecionado
              : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          border: selecionado
              ? Border.all(
                  color: const Color(0xFF31412F),
                  width: 1,
                )
              : null,
        ),
        child: Row(
          children: [
            Icon(
              icone,
              size: 16,
              color: selecionado
                  ? verde
                  : Colors.white38,
            ),

            const SizedBox(width: 9),

            Text(
              texto,
              style: GoogleFonts.inter(
                color: selecionado
                    ? Colors.white
                    : Colors.white54,
                fontSize: 9,
                fontWeight: selecionado
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
            ),

            const Spacer(),

            if (mostrarSeta)
              Icon(
                Icons.chevron_right,
                size: 13,
                color: selecionado
                    ? verde
                    : Colors.white24,
              ),
          ],
        ),
      ),
    );
  }

  // ==================================================================
  // ITEM DO COSMOS
  // ==================================================================

  Widget _itemCosmos({
    required String texto,
    required int indice,
  }) {
    final bool selecionado = paginaSelecionada == indice;

    return GestureDetector(
      onTap: () {
        onPaginaSelecionada(indice);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 8,
        ),
        child: Row(
          children: [
            Container(
              width: 3,
              height: 3,
              decoration: BoxDecoration(
                color: selecionado
                    ? verde
                    : Colors.white24,
                shape: BoxShape.circle,
              ),
            ),

            const SizedBox(width: 9),

            Text(
              texto,
              style: GoogleFonts.inter(
                color: selecionado
                    ? verde
                    : Colors.white38,
                fontSize: 8,
                fontWeight: selecionado
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}