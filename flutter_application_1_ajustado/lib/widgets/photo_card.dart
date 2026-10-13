import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/photo.dart';
import '../services/favoritos_service.dart';

class PhotoCard extends StatelessWidget {
  final Photo foto;
  final VoidCallback? onTap;
  final bool compact;

  const PhotoCard({
    super.key,
    required this.foto,
    this.onTap,
    this.compact = false,
  });

  static const Color verde = Color(0xFFC6FF00);

  @override
  Widget build(BuildContext context) {
    final bool escuro =
        Theme.of(context).brightness == Brightness.dark;

    final Color fundoCartao =
        escuro ? const Color(0xFF101419) : Colors.white;

    final Color corBorda =
        escuro ? const Color(0xFF24292E) : const Color(0xFFD9DED5);

    final Color textoPrincipal =
        escuro ? Colors.white : const Color(0xFF171A16);

    final Color textoSecundario =
        escuro ? Colors.white38 : const Color(0xFF777D73);

    final Color iconeSemCurtida =
        escuro ? Colors.white38 : const Color(0xFF777D73);

    return ValueListenableBuilder<List<Photo>>(
      valueListenable: FavoritosService.favoritos,
      builder: (context, favoritos, child) {
        final bool curtida =
            favoritos.any((item) => item.id == foto.id);

        return GestureDetector(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: fundoCartao,
                    border: Border.all(color: corBorda),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    foto.imgSrc,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.image_outlined,
                          color: textoSecundario,
                          size: 30,
                        ),
                      );
                    },
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) {
                        return child;
                      }

                      return const Center(
                        child: CircularProgressIndicator(
                          color: verde,
                          strokeWidth: 2,
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  Expanded(
                    child: Text(
                      foto.fonte.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: textoSecundario,
                        fontSize: 7,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    foto.ano,
                    style: GoogleFonts.inter(
                      color: textoSecundario,
                      fontSize: 7,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 5),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      foto.titulo.isEmpty
                          ? 'Imagem da NASA'
                          : foto.titulo,
                      maxLines: compact ? 1 : 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: textoPrincipal,
                        fontSize: compact ? 9 : 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  GestureDetector(
                    onTap: () {
                      FavoritosService.alternar(foto);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: Icon(
                        curtida
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: curtida ? verde : iconeSemCurtida,
                        size: compact ? 16 : 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}