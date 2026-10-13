import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/photo.dart';
import '../services/favoritos_service.dart';

class PhotoCard extends StatefulWidget {
  final Photo foto;
  final VoidCallback? onTap;
  final bool compact;

  const PhotoCard({
    super.key,
    required this.foto,
    this.onTap,
    this.compact = false,
  });

  @override
  State<PhotoCard> createState() => _PhotoCardState();
}

class _PhotoCardState extends State<PhotoCard> {
  static const Color verde = Color(0xFFC6FF00);

  bool mouseSobreImagem = false;
  bool imagemComErro = false;

  @override
  void didUpdateWidget(covariant PhotoCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.foto.imgSrc != widget.foto.imgSrc) {
      imagemComErro = false;
    }
  }

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
        escuro ? Colors.white54 : const Color(0xFF777D73);

    final Color iconeSemCurtida =
        escuro ? Colors.white54 : const Color(0xFF777D73);

    return ValueListenableBuilder<List<Photo>>(
      valueListenable: FavoritosService.favoritos,
      builder: (context, favoritos, child) {
        final bool curtida =
            favoritos.any((item) => item.id == widget.foto.id);

        return GestureDetector(
          onTap: widget.onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // IMAGEM
              Expanded(
                child: MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      mouseSobreImagem = true;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      mouseSobreImagem = false;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: fundoCartao,
                      border: Border.all(color: corBorda),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        AnimatedScale(
                          scale: mouseSobreImagem ? 1.05 : 1.0,
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOut,
                          child: imagemComErro
                              ? _imagemIndisponivel(textoSecundario)
                              : Image.network(
                                  widget.foto.imgSrc,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                  headers: const {
                                    'Accept': 'image/avif,image/webp,image/*,*/*',
                                  },
                                  errorBuilder:
                                      (context, error, stackTrace) {
                                    debugPrint(
                                      'Erro ao carregar imagem: '
                                      '${widget.foto.imgSrc}',
                                    );
                                    debugPrint('Detalhes: $error');

                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      if (mounted && !imagemComErro) {
                                        setState(() {
                                          imagemComErro = true;
                                        });
                                      }
                                    });

                                    return _imagemIndisponivel(
                                      textoSecundario,
                                    );
                                  },
                                  loadingBuilder:
                                      (context, child, progress) {
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

                        // EFEITO AO PASSAR O MOUSE
                        IgnorePointer(
                          child: AnimatedOpacity(
                            opacity: mouseSobreImagem ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: Container(
                              color: Colors.black.withValues(alpha: 0.30),
                              alignment: Alignment.center,
                              child: Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: verde,
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                child: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.black,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // FONTE E ANO
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.foto.fonte.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: textoSecundario,
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    widget.foto.ano,
                    style: GoogleFonts.inter(
                      color: textoSecundario,
                      fontSize: 8,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 5),

              // TÍTULO E FAVORITOS
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.foto.titulo.isEmpty
                          ? 'Imagem da NASA'
                          : widget.foto.titulo,
                      maxLines: widget.compact ? 2 : 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: textoPrincipal,
                        fontSize: widget.compact ? 10 : 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      FavoritosService.alternar(widget.foto);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Icon(
                        curtida
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: curtida ? verde : iconeSemCurtida,
                        size: widget.compact ? 17 : 20,
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

  Widget _imagemIndisponivel(Color cor) {
    return Container(
      color: const Color(0xFF15191D),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.image_not_supported_outlined,
            color: cor,
            size: 30,
          ),
          const SizedBox(height: 8),
          Text(
            'Imagem indisponível',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: cor,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}