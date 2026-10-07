import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/photo.dart';
import '../services/nasa_api_service.dart';
import '../widgets/photo_card.dart';
import 'detalhe_screen.dart';

class CosmosGalleryScreen extends StatefulWidget {
  final String consulta;
  final int paginaSelecionada;
  final Function(int)? onPaginaSelecionada;

  const CosmosGalleryScreen({
    super.key,
    required this.consulta,
    this.paginaSelecionada = 1,
    this.onPaginaSelecionada,
  });

  @override
  State<CosmosGalleryScreen> createState() =>
      _CosmosGalleryScreenState();
}

class _CosmosGalleryScreenState
    extends State<CosmosGalleryScreen> {
  static const Color verde =
      Color(0xFFC6FF00);

  final NasaApiService api =
      NasaApiService();

  final TextEditingController buscaController =
      TextEditingController();

  List<Photo> fotos = [];

  bool carregando = true;
  String mensagemErro = '';

  @override
  void initState() {
    super.initState();
    carregarFotos(widget.consulta);
  }

  @override
  void dispose() {
    buscaController.dispose();
    super.dispose();
  }

  Future<void> carregarFotos(
    String consulta,
  ) async {
    setState(() {
      carregando = true;
      mensagemErro = '';
    });

    try {
      final resultado =
          await api.buscarImagens(
        consulta: consulta,
        pageSize: 30,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        fotos = resultado;
        carregando = false;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        fotos = [];
        carregando = false;
        mensagemErro =
            'Não foi possível carregar as imagens.';
      });
    }
  }

  void pesquisar() {
    final texto =
        buscaController.text.trim();

    if (texto.isEmpty) {
      carregarFotos(widget.consulta);
      return;
    }

    carregarFotos(texto);
  }

  void abrirDetalhes(Photo foto) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DetalheScreen(foto: foto),
      ),
    );
  }

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
                              'UM UNIVERSO PARA EXPLORAR',
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
                                text:
                                    'Explore o ',
                              ),
                              TextSpan(
                                text: 'infinito.',
                                style: TextStyle(
                                  color: verde,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          'Viaje pelo acervo visual da NASA, uma descoberta de cada vez.',
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
                  const SizedBox(width: 30),
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.all_inclusive,
                            color: verde,
                            size: 17,
                          ),
                          const SizedBox(
                              width: 5),
                          Text(
                            '${fotos.length.toString().padLeft(2, '0')} / OBJETOS',
                            style:
                                GoogleFonts.inter(
                              color:
                                  Colors.white38,
                              fontSize: 7,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  _aba('Descobertas', 1),
                  _aba('Galáxias', 3),
                  _aba('Marte', 4),
                  _aba('Terra', 5),
                  _aba('Lua', 6),
                  const Spacer(),
                  _campoBusca(),
                ],
              ),

              const SizedBox(height: 14),

              Container(
                height: 1,
                color:
                    const Color(0xFF202328),
              ),

              const SizedBox(height: 14),

              if (carregando)
                const SizedBox(
                  height: 420,
                  child: Center(
                    child:
                        CircularProgressIndicator(
                      color: verde,
                    ),
                  ),
                )
              else if (mensagemErro.isNotEmpty)
                _erro()
              else if (fotos.isEmpty)
                _vazio()
              else
                GridView.builder(
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
                  itemCount: fotos.length,
                  itemBuilder:
                      (context, index) {
                    return PhotoCard(
                      foto: fotos[index],
                      compact: true,
                      onTap: () {
                        abrirDetalhes(
                          fotos[index],
                        );
                      },
                    );
                  },
                ),

              const SizedBox(height: 50),

              Container(
                height: 1,
                color:
                    const Color(0xFF202328),
              ),

              const SizedBox(height: 28),

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

  Widget _aba(
    String texto,
    int indice,
  ) {
    final bool selecionada =
        widget.paginaSelecionada == indice;

    return GestureDetector(
      onTap: widget.onPaginaSelecionada == null
          ? null
          : () {
              widget.onPaginaSelecionada!(
                indice,
              );
            },
      child: Container(
        margin: const EdgeInsets.only(
          right: 22,
        ),
        padding:
            const EdgeInsets.only(bottom: 9),
        decoration: selecionada
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
            color: selecionada
                ? Colors.white
                : Colors.white38,
            fontSize: 8,
            fontWeight: selecionada
                ? FontWeight.w600
                : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _campoBusca() {
    return SizedBox(
      width: 180,
      height: 30,
      child: TextField(
        controller: buscaController,
        onSubmitted: (_) => pesquisar(),
        style: GoogleFonts.inter(
          color: Colors.white70,
          fontSize: 8,
        ),
        decoration: InputDecoration(
          hintText: 'Buscar no universo...',
          hintStyle: GoogleFonts.inter(
            color: Colors.white30,
            fontSize: 8,
          ),
          prefixIcon: const Icon(
            Icons.search,
            size: 13,
            color: Colors.white38,
          ),
          suffixIcon: IconButton(
            padding: EdgeInsets.zero,
            tooltip: 'Pesquisar',
            onPressed: pesquisar,
            icon: const Icon(
              Icons.arrow_forward,
              color: verde,
              size: 13,
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          enabledBorder:
              OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFF30343A),
            ),
            borderRadius:
                BorderRadius.circular(4),
          ),
          focusedBorder:
              OutlineInputBorder(
            borderSide: const BorderSide(
              color: verde,
            ),
            borderRadius:
                BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _erro() {
    return SizedBox(
      height: 420,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.white38,
              size: 38,
            ),
            const SizedBox(height: 12),
            Text(
              mensagemErro,
              style: GoogleFonts.inter(
                color: Colors.white54,
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () =>
                  carregarFotos(
                widget.consulta,
              ),
              child: const Text(
                'Tentar novamente',
                style: TextStyle(
                  color: verde,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _vazio() {
    return SizedBox(
      height: 420,
      child: Center(
        child: Text(
          'Nenhuma imagem encontrada.',
          style: GoogleFonts.inter(
            color: Colors.white38,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}
