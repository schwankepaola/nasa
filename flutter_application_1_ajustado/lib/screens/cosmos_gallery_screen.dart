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
  State<CosmosGalleryScreen> createState() => _CosmosGalleryScreenState();
}

class _CosmosGalleryScreenState extends State<CosmosGalleryScreen> {
  static const Color verde = Color(0xFFC6FF00);
  static const Color verdeClaro = Color(0xFF536D00);
  final ScrollController _scrollController = ScrollController();

  final NasaApiService api = NasaApiService();
  final TextEditingController buscaController = TextEditingController();

  List<Photo> fotos = [];

  bool carregando = true;
  String mensagemErro = '';

  bool get escuro => Theme.of(context).brightness == Brightness.dark;

  Color get fundo => Theme.of(context).scaffoldBackgroundColor;

  Color get textoPrincipal => escuro ? Colors.white : const Color(0xFF171A16);

  Color get textoSecundario =>
      escuro ? Colors.white54 : const Color(0xFF60665D);

  Color get textoFraco => escuro ? Colors.white38 : const Color(0xFF777D73);

  Color get linha => escuro ? const Color(0xFF202328) : const Color(0xFFD9DED5);

  Color get corDestaque => escuro ? verde : verdeClaro;

  @override
  void initState() {
    super.initState();
    carregarFotos(widget.consulta);
  }

