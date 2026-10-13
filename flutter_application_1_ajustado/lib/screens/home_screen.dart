import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback? onExplorar;

  const HomeScreen({super.key, this.onExplorar});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  static const Color verde = Color(0xFFC6FF00);

  static const Color fundo = Color(0xFF08090B);

  static const Color linha = Color(0xFF202328);

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
              padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 45),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  // PEQUENO TÍTULO
                  Row(
                    children: [
                      Container(width: 18, height: 1, color: verde),

                      const SizedBox(width: 9),

                      Text(
                        'SEU PORTAL PARA O INFINITO',

                        style: GoogleFonts.inter(
                          color: verde,

                          fontSize: 8,

                          fontWeight: FontWeight.w700,

                          letterSpacing: 1.2,
                        ),
                      ),

                      const SizedBox(width: 8),

                      Text(
                        '/ 001',

                        style: GoogleFonts.inter(
                          color: Colors.white24,

                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // TÍTULO PRINCIPAL
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.inter(
                        color: Colors.white,

                        fontSize: 48,

                        height: 1.05,

                        fontWeight: FontWeight.w300,

                        letterSpacing: -2,
                      ),

                      children: [
                        const TextSpan(text: 'O universo está\n'),

                        TextSpan(
                          text: 'mais perto',

                          style: const TextStyle(color: verde),
                        ),

                        const TextSpan(text: ' do que você\nimagina.'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // DESCRIÇÃO
                  SizedBox(
                    width: 430,

                    child: Text(
                      'Uma janela para as maravilhas do cosmos. '
                      'Explore imagens, histórias e descobertas '
                      'diretamente do acervo da NASA.',

                      style: GoogleFonts.inter(
                        color: Colors.white54,

                        fontSize: 11,

                        height: 1.6,
                      ),
                    ),
                  ),

                  const SizedBox(height: 34),

                  // CARD PRINCIPAL
                  _cardDestaque(),

                  const SizedBox(height: 30),

                  // NAVEGAÇÃO INFERIOR
                  _navegacao(),

                  const SizedBox(height: 70),

                  // SEÇÃO EXPLORE O INFINITO
                  _secaoExploreInfinito(),

                  const SizedBox(height: 55),

                  // LINHA
                  Container(height: 1, color: linha),

                  const SizedBox(height: 35),

                  // RODAPÉ
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

      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: linha, width: 1)),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),

        child: Row(
          children: [
            Text(
              'INÍCIO',

              style: GoogleFonts.inter(
                color: Colors.white70,

                fontSize: 8,

                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(width: 20),

            const Icon(Icons.chevron_right, size: 12, color: Colors.white24),

            const SizedBox(width: 20),

            Text(
              'EXPLORAR O UNIVERSO',

              style: GoogleFonts.inter(
                color: Colors.white38,

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
                color: verde,

                fontSize: 8,

                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(width: 28),

            Text(
              _dataAtual(),

              style: GoogleFonts.inter(color: Colors.white54, fontSize: 8),
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
        color: const Color(0xFF101418),

        borderRadius: BorderRadius.circular(7),

        border: Border.all(color: const Color(0xFF24292E)),
      ),

      clipBehavior: Clip.antiAlias,

      child: Row(
        children: [
          // IMAGEM
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

                      border: Border.all(color: Colors.white24),
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

          // TEXTO
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

                      Text(
                        'DESTAQUE DO ACERVO',

                        style: GoogleFonts.inter(
                          color: verde,

                          fontSize: 7,

                          fontWeight: FontWeight.w700,

                          letterSpacing: 1,
                        ),
                      ),

                      const Spacer(),

                      Text(
                        'Nº 001 — 365',

                        style: GoogleFonts.inter(
                          color: Colors.white24,

                          fontSize: 7,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'UMA NOVA PERSPECTIVA A CADA DIA',

                    style: GoogleFonts.inter(
                      color: verde,

                      fontSize: 7,

                      fontWeight: FontWeight.w700,

                      letterSpacing: .8,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'O universo nunca deixa de\nsurpreender.',

                    style: GoogleFonts.inter(
                      color: Colors.white,

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
                      color: Colors.white38,

                      fontSize: 9,

                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Text(
                    'Imagem do dia • Descoberta em destaque',

                    style: GoogleFonts.inter(
                      color: Colors.white54,

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
            Container(width: 18, height: 1, color: verde),
            const SizedBox(width: 9),
            Text(
              'EXPLORE O INFINITO',
              style: GoogleFonts.inter(
                color: verde,
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
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w300,
            letterSpacing: -0.8,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Explore planetas, galáxias e imagens fascinantes do acervo espacial.',
          style: GoogleFonts.inter(
            color: Colors.white54,
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
            icon: const Icon(Icons.arrow_forward, size: 15),
            label: const Text('EXPLORAR ACERVO'),
            style: OutlinedButton.styleFrom(
              foregroundColor: verde,
              side: const BorderSide(color: verde),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
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
        color: const Color(0xFF101418),
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
                    colors: [Colors.transparent, Color(0xE608090B)],
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
    return Row(
      children: [
        Expanded(child: _itemNavegacao('OLHE PARA CIMA', Icons.north)),

        Expanded(
          child: GestureDetector(
            onTap: widget.onExplorar,

            child: _itemNavegacao(
              'DESCUBRA O DESCONHECIDO',

              Icons.auto_awesome,
            ),
          ),
        ),

        Expanded(
          child: _itemNavegacao('O UNIVERSO É DE TODOS', Icons.auto_awesome),
        ),

        Expanded(
          child: Align(
            alignment: Alignment.centerRight,

            child: Text(
              'OLHE PARA CIMA',

              style: GoogleFonts.inter(color: Colors.white38, fontSize: 7),
            ),
          ),
        ),
      ],
    );
  }

  Widget _itemNavegacao(String texto, IconData icone) {
    return Row(
      children: [
        Text(
          texto,

          style: GoogleFonts.inter(
            color: Colors.white38,

            fontSize: 7,

            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(width: 8),

        Icon(icone, color: verde, size: 12),
      ],
    );
  }

  Widget _rodape() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          'órbita.',

          style: GoogleFonts.inter(
            color: Colors.white,

            fontSize: 20,

            fontWeight: FontWeight.w700,
          ),
        ),

        const Spacer(),

        SizedBox(
          width: 260,

          child: Text(
            'Uma forma de se perder e se encontrar no universo.\n'
            'Imagens e dados: NASA Open APIs.',

            style: GoogleFonts.inter(
              color: Colors.white30,

              fontSize: 8,

              height: 1.5,
            ),
          ),
        ),

        const SizedBox(width: 80),

        Text(
          'VOLTAR AO TOPO ↑',

          style: GoogleFonts.inter(color: Colors.white38, fontSize: 7),
        ),
      ],
    );
  }
}
