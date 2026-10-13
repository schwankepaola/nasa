import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/camera.dart';
import '../models/photo.dart';
import '../models/rover.dart';

class NasaApiService {
  static const String baseUrl = 'https://images-api.nasa.gov';

  Future<List<Photo>> buscarImagens({
    required String consulta,
    int page = 1,
    int pageSize = 30,
  }) async {
    final uri = Uri.parse('$baseUrl/search').replace(
      queryParameters: {
        'q': consulta,
        'media_type': 'image',
        'page': page.toString(),
        'page_size': pageSize.toString(),
      },
    );

    final resposta = await http.get(uri);

    if (resposta.statusCode != 200) {
      throw Exception(
        'Erro ao consultar a NASA: ${resposta.statusCode}',
      );
    }

    final dados = jsonDecode(resposta.body);
    final List itens = dados['collection']?['items'] ?? [];
    final List<Photo> fotos = [];

    for (final item in itens) {
      try {
        final List dadosImagem = item['data'] ?? [];

        if (dadosImagem.isEmpty) {
          continue;
        }

        final Map<String, dynamic> informacoes =
            Map<String, dynamic>.from(dadosImagem.first);

        final String nasaId =
            informacoes['nasa_id']?.toString() ?? '';

        if (nasaId.isEmpty) {
          continue;
        }

        final String titulo =
            informacoes['title']?.toString() ?? 'Imagem da NASA';

        final String data =
            informacoes['date_created']?.toString() ?? '';

        final String fonte =
            informacoes['center']?.toString() ?? 'NASA';

        final String ano =
            data.length >= 4 ? data.substring(0, 4) : '';

        String imagemUrl = _buscarLinkDaBusca(item);

        if (imagemUrl.isEmpty) {
          imagemUrl = await _buscarImagemDoAsset(nasaId);
        }

        if (imagemUrl.isEmpty) {
          continue;
        }

        final int id = nasaId.hashCode.abs();

        final camera = Camera(
          id: 0,
          name: 'NASA',
          fullName: 'NASA Image and Video Library',
        );

        final rover = Rover(
          id: 0,
          name: 'NASA',
          landingDate: '',
          launchDate: '',
          status: 'Acervo',
          maxSol: 0,
          maxDate: data,
          totalPhotos: 0,
        );

        fotos.add(
          Photo(
            id: id,
            sol: 0,
            imgSrc: imagemUrl,
            earthDate: data.length >= 10
                ? data.substring(0, 10)
                : data,
            titulo: titulo,
            fonte: fonte,
            ano: ano,
            camera: camera,
            rover: rover,
          ),
        );
      } catch (e) {
        debugPrint('Erro ao processar imagem da NASA: $e');
      }
    }

    return fotos;
  }

  String _buscarLinkDaBusca(dynamic item) {
    try {
      final List links = item['links'] ?? [];

      // Prioriza arquivos de imagem maiores.
      const prioridades = [
        '~large.',
        '~orig.',
        '~medium.',
        '~small.',
        '~thumb.',
      ];

      for (final prioridade in prioridades) {
        for (final link in links) {
          final String href = link['href']?.toString() ?? '';
          final String render = link['render']?.toString() ?? '';
          final String url = href.toLowerCase();

          if (href.isNotEmpty &&
              render == 'image' &&
              _formatoImagem(url) &&
              url.contains(prioridade)) {
            return _normalizarUrl(href);
          }
        }
      }

      // Tenta encontrar qualquer link de imagem.
      for (final link in links) {
        final String href = link['href']?.toString() ?? '';
        final String render = link['render']?.toString() ?? '';

        if (href.isNotEmpty &&
            render == 'image' &&
            _formatoImagem(href.toLowerCase())) {
          return _normalizarUrl(href);
        }
      }

      // Algumas respostas não informam render = image.
      for (final link in links) {
        final String href = link['href']?.toString() ?? '';

        if (href.isNotEmpty &&
            _formatoImagem(href.toLowerCase())) {
          return _normalizarUrl(href);
        }
      }
    } catch (e) {
      debugPrint('Erro ao localizar imagem: $e');
    }

    return '';
  }

  Future<String> _buscarImagemDoAsset(String nasaId) async {
    try {
      final uri = Uri.parse('$baseUrl/asset/$nasaId');
      final resposta = await http.get(uri);

      if (resposta.statusCode != 200) {
        return '';
      }

      final dados = jsonDecode(resposta.body);
      final List arquivos = dados['collection']?['items'] ?? [];

      const prioridades = [
        '~large.',
        '~orig.',
        '~medium.',
        '~small.',
        '~thumb.',
      ];

      for (final prioridade in prioridades) {
        for (final arquivo in arquivos) {
          final String href = arquivo['href']?.toString() ?? '';
          final String url = href.toLowerCase();

          if (href.isNotEmpty &&
              _formatoImagem(url) &&
              url.contains(prioridade)) {
            return _normalizarUrl(href);
          }
        }
      }

      // Alternativa: procura qualquer arquivo de imagem.
      for (final arquivo in arquivos) {
        final String href = arquivo['href']?.toString() ?? '';

        if (href.isNotEmpty &&
            _formatoImagem(href.toLowerCase())) {
          return _normalizarUrl(href);
        }
      }
    } catch (e) {
      debugPrint('Erro ao buscar arquivo $nasaId: $e');
    }

    return '';
  }

  bool _formatoImagem(String url) {
    final String caminho = url.split('?').first.toLowerCase();

    return caminho.endsWith('.jpg') ||
        caminho.endsWith('.jpeg') ||
        caminho.endsWith('.png') ||
        caminho.endsWith('.webp');
  }

  String _normalizarUrl(String url) {
    if (url.startsWith('http://')) {
      return url.replaceFirst('http://', 'https://');
    }

    return url;
  }

  Future<List<Photo>> buscarFotos({
    String rover = 'curiosity',
    int sol = 1000,
    String? camera,
    int page = 1,
  }) async {
    String nomeRover;

    switch (rover.toLowerCase()) {
      case 'opportunity':
        nomeRover = 'Opportunity';
        break;
      case 'spirit':
        nomeRover = 'Spirit';
        break;
      default:
        nomeRover = 'Curiosity';
    }

    String consulta = '$nomeRover Mars rover';

    if (camera != null && camera.isNotEmpty) {
      consulta = '$consulta $camera';
    }

    final fotos = await buscarImagens(
      consulta: consulta,
      page: page,
    );

    return fotos.map((foto) {
      return Photo(
        id: foto.id,
        sol: sol,
        imgSrc: foto.imgSrc,
        earthDate: foto.earthDate,
        titulo: foto.titulo,
        fonte: foto.fonte,
        ano: foto.ano,
        camera: foto.camera,
        rover: Rover(
          id: 0,
          name: nomeRover,
          landingDate: '',
          launchDate: '',
          status: 'Acervo',
          maxSol: 0,
          maxDate: foto.earthDate,
          totalPhotos: 0,
        ),
      );
    }).toList();
  }

  Future<List<Photo>> buscarFotosRecentes({
    String rover = 'curiosity',
  }) async {
    return buscarFotos(
      rover: rover,
      page: 1,
    );
  }
}