  @override
  void dispose() {
    buscaController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> carregarFotos(String consulta) async {
    setState(() {
      carregando = true;
      mensagemErro = '';
    });

    try {
      final resultado = await api.buscarImagens(
        consulta: consulta,
        pageSize: 30,
      );

      if (!mounted) return;

      setState(() {
        fotos = resultado;
        carregando = false;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        fotos = [];
        carregando = false;
        mensagemErro = 'Não foi possível carregar as imagens.';
      });
    }
  }

  void pesquisar() {
    final texto = buscaController.text.trim();

    if (texto.isEmpty) {
      carregarFotos(widget.consulta);
      return;
    }

    carregarFotos(texto);
  }

  void abrirDetalhes(Photo foto) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetalheScreen(foto: foto)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: fundo,
      width: double.infinity,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(42, 35, 42, 45),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CABEÇALHO
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(width: 18, height: 1, color: corDestaque),
                            const SizedBox(width: 8),
                            Text(
                              'UM UNIVERSO PARA EXPLORAR',
                              style: GoogleFonts.inter(
                                color: corDestaque,
                                fontSize: 7,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.1,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '/ 002',
                              style: GoogleFonts.inter(
                                color: textoFraco,
                                fontSize: 7,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.inter(
                              color: textoPrincipal,
                              fontSize: 38,
                              fontWeight: FontWeight.w300,
                              letterSpacing: -1.8,
                            ),
                            children: [
                              const TextSpan(text: 'Explore o '),
                              TextSpan(
                                text: 'infinito.',
                                style: TextStyle(color: corDestaque),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          'Viaje pelo acervo visual da NASA, uma descoberta de cada vez.',
                          style: GoogleFonts.inter(
                            color: textoSecundario,
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.all_inclusive,
                            color: corDestaque,
                            size: 17,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '${fotos.length.toString().padLeft(2, '0')} / OBJETOS',
                            style: GoogleFonts.inter(
                              color: textoFraco,
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

              // ABAS E BUSCA
              LayoutBuilder(
                builder: (context, constraints) {
                  final bool compacto = constraints.maxWidth < 750;

                  final abas = Wrap(
                    spacing: 0,
                    runSpacing: 10,
                    children: [
                      _aba('Descobertas', 1),
                      _aba('Galáxias', 3),
                      _aba('Marte', 4),
                      _aba('Terra', 5),
                      _aba('Lua', 6),
                    ],
                  );

                  if (compacto) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        abas,
                        const SizedBox(height: 16),
                        _campoBusca(),
                      ],
                    );
                  }

                  return Row(
                    children: [
                      Expanded(child: abas),
                      const SizedBox(width: 15),
                      _campoBusca(),
                    ],
                  );
                },
              ),

              const SizedBox(height: 14),
              Container(height: 1, color: linha),
              const SizedBox(height: 14),

              // GALERIA
              if (carregando)
                const SizedBox(
                  height: 420,
                  child: Center(child: CircularProgressIndicator(color: verde)),
                )
              else if (mensagemErro.isNotEmpty)
                _erro()
              else if (fotos.isEmpty)
                _vazio()
              else
                LayoutBuilder(
                  builder: (context, constraints) {
                    int colunas = 3;

                    if (constraints.maxWidth < 550) {
                      colunas = 1;
                    } else if (constraints.maxWidth < 850) {
                      colunas = 2;
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: colunas,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 28,
                        childAspectRatio: colunas == 1 ? 1.15 : 0.92,
                      ),
                      itemCount: fotos.length,
                      itemBuilder: (context, index) {
                        return PhotoCard(
                          foto: fotos[index],
                          compact: true,
                          onTap: () => abrirDetalhes(fotos[index]),
                        );
                      },
                    );
                  },
                ),

              const SizedBox(height: 50),
              Container(height: 1, color: linha),
              const SizedBox(height: 28),

              // RODAPÉ
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                runSpacing: 18,
                spacing: 24,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    'órbita.',
                    style: GoogleFonts.inter(
                      color: textoPrincipal,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Uma forma de se perder e se encontrar no universo.\n'
                    'Imagens e dados: NASA Open APIs.',
                    style: GoogleFonts.inter(
                      color: textoSecundario,
                      fontSize: 7,
                      height: 1.5,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_scrollController.hasClients) {
                        _scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text(
                      'VOLTAR AO TOPO ↑',
                      style: GoogleFonts.inter(
                        color: textoSecundario,
                        fontSize: 7,
                      ),
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

  // ABAS
  Widget _aba(String texto, int indice) {
    final bool selecionada = widget.paginaSelecionada == indice;

    return GestureDetector(
      onTap: widget.onPaginaSelecionada == null
          ? null
          : () => widget.onPaginaSelecionada!(indice),
      child: Container(
        margin: const EdgeInsets.only(right: 22),
        padding: const EdgeInsets.only(bottom: 9),
        decoration: selecionada
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: corDestaque, width: 2),
                ),
              )
            : null,
        child: Text(
          texto,
          style: GoogleFonts.inter(
            color: selecionada ? textoPrincipal : textoFraco,
            fontSize: 8,
            fontWeight: selecionada ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  // CAMPO DE BUSCA
  Widget _campoBusca() {
    return SizedBox(
      width: 220,
      height: 38,
      child: TextField(
        controller: buscaController,
        onSubmitted: (_) => pesquisar(),
        style: GoogleFonts.inter(color: textoPrincipal, fontSize: 10),
        decoration: InputDecoration(
          hintText: 'Buscar no universo...',
          hintStyle: GoogleFonts.inter(color: textoFraco, fontSize: 9),
          prefixIcon: Icon(Icons.search, size: 15, color: textoSecundario),
          suffixIcon: IconButton(
            padding: EdgeInsets.zero,
            tooltip: 'Pesquisar',
            onPressed: pesquisar,
            icon: Icon(Icons.arrow_forward, color: corDestaque, size: 15),
          ),
          filled: true,
          fillColor: escuro ? const Color(0xFF101419) : Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: linha),
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: corDestaque),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  // ERRO
  Widget _erro() {
    return SizedBox(
      height: 420,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: textoSecundario, size: 38),
            const SizedBox(height: 12),
            Text(
              mensagemErro,
              style: GoogleFonts.inter(color: textoSecundario, fontSize: 10),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () => carregarFotos(widget.consulta),
              child: Text(
                'Tentar novamente',
                style: TextStyle(color: corDestaque),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // GALERIA VAZIA
  Widget _vazio() {
    return SizedBox(
      height: 420,
      child: Center(
        child: Text(
          'Nenhuma imagem encontrada.',
          style: GoogleFonts.inter(color: textoSecundario, fontSize: 11),
        ),
      ),
    );
  }
}
