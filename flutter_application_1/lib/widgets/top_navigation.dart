import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopNavigation extends StatelessWidget {
  final int paginaSelecionada;
  final Function(int) onPaginaSelecionada;

  const TopNavigation({
    super.key,
    required this.paginaSelecionada,
    required this.onPaginaSelecionada,
  });

  static const Color verde =
      Color(0xFFC6FF00);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: const BoxDecoration(
        color: Color(0xFF08090B),
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF202328),
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 45,
      ),
      child: Row(
        children: [
          _item(
            'Descobertas',
            0,
          ),
          _item(
            'Galáxias',
            1,
          ),
          _item(
            'Marte',
            2,
          ),
          _item(
            'Terra',
            3,
          ),
          _item(
            'Lua',
            4,
          ),

          const Spacer(),

          Container(
            width: 160,
            height: 28,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFF30343A),
              ),
              borderRadius:
                  BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                const SizedBox(width: 8),

                const Icon(
                  Icons.search,
                  size: 13,
                  color: Colors.white38,
                ),

                const SizedBox(width: 6),

                Expanded(
                  child: Text(
                    'Buscar no universo...',
                    style: GoogleFonts.inter(
                      color: Colors.white30,
                      fontSize: 8,
                    ),
                  ),
                ),

                const Icon(
                  Icons.arrow_forward,
                  color: verde,
                  size: 13,
                ),

                const SizedBox(width: 7),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _item(
    String texto,
    int indice,
  ) {
    final bool selecionado =
        paginaSelecionada == indice;

    return InkWell(
      onTap: () {
        onPaginaSelecionada(indice);
      },
      child: Container(
        height: 42,
        margin: const EdgeInsets.only(
          right: 25,
        ),
        padding:
            const EdgeInsets.only(top: 13),
        decoration: selecionado
            ? const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: verde,
                    width: 2,
                  ),
                ),
              )
            : null,
        child: Text(
          texto,
          style: GoogleFonts.inter(
            color: selecionado
                ? Colors.white
                : Colors.white38,
            fontSize: 8,
            fontWeight: selecionado
                ? FontWeight.w600
                : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}