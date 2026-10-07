import 'package:flutter/material.dart';

import '../models/photo.dart';

class DetalheScreen extends StatelessWidget {
  final Photo foto;

  const DetalheScreen({
    super.key,
    required this.foto,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0B0D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0B0D),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Detalhes da foto',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FOTO
            SizedBox(
              width: double.infinity,
              child: Image.network(
                foto.imgSrc,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 400,
                    color: const Color(0xFF151719),
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.white38,
                        size: 50,
                      ),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ROVER
                  Text(
                    foto.rover.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Fotografia registrada em ${foto.earthDate}',
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // INFORMAÇÕES
                  _informacao(
                    'Rover',
                    foto.rover.name,
                  ),

                  _informacao(
                    'Câmera',
                    foto.camera.fullName,
                  ),

                  _informacao(
                    'Data',
                    foto.earthDate,
                  ),

                  _informacao(
                    'Sol',
                    foto.sol.toString(),
                  ),

                  _informacao(
                    'ID da foto',
                    foto.id.toString(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _informacao(String titulo, String valor) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF111315),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF202328),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$titulo: ',
            style: const TextStyle(
              color: Color(0xFFC6FF00),
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              valor,
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}