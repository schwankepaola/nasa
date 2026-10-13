import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Sidebar extends StatelessWidget {
  final int paginaSelecionada;
  final Function(int) onPaginaSelecionada;
  final VoidCallback? onVisitarNasa;
  final VoidCallback? onAbrirApis;
  final bool temaEscuro;
  final VoidCallback onAlternarTema;

  const Sidebar({
    super.key,
    required this.paginaSelecionada,
    required this.onPaginaSelecionada,
    this.onVisitarNasa,
    this.onAbrirApis,
    required this.temaEscuro,
    required this.onAlternarTema,
  });

  static const Color verde = Color(0xFFC6FF00);
  static const Color fundoEscuro = Color(0xFF0A0B0D);
  static const Color fundoSelecionadoEscuro = Color(0xFF182218);
  static const Color linhaEscura = Color(0xFF202328);

  @override
  Widget build(BuildContext context) {
    final bool escuro = temaEscuro;

    final Color fundo =
        escuro ? fundoEscuro : const Color(0xFFE9EDE5);

    final Color fundoSelecionado = escuro
        ? fundoSelecionadoEscuro
        : const Color(0xFFDCE8C9);

    final Color linha =
        escuro ? linhaEscura : const Color(0xFFD2D8CD);

    final Color texto =
        escuro ? Colors.white : const Color(0xFF171A16);

    final Color textoSecundario =
        escuro ? Colors.white54 : const Color(0xFF5B6257);

    final Color textoFraco =
        escuro ? Colors.white30 : const Color(0xFF777F72);

    return Container(
      width: 220,
      color: fundo,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LOGO
          Container(
            height: 64,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: linha, width: 1),
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
                    color: texto,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),

          // MENU E CONTEÚDO
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: Text(
                      'MENU PRINCIPAL',
                      style: GoogleFonts.inter(
                        color: textoFraco,
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
                    fundoSelecionado: fundoSelecionado,
                    linha: linha,
                    corTexto: texto,
                    corTextoSecundario: textoSecundario,
                  ),

                  _itemMenu(
                    icone: Icons.favorite_border,
                    texto: 'Salvos',
                    indice: 2,
                    fundoSelecionado: fundoSelecionado,
                    linha: linha,
                    corTexto: texto,
                    corTextoSecundario: textoSecundario,
                  ),

                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      height: 1,
                      color: linha,
                    ),
                  ),

                  const SizedBox(height: 25),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: Text(
                      'EXPLORE O COSMOS',
                      style: GoogleFonts.inter(
                        color: textoFraco,
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
                    corTexto: texto,
                    corTextoSecundario: textoSecundario,
                  ),

                  _itemCosmos(
                    texto: 'Marte',
                    indice: 4,
                    corTexto: texto,
                    corTextoSecundario: textoSecundario,
                  ),

                  _itemCosmos(
                    texto: 'Terra',
                    indice: 5,
                    corTexto: texto,
                    corTextoSecundario: textoSecundario,
                  ),

                  _itemCosmos(
                    texto: 'Lua',
                    indice: 6,
                    corTexto: texto,
                    corTextoSecundario: textoSecundario,
                  ),

                  const SizedBox(height: 20),

                  // CARD DA NASA
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Container(
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          color: escuro
                              ? const Color(0xFF283329)
                              : const Color(0xFFC9D8BC),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: escuro
                              ? const [
                                  Color(0xFF17251A),
                                  Color(0xFF101913),
                                ]
                              : const [
                                  Color(0xFFE0EBD5),
                                  Color(0xFFF0F4EB),
                                ],
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            right: -3,
                            top: -5,
                            child: Icon(
                              Icons.public,
                              size: 45,
                              color: escuro
                                  ? Colors.white10
                                  : const Color(0xFFC7D5BB),
                            ),
                          ),

                          Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ALÉM DO HORIZONTE',
                                style: GoogleFonts.inter(
                                  color: escuro
                                      ? verde
                                      : const Color(0xFF45651B),
                                  fontSize: 6,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: .8,
                                ),
                              ),

                              const SizedBox(height: 12),

                              Text(
                                'Há sempre mais\npara descobrir.',
                                style: GoogleFonts.inter(
                                  color: texto,
                                  fontSize: 14,
                                  height: 1.15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                              const SizedBox(height: 16),

                              GestureDetector(
                                onTap: onVisitarNasa,
                                child: Text(
                                  'Visitar a NASA  →',
                                  style: GoogleFonts.inter(
                                    color: textoSecundario,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 12),

                              GestureDetector(
                                onTap: onAbrirApis,
                                child: Text(
                                  'NASA Open APIs  ↗',
                                  style: GoogleFonts.inter(
                                    color: escuro
                                        ? verde
                                        : const Color(0xFF45651B),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // BOTÃO PARA ALTERNAR O TEMA
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onAlternarTema,
                icon: Icon(
                  escuro
                      ? Icons.light_mode_outlined
                      : Icons.dark_mode_outlined,
                  size: 16,
                ),
                label: Text(
                  escuro
                      ? 'Ativar tema claro'
                      : 'Ativar tema escuro',
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: texto,
                  side: BorderSide(color: linha),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 12,
                  ),
                  textStyle: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // RODAPÉ
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Text(
              'FEITO PARA CURIOSOS  •  2026',
              style: GoogleFonts.inter(
                color: textoFraco,
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

  // ITEM DO MENU PRINCIPAL
  Widget _itemMenu({
    required IconData icone,
    required String texto,
    required int indice,
    bool mostrarSeta = false,
    required Color fundoSelecionado,
    required Color linha,
    required Color corTexto,
    required Color corTextoSecundario,
  }) {
    final bool selecionado = paginaSelecionada == indice;

    return GestureDetector(
      onTap: () => onPaginaSelecionada(indice),
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
              ? Border.all(color: linha, width: 1)
              : null,
        ),
        child: Row(
          children: [
            Icon(
              icone,
              size: 16,
              color: selecionado
                  ? verde
                  : corTextoSecundario,
            ),

            const SizedBox(width: 9),

            Text(
              texto,
              style: GoogleFonts.inter(
                color: selecionado
                    ? corTexto
                    : corTextoSecundario,
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
                    : corTextoSecundario,
              ),
          ],
        ),
      ),
    );
  }

  // ITEM DAS SEÇÕES DO COSMOS
  Widget _itemCosmos({
    required String texto,
    required int indice,
    required Color corTexto,
    required Color corTextoSecundario,
  }) {
    final bool selecionado = paginaSelecionada == indice;

    return GestureDetector(
      onTap: () => onPaginaSelecionada(indice),
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
                    : corTextoSecundario,
                shape: BoxShape.circle,
              ),
            ),

            const SizedBox(width: 9),

            Text(
              texto,
              style: GoogleFonts.inter(
                color: selecionado
                    ? verde
                    : corTextoSecundario,
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