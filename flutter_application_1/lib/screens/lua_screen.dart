import 'package:flutter/material.dart';

class LuaScreen extends StatelessWidget {
  const LuaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF080A0C),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                'Lua',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Explore nosso satélite natural.',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 30),

              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  children: [
                    _card(
                      'Lua',
                      'Nosso satélite natural.',
                      Icons.nightlight_round,
                    ),
                    _card(
                      'Fases da Lua',
                      'As diferentes fases observadas da Terra.',
                      Icons.brightness_2,
                    ),
                    _card(
                      'Superfície',
                      'Crateras e características da superfície lunar.',
                      Icons.circle_outlined,
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

  Widget _card(
    String titulo,
    String descricao,
    IconData icone,
  ) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF101419),
        borderRadius:
            BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF202328),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            icone,
            color: const Color(0xFFC6FF00),
            size: 32,
          ),

          const Spacer(),

          Text(
            titulo,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            descricao,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}