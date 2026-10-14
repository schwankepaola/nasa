
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback? onExplorar;

  const HomeScreen({super.key, this.onExplorar});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color verde = Color(0xFFC6FF00);

  final ScrollController _scrollController = ScrollController();

  bool get escuro => Theme.of(context).brightness == Brightness.dark;

  Color get fundo =>
      escuro ? const Color(0xFF08090B) : const Color(0xFFF7F9F5);

  Color get fundoCartao => escuro ? const Color(0xFF14171C) : Colors.white;

  Color get linha =>
      escuro ? const Color(0xFF30343A) : const Color(0xFFD9DED5);

  Color get textoPrincipal =>
      escuro ? const Color(0xFFF2F2F2) : const Color(0xFF171A16);

  Color get textoSecundario =>
      escuro ? const Color(0xFFADB2BC) : const Color(0xFF60665D);

  Color get textoFraco =>
      escuro ? const Color(0xFF777F8C) : const Color(0xFF777D73);

  String _dataAtual() {
    final agora = DateTime.now();

    const meses = [
      'JAN.', 'FEV.', 'MAR.', 'ABR.', 'MAI.', 'JUN.',
      'JUL.', 'AGO.', 'SET.', 'OUT.', 'NOV.', 'DEZ.',
    ];

    return '${agora.day} DE ${meses[agora.month - 1]} DE ${agora.year}';
  }

  Future<void> _abrirUrl(String endereco) async {
    try {
      final uri = Uri.parse(endereco);
      final abriu = await launchUrl(
        uri,
        webOnlyWindowName: '_blank',
      );

      if (!abriu && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Não foi possível abrir o endereço.')),
        );
      }
    } catch (e) {
      debugPrint('Erro ao abrir endereço: $e');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao abrir o site.')),
        );
      }
    }
  }

  Future<void> _abrirApisNasa() async {
    await _abrirUrl('https://api.nasa.gov/');
  }

  void _voltarAoTopo() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: fundo,
      child: LayoutBuilder(
        builder: (context, limites) {
          final compacto = limites.maxWidth < 700;

          return SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _topo(compacto),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: compacto ? 20 : 42,
                    vertical: compacto ? 28 : 38,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(width: 20, height: 1, color: verde),
                          const SizedBox(width: 12),
                          Text(
                            'UM UNIVERSO PARA EXPLORAR',
                            style: GoogleFonts.inter(
                              color: escuro ? verde : const Color(0xFF536D00),
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '/ 001',
                            style: GoogleFonts.inter(
                              color: textoFraco,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Text(
                        'Uma janela para as maravilhas do cosmos. '
                        'Explore imagens, histórias e descobertas '
                        'diretamente do acervo da NASA.',
                        style: GoogleFonts.inter(
                          color: textoSecundario,
                          fontSize: compacto ? 13 : 15,
                          height: 1.8,
                        ),
                      ),
                      const SizedBox(height: 35),
                      _cardDestaque(),
                      const SizedBox(height: 30),
                      _navegacao(compacto),
                      const SizedBox(height: 60),
                      _secaoExploreInfinito(),
                      const SizedBox(height: 55),
                      Container(height: 1, color: linha),
                      const SizedBox(height: 30),
                      _rodape(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _topo(bool compacto) {
    if (compacto) {
      return Container(
        height: 54,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: linha)),
        ),
        child: Row(
          children: [
            Icon(Icons.public, color: verde, size: 23),
            const SizedBox(width: 10),
            Text(
              'órbita.',
              style: GoogleFonts.inter(
                color: textoPrincipal,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                letterSpacing: -1,
              ),
            ),
            const Spacer(),
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: verde,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'NASA',
              style: GoogleFonts.inter(
                color: textoSecundario,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: linha)),
      ),
      child: Row(
        children: [
          Text(
            'INÍCIO',
            style: GoogleFonts.inter(
              color: textoPrincipal,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 18),
          Icon(Icons.chevron_right, size: 14, color: textoFraco),
          const SizedBox(width: 18),
          Text(
            'EXPLORAR O UNIVERSO',
            style: GoogleFonts.inter(
              color: textoFraco,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: verde,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'DADOS DA NASA',
            style: GoogleFonts.inter(
              color: escuro ? verde : const Color(0xFF536D00),
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 25),
          Text(
            _dataAtual(),
            style: GoogleFonts.inter(
              color: textoSecundario,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardDestaque() {
    return LayoutBuilder(
      builder: (context, limites) {
        final compacto = limites.maxWidth < 760;

        final imagem = Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://images-assets.nasa.gov/image/PIA04227/PIA04227~medium.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFF102330),
                  child: const Center(
                    child: Icon(
                      Icons.public,
                      color: Colors.white54,
                      size: 60,
                    ),
                  ),
                );
              },
            ),
            Positioned(
              left: 22,
              top: 22,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  border: Border.all(color: Colors.white30),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  '01 / EM DESTAQUE',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: .7,
                  ),
                ),
              ),
            ),
            const Positioned(
              right: 22,
              top: 22,
              child: Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 22,
              ),
            ),
            Positioned(
              left: 22,
              bottom: 20,
              child: Text(
                'NASA • ACERVO ASTRONÔMICO',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: .6,
                ),
              ),
            ),
          ],
        );

        final painel = Padding(
          padding: EdgeInsets.all(compacto ? 22 : 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: verde,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'DESTAQUE DO ACERVO',
                      style: GoogleFonts.inter(
                        color: escuro ? verde : const Color(0xFF536D00),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Text(
                    'Nº 001 — 365',
                    style: GoogleFonts.inter(
                      color: textoFraco,
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
              SizedBox(height: compacto ? 28 : 55),
              Text(
                'UMA NOVA PERSPECTIVA A CADA DIA',
                style: GoogleFonts.inter(
                  color: escuro ? verde : const Color(0xFF536D00),
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'O cosmos tem uma história para contar.',
                style: GoogleFonts.inter(
                  color: textoPrincipal,
                  fontSize: compacto ? 28 : 40,
                  height: 1.12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -1.5,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Descubra imagens, histórias e fenômenos '
                'astronômicos registrados pela NASA.',
                style: GoogleFonts.inter(
                  color: textoSecundario,
                  fontSize: 13,
                  height: 1.7,
                ),
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: _abrirHistoria,
                borderRadius: BorderRadius.circular(30),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Conhecer a história',
                        style: GoogleFonts.inter(
                          color: textoPrincipal,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: linha),
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: escuro ? verde : const Color(0xFF536D00),
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Divider(color: linha),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.calendar_today, color: textoSecundario, size: 16),
                  const SizedBox(width: 12),
                  Text(
                    _dataAtual(),
                    style: GoogleFonts.inter(
                      color: textoSecundario,
                      fontSize: 11,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: 'Conhecer a história',
                    onPressed: _abrirHistoria,
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: textoSecundario,
                      size: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: fundoCartao,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: linha),
          ),
          clipBehavior: Clip.antiAlias,
          child: compacto
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 300, child: imagem),
                    painel,
                  ],
                )
              : SizedBox(
                  height: 570,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(flex: 11, child: imagem),
                      Expanded(flex: 10, child: painel),
                    ],
                  ),
                ),
        );
      },
    );
  }

  void _abrirHistoria() {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black87,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: fundoCartao,
          insetPadding: const EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: linha),
          ),
          child: LayoutBuilder(
            builder: (context, limites) {
              final compacto = limites.maxWidth < 650;

              final imagem = Image.network(
                'https://images-assets.nasa.gov/image/PIA04227/PIA04227~medium.jpg',
                width: double.infinity,
                height: compacto ? 240 : 560,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: compacto ? 240 : 560,
                    color: const Color(0xFF102330),
                    child: const Center(
                      child: Icon(
                        Icons.public,
                        color: Colors.white54,
                        size: 60,
                      ),
                    ),
                  );
                },
              );

              final conteudo = Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        tooltip: 'Fechar',
                        onPressed: () => Navigator.pop(dialogContext),
                        icon: Icon(Icons.close, color: textoPrincipal),
                      ),
                    ),
                    Text(
                      'NASA / ACERVO ASTRONÔMICO',
                      style: GoogleFonts.inter(
                        color: verde,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'O cosmos tem uma história para contar.',
                      style: GoogleFonts.inter(
                        color: textoPrincipal,
                        fontSize: compacto ? 27 : 36,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Explore os mistérios do universo por meio de '
                      'imagens astronômicas e descobertas registradas '
                      'pela NASA. Cada imagem revela uma parte da '
                      'história do espaço e nos convida a conhecer '
                      'melhor os objetos e fenômenos cósmicos.',
                      style: GoogleFonts.inter(
                        color: textoSecundario,
                        fontSize: 13,
                        height: 1.8,
                      ),
                    ),
                    const SizedBox(height: 26),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Conectaremos este botão à coleção de Salvos.',
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.favorite_border, size: 18),
                          label: const Text('Salvar na coleção'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: textoPrincipal,
                            side: BorderSide(color: linha),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 18,
                            ),
                          ),
                        ),
                        OutlinedButton.icon(
                          onPressed: _abrirApisNasa,
                          icon: const Icon(Icons.open_in_new, size: 16),
                          label: const Text('Ver NASA'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: textoPrincipal,
                            side: BorderSide(color: linha),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );

              return ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 1200,
                  maxHeight: 720,
                ),
                child: SingleChildScrollView(
                  child: compacto
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [imagem, conteudo],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 1, child: imagem),
                            Expanded(flex: 1, child: conteudo),
                          ],
                        ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _secaoExploreInfinito() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 20, height: 1, color: verde),
            const SizedBox(width: 12),
            Text(
              'UM UNIVERSO PARA EXPLORAR',
              style: GoogleFonts.inter(
                color: escuro ? verde : const Color(0xFF536D00),
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '/ 002',
              style: GoogleFonts.inter(
                color: textoFraco,
                fontSize: 10,
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        RichText(
          text: TextSpan(
            style: GoogleFonts.inter(
              color: textoPrincipal,
              fontSize: 48,
              height: 1.1,
              fontWeight: FontWeight.w400,
              letterSpacing: -2,
            ),
            children: [
              const TextSpan(text: 'Explore o '),
              TextSpan(
                text: 'infinito.',
                style: const TextStyle(color: verde),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Viaje pelo acervo visual da NASA, uma descoberta de cada vez.',
          style: GoogleFonts.inter(
            color: textoSecundario,
            fontSize: 14,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 30),
        LayoutBuilder(
          builder: (context, limites) {
            final compacto = limites.maxWidth < 650;
            final largura = compacto
                ? limites.maxWidth
                : (limites.maxWidth - 28) / 3;

            return Wrap(
              spacing: 14,
              runSpacing: 22,
              children: [
                _cardExplore(
                  titulo: 'GALÁXIAS',
                  descricao: 'Bilhões de estrelas em movimento.',
                  imagem:
                      'https://images-assets.nasa.gov/image/PIA12348/PIA12348~medium.jpg',
                  largura: largura,
                ),
                _cardExplore(
                  titulo: 'PLANETAS',
                  descricao: 'Mundos além do nosso.',
                  imagem:
                      'https://images-assets.nasa.gov/image/PIA01492/PIA01492~medium.jpg',
                  largura: largura,
                ),
                _cardExplore(
                  titulo: 'A TERRA',
                  descricao: 'Nosso planeta visto do espaço.',
                  imagem:
                      'https://images-assets.nasa.gov/image/iss063e004717/iss063e004717~medium.jpg',
                  largura: largura,
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 25),
        OutlinedButton.icon(
          onPressed: widget.onExplorar,
          icon: const Icon(Icons.arrow_forward, size: 16),
          label: const Text('EXPLORAR ACERVO'),
          style: OutlinedButton.styleFrom(
            foregroundColor: escuro ? verde : const Color(0xFF536D00),
            side: BorderSide(
              color: escuro ? verde : const Color(0xFF536D00),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
          ),
        ),
      ],
    );
  }

  Widget _cardExplore({
    required String titulo,
    required String descricao,
    required String imagem,
    required double largura,
  }) {
    return SizedBox(
      width: largura,
      height: 330,
      child: Material(
        color: fundoCartao,
        borderRadius: BorderRadius.circular(7),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: widget.onExplorar,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                imagem,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFF102330),
                    child: const Center(
                      child: Icon(
                        Icons.public,
                        color: Colors.white54,
                        size: 42,
                      ),
                    ),
                  );
                },
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Color(0xE608090B),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 18,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: GoogleFonts.inter(
                        color: verde,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      descricao,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Icon(
                      Icons.arrow_outward,
                      color: Colors.white70,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navegacao(bool compacto) {
    final itens = [
      'OLHE PARA CIMA',
      'DESCUBRA O DESCONHECIDO',
      'O UNIVERSO É DE TODOS',
      'OLHE PARA CIMA',
    ];

    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          spacing: 22,
          runSpacing: 18,
          children: itens.map((texto) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  texto,
                  style: GoogleFonts.inter(
                    color: textoSecundario,
                    fontSize: 10,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(width: 12),
                Icon(
                  Icons.auto_awesome,
                  color: escuro ? verde : const Color(0xFF536D00),
                  size: 15,
                ),
              ],
            );
          }).toList(),
        ),
        const SizedBox(height: 35),
        Container(height: 1, color: linha),
      ],
    );
  }

  Widget _textoApisNasa({TextAlign alinhamento = TextAlign.left}) {
    return Wrap(
      alignment: alinhamento == TextAlign.center
          ? WrapAlignment.center
          : WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          'Imagens e dados: ',
          style: GoogleFonts.inter(
            color: textoFraco,
            fontSize: 10,
          ),
        ),
        InkWell(
          onTap: _abrirApisNasa,
          child: Text(
            'NASA Open APIs',
            style: GoogleFonts.inter(
              color: escuro ? verde : const Color(0xFF536D00),
              fontSize: 10,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        Text(
          '.',
          style: GoogleFonts.inter(
            color: textoFraco,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _rodape() {
    return LayoutBuilder(
      builder: (context, limites) {
        final compacto = limites.maxWidth < 650;

        if (compacto) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'órbita.',
                style: GoogleFonts.inter(
                  color: textoPrincipal,
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Uma forma de se perder e se encontrar no universo.',
                style: GoogleFonts.inter(
                  color: textoFraco,
                  fontSize: 10,
                  height: 1.7,
                ),
              ),
              const SizedBox(height: 8),
              _textoApisNasa(),
              const SizedBox(height: 12),
              TextButton(
                onPressed: _voltarAoTopo,
                child: Text(
                  'VOLTAR AO TOPO ↑',
                  style: GoogleFonts.inter(
                    color: textoSecundario,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                'órbita.',
                style: GoogleFonts.inter(
                  color: textoPrincipal,
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Text(
                    'Uma forma de se perder e se encontrar no universo.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: textoFraco,
                      fontSize: 10,
                      height: 1.7,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _textoApisNasa(alinhamento: TextAlign.center),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _voltarAoTopo,
                  child: Text(
                    'VOLTAR AO TOPO ↑',
                    style: GoogleFonts.inter(
                      color: textoSecundario,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
