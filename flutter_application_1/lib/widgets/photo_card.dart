import 'package:flutter/material.dart';

import '../models/photo.dart';
import '../services/favoritos_service.dart';

class PhotoCard extends StatelessWidget {
  final Photo foto;
  final VoidCallback? onTap;

  const PhotoCard({
    super.key,
    required this.foto,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Photo>>(
      valueListenable: FavoritosService.favoritos,
      builder: (
        context,
        favoritos,
        child,
      ) {
        final bool curtida =
            favoritos.any((item) => item.id == foto.id);

        return GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF111315),
              borderRadius:
                  BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFF202328),
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 1.25,
                      child: Image.network(
                        foto.imgSrc,
                        fit: BoxFit.cover,
                        errorBuilder: (
                          context,
                          error,
                          stackTrace,
                        ) {
                          return Container(
                            color:
                                const Color(0xFF1A1C1F),
                            child: const Center(
                              child: Icon(
                                Icons
                                    .image_not_supported_outlined,
                                color: Colors.white38,
                                size: 40,
                              ),
                            ),
                          );
                        },
                        loadingBuilder: (
                          context,
                          child,
                          loadingProgress,
                        ) {
                          if (loadingProgress ==
                              null) {
                            return child;
                          }

                          return const Center(
                            child:
                                CircularProgressIndicator(
                              color:
                                  Color(0xFFC6FF00),
                            ),
                          );
                        },
                      ),
                    ),

                    Positioned(
                      top: 10,
                      right: 10,
                      child: Material(
                        color: Colors.black
                            .withValues(alpha: 0.65),
                        shape: const CircleBorder(),
                        child: IconButton(
                          tooltip: curtida
                              ? 'Remover dos favoritos'
                              : 'Curtir',
                          onPressed: () {
                            FavoritosService
                                .alternar(foto);
                          },
                          icon: Icon(
                            curtida
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: curtida
                                ? const Color(
                                    0xFFC6FF00,
                                  )
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding:
                      const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        foto.rover.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        'SOL ${foto.sol}',
                        style: const TextStyle(
                          color:
                              Color(0xFFC6FF00),
                          fontSize: 12,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        foto.camera.fullName,
                        maxLines: 1,
                        overflow:
                            TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 12,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        foto.earthDate,
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 11,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              FavoritosService
                                  .alternar(foto);
                            },
                            borderRadius:
                                BorderRadius.circular(
                              8,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets
                                      .symmetric(
                                horizontal: 8,
                                vertical: 6,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    curtida
                                        ? Icons
                                            .favorite
                                        : Icons
                                            .favorite_border,
                                    color: curtida
                                        ? const Color(
                                            0xFFC6FF00,
                                          )
                                        : Colors
                                            .white54,
                                    size: 20,
                                  ),

                                  const SizedBox(
                                      width: 6),

                                  Text(
                                    curtida
                                        ? 'Curtido'
                                        : 'Curtir',
                                    style: TextStyle(
                                      color: curtida
                                          ? const Color(
                                              0xFFC6FF00,
                                            )
                                          : Colors
                                              .white54,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}