
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback? onExplorar;

  const HomeScreen({
    super.key,
    this.onExplorar,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color verde = Color(0xFFC6FF00);

  bool get escuro =>
      Theme.of(context).brightness == Brightness.dark;

  Color get fundo =>
      escuro ? const Color(0xFF08090B) : const Color(0xFFF7F9F5);

  Color get fundoCartao =>
      escuro ? const Color(0xFF101418) : Colors.white;

  Color get linha =>
      escuro ? const Color(0xFF202328) : const Color(0xFFD9DED5);

  Color get textoPrincipal =>
      escuro ? Colors.white : const Color(0xFF171A16);

  Color get textoSecundario =>
      escuro ? Colors.white54 : const Color(0xFF60665D);

  Color get textoFraco =>
      escuro ? Colors.white38 : const Color(0xFF777D73);

  String _dataAtual() {
    final agora = DateTime.now();

    const meses = [
      'JAN.',
      'FEV.',
      'MAR.',
      'ABR.',
      'MAI.',
      'JUN.',
      'JUL.',
      'AGO.',
      'SET.',
      'OUT.',
      'NOV.',
      'DEZ.',
    ];

    return '${agora.day} DE ${meses[agora.month - 1]} DE ${agora.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: fundo,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _topo(),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 42,
                vertical: 45,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 18,
                        height: 1,
                        color: verde,
                      ),
                      const SizedBox(width: 9),
                      Text(
                        'SEU PORTAL PARA O INFINITO',
                        style: GoogleFonts.inter(
                          color: escuro
                              ? verde
                              : const Color(0xFF536D00),
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '/ 001',
                        style: GoogleFonts.inter(
                          color: textoFraco,
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.inter(
                        color: textoPrincipal,
                        fontSize: 48,
                        height: 1.05,
                        fontWeight: FontWeight.w300,
                        letterSpacing: -2,
                      ),
                      children: [
                        const TextSpan(
                          text: 'O universo está\n',
                        ),
                        TextSpan(
                          text: 'mais perto',
                          style: TextStyle(
                            color: escuro
                                ? verde
                                : const Color(0xFF536D00),
                          ),
                        ),
                        const TextSpan(
                          text: ' do que você\nimagina.',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: 430,
                    child: Text(
                      'Uma janela para as maravilhas do cosmos. '
                      'Explore imagens, histórias e descobertas '
                      'diretamente do acervo da NASA.',
                      style: GoogleFonts.inter(
                        color: textoSecundario,
                        fontSize: 11,
                        height: 1.6,
                      ),
                    ),
                  ),

                  const SizedBox(height: 34),

                  _cardDestaque(),

                  const SizedBox(height: 30),

                  _navegacao(),

                  const SizedBox(height: 70),

                  _secaoExploreInfinito(),

                  const SizedBox(height: 55),

                  Container(
                    height: 1,
                    color: linha,
                  ),

                  const SizedBox(height: 35),

                  _rodape(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topo() {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: linha,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: [
            Text(
              'INÍCIO',
              style: GoogleFonts.inter(
                color: textoPrincipal,
                fontSize: 8,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(width: 20),

            Icon(
              Icons.chevron_right,
              size: 12,
              color: textoFraco,
            ),

            const SizedBox(width: 20),

            Text(
              'EXPLORAR O UNIVERSO',
              style: GoogleFonts.inter(
                color: textoFraco,
                fontSize: 8,
                fontWeight: FontWeight.w500,
              ),
            ),

            const Spacer(),

            Container(
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                color: verde,
                shape: BoxShape.circle,
              ),
            ),

            const SizedBox(width: 7),

            Text(
              'DADOS DA NASA',
              style: GoogleFonts.inter(
                color: escuro
                    ? verde
                    : const Color(0xFF536D00),
                fontSize: 8,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(width: 28),

            Text(
              _dataAtual(),
              style: GoogleFonts.inter(
                color: textoSecundario,
                fontSize: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardDestaque() {
    return Container(
      height: 270,
      width: double.infinity,
      decoration: BoxDecoration(
        color: fundoCartao,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: linha),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  'https://images-assets.nasa.gov/image/PIA04227/PIA04227~orig.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF123B4A),
                            Color(0xFF15233A),
                            Color(0xFF07090D),
                          ],
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.public,
                          color: Colors.white24,
                          size: 50,
                        ),
                      ),
                    );
                  },
                ),

                Positioned(
                  left: 15,
                  top: 15,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                        color: Colors.white24,
                      ),
                    ),
                    child: Text(
                      '01 / EM DESTAQUE',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 7,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const Positioned(
                  right: 16,
                  top: 15,
                  child: Icon(
                    Icons.auto_awesome,
                    color: Colors.white70,
                    size: 15,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        decoration: const BoxDecoration(
                          color: verde,
                          shape: BoxShape.circle,
                        ),
                      ),

                      const SizedBox(width: 7),

                      Expanded(
                        child: Text(
                          'DESTAQUE DO ACERVO',
                          style: GoogleFonts.inter(
                            color: escuro
                                ? verde
                                : const Color(0xFF536D00),
                            fontSize: 7,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                      ),

                      Text(
                        'Nº 001 — 365',
                        style: GoogleFonts.inter(
                          color: textoFraco,
                          fontSize: 7,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'UMA NOVA PERSPECTIVA A CADA DIA',
                    style: GoogleFonts.inter(
                      color: escuro
                          ? verde
                          : const Color(0xFF536D00),
                      fontSize: 7,
                      fontWeight: FontWeight.w700,
                      letterSpacing: .8,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'O universo nunca deixa de\nsurpreender.',
                    style: GoogleFonts.inter(
                      color: textoPrincipal,
                      fontSize: 25,
                      height: 1.12,
                      fontWeight: FontWeight.w300,
                      letterSpacing: -1,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Text(
                    'Explore as maravilhas do espaço enquanto '
                    'tentamos conectar ao acervo astronômico da NASA.',
                    style: GoogleFonts.inter(
                      color: textoSecundario,
                      fontSize: 9,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Text(
                    'Imagem do dia • Descoberta em destaque',
                    style: GoogleFonts.inter(
                      color: textoSecundario,
                      fontSize: 8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _secaoExploreInfinito() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 18,
              height: 1,
              color: verde,
            ),
            const SizedBox(width: 9),
            Text(
              'EXPLORE O INFINITO',
              style: GoogleFonts.inter(
                color: escuro
                    ? verde
                    : const Color(0xFF536D00),
                fontSize: 8,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        Text(
          'Descubra o que existe além.',
          style: GoogleFonts.inter(
            color: textoPrincipal,
            fontSize: 28,
            fontWeight: FontWeight.w300,
            letterSpacing: -0.8,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          'Explore planetas, galáxias e imagens fascinantes do acervo espacial.',
          style: GoogleFonts.inter(
            color: textoSecundario,
            fontSize: 11,
            height: 1.6,
          ),
        ),

        const SizedBox(height: 24),

        LayoutBuilder(
          builder: (context, constraints) {
            final bool compacto = constraints.maxWidth < 650;

            final double largura = compacto
                ? constraints.maxWidth
                : (constraints.maxWidth - 28) / 3;

            return Wrap(
              spacing: 14,
              runSpacing: 14,
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

        const SizedBox(height: 22),

        Align(
          alignment: Alignment.centerLeft,
          child: OutlinedButton.icon(
            onPressed: widget.onExplorar,
            icon: const Icon(
              Icons.arrow_forward,
              size: 15,
            ),
            label: const Text('EXPLORAR ACERVO'),
            style: OutlinedButton.styleFrom(
              foregroundColor: escuro
                  ? verde
                  : const Color(0xFF536D00),
              side: BorderSide(
                color: escuro
                    ? verde
                    : const Color(0xFF536D00),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 16,
              ),
              textStyle: GoogleFonts.inter(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
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
      height: 190,
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
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF123B4A),
                          Color(0xFF15233A),
                          Color(0xFF07090D),
                        ],
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.public,
                        color: Colors.white24,
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
                bottom: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: GoogleFonts.inter(
                        color: verde,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      descricao,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),

              const Positioned(
                top: 12,
                right: 12,
                child: Icon(
                  Icons.arrow_outward,
                  color: Colors.white70,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navegacao() {
    return Wrap(
      spacing: 24,
      runSpacing: 16,
      children: [
        _itemNavegacao(
          'OLHE PARA CIMA',
          Icons.north,
        ),

        GestureDetector(
          onTap: widget.onExplorar,
          child: _itemNavegacao(
            'DESCUBRA O DESCONHECIDO',
            Icons.auto_awesome,
          ),
        ),

        _itemNavegacao(
          'O UNIVERSO É DE TODOS',
          Icons.auto_awesome,
        ),

        Text(
          'OLHE PARA CIMA',
          style: GoogleFonts.inter(
            color: textoFraco,
            fontSize: 7,
          ),
        ),
      ],
    );
  }

  Widget _itemNavegacao(
    String texto,
    IconData icone,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          texto,
          style: GoogleFonts.inter(
            color: textoSecundario,
            fontSize: 7,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(width: 8),

        Icon(
          icone,
          color: escuro
              ? verde
              : const Color(0xFF536D00),
          size: 12,
        ),
      ],
    );
  }

  Widget _rodape() {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      runSpacing: 20,
      spacing: 30,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: [
        Text(
          'órbita.',
          style: GoogleFonts.inter(
            color: textoPrincipal,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),

        SizedBox(
          width: 260,
          child: Text(
            'Uma forma de se perder e se encontrar no universo.\n'
            'Imagens e dados: NASA Open APIs.',
            style: GoogleFonts.inter(
              color: textoFraco,
              fontSize: 8,
              height: 1.5,
            ),
          ),
        ),

        TextButton(
          onPressed: () {
            Scrollable.ensureVisible(
              context,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              alignment: 0,
            );
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
    );
  }
}
