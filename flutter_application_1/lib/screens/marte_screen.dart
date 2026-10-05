import 'package:flutter/material.dart';

import '../models/photo.dart';
import '../services/nasa_api_service.dart';
import '../widgets/photo_card.dart';

class MarteScreen extends StatefulWidget {
  const MarteScreen({super.key});

  @override
  State<MarteScreen> createState() => _MarteScreenState();
}

class _MarteScreenState extends State<MarteScreen> {
  final NasaApiService api = NasaApiService();

  List<Photo> fotos = [];

  bool carregando = true;
  String mensagemErro = '';

  String rover = 'curiosity';

  @override
  void initState() {
    super.initState();
    carregarFotos();
  }

  Future<void> carregarFotos() async {
    setState(() {
      carregando = true;
      mensagemErro = '';
    });

    try {
      final resultado = await api.buscarFotos(
        rover: rover,
        sol: 1000,
      );

      if (!mounted) return;

      setState(() {
        fotos = resultado;
        carregando = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        carregando = false;
        mensagemErro = 'Erro ao carregar as fotos.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080A0C),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Marte',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Explore imagens capturadas pelos rovers da NASA.',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 25),

              Row(
                children: [
                  botaoRover(
                    'Curiosity',
                    'curiosity',
                  ),
                  const SizedBox(width: 10),
                  botaoRover(
                    'Opportunity',
                    'opportunity',
                  ),
                  const SizedBox(width: 10),
                  botaoRover(
                    'Spirit',
                    'spirit',
                  ),
                ],
              ),

              const SizedBox(height: 25),

              Expanded(
                child: construirConteudo(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget botaoRover(
    String nome,
    String valor,
  ) {
    final bool selecionado = rover == valor;

    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: () {
        if (rover == valor) {
          return;
        }

        setState(() {
          rover = valor;
        });

        carregarFotos();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: selecionado
              ? const Color(0xFFC6FF00)
              : const Color(0xFF101419),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          nome,
          style: TextStyle(
            color: selecionado
                ? Colors.black
                : Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget construirConteudo() {
    if (carregando) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFFC6FF00),
        ),
      );
    }

    if (mensagemErro.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.white54,
              size: 40,
            ),

            const SizedBox(height: 15),

            Text(
              mensagemErro,
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: carregarFotos,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFFC6FF00),
                foregroundColor: Colors.black,
              ),
              child: const Text(
                'Tentar novamente',
              ),
            ),
          ],
        ),
      );
    }

    if (fotos.isEmpty) {
      return const Center(
        child: Text(
          'Nenhuma foto encontrada.',
          style: TextStyle(
            color: Colors.white54,
          ),
        ),
      );
    }

    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 1.15,
      ),
      itemCount: fotos.length,
      itemBuilder: (context, index) {
        final foto = fotos[index];

        return PhotoCard(
          foto: foto,
          onTap: () {
            abrirDetalhes(foto);
          },
        );
      },
    );
  }

  void abrirDetalhes(Photo foto) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalheFotoPage(
          foto: foto,
        ),
      ),
    );
  }
}

class DetalheFotoPage extends StatelessWidget {
  final Photo foto;

  const DetalheFotoPage({
    super.key,
    required this.foto,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080A0C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF080A0C),
        foregroundColor: Colors.white,
        title: const Text('Detalhes'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              foto.imgSrc,
              width: double.infinity,
              fit: BoxFit.contain,
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    foto.rover.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  detalhe(
                    'Câmera',
                    foto.camera.fullName,
                  ),

                  detalhe(
                    'Data',
                    foto.earthDate,
                  ),

                  detalhe(
                    'Sol',
                    foto.sol.toString(),
                  ),

                  detalhe(
                    'ID',
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

  Widget detalhe(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              titulo,
              style: const TextStyle(
                color: Color(0xFFC6FF00),
                fontWeight: FontWeight.bold,
              ),
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