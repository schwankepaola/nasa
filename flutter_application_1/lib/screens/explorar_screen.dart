import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExplorarScreen extends StatelessWidget {
  const ExplorarScreen({super.key});

  static const Color verde = Color(0xFFC6FF00);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF08090B),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'UM UNIVERSO PARA EXPLORAR',
                style: GoogleFonts.inter(
                  color: verde,
                  fontSize: 8,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),

              const SizedBox(height: 18),

              RichText(
                text: TextSpan(
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.w300,
                    letterSpacing: -1.5,
                  ),
                  children: const [
                    TextSpan(text: 'Explore o '),
                    TextSpan(
                      text: 'infinito.',
                      style: TextStyle(color: verde),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Viaje pelo acervo visual da NASA, uma descoberta de cada vez.',
                style: GoogleFonts.inter(color: Colors.white54, fontSize: 10),
              ),

              const SizedBox(height: 30),

              // ABAS
              const SizedBox(height: 25),

              // CARDS
              GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 25,
                childAspectRatio: 0.82,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _card(
                    'https://images-assets.nasa.gov/image/PIA04921/PIA04921~orig.jpg',
                    'Weighing in on the Dumbbell Nebula',
                    'JPL',
                    '2011',
                  ),
                  _card(
                    'https://images-assets.nasa.gov/image/PIA04205/PIA04205~orig.jpg',
                    'Ant Nebula',
                    'JPL',
                    '1999',
                  ),
                  _card(
                    'https://images-assets.nasa.gov/image/PIA04228/PIA04228~orig.jpg',
                    'Planetary Nebula',
                    'GSSC',
                    '2017',
                  ),
                  _card(
                    'https://images-assets.nasa.gov/image/PIA04227/PIA04227~orig.jpg',
                    'Trifid Nebula',
                    'JPL',
                    '1999',
                  ),
                  _card(
                    'https://images-assets.nasa.gov/image/PIA04228/PIA04228~orig.jpg',
                    'M4 Nebula',
                    'JPL',
                    '1999',
                  ),
                  _card(
                    'https://images-assets.nasa.gov/image/PIA04229/PIA04229~orig.jpg',
                    'NGC 7293, the Helix Nebula',
                    'JPL',
                    '2012',
                  ),
                ],
              ),

              const SizedBox(height: 50),

              Container(height: 1, color: const Color(0xFF202328)),

              const SizedBox(height: 30),

              Row(
                children: [
                  Text(
                    'órbita.',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Uma forma de se perder e se encontrar no universo.',
                    style: GoogleFonts.inter(
                      color: Colors.white30,
                      fontSize: 8,
                    ),
                  ),
                  const SizedBox(width: 80),
                  Text(
                    'VOLTAR AO TOPO ↑',
                    style: GoogleFonts.inter(
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

  Widget _card(String imagem, String titulo, String fonte, String ano) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF24292E)),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              imagem,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFF101419),
                  child: const Center(
                    child: Icon(
                      Icons.image_outlined,
                      color: Colors.white24,
                      size: 30,
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 8),

        Row(
          children: [
            Text(
              fonte,
              style: GoogleFonts.inter(color: Colors.white38, fontSize: 7),
            ),
            const Spacer(),
            Text(
              ano,
              style: GoogleFonts.inter(color: Colors.white38, fontSize: 7),
            ),
          ],
        ),

        const SizedBox(height: 6),

        Row(
          children: [
            Expanded(
              child: Text(
                titulo,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(color: Colors.white, fontSize: 9),
              ),
            ),
            const Icon(Icons.favorite_border, color: Colors.white38, size: 15),
          ],
        ),
      ],
    );
  }
}
