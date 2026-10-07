import 'dart:convert';

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

        String ano = '';

        if (data.length >= 4) {
          ano = data.substring(0, 4);
        }

        // Primeiro tenta pegar a imagem diretamente da busca.
        String imagemUrl = _buscarLinkDaBusca(item);

        // Se não encontrou, tenta buscar o arquivo pelo NASA ID.
        if (imagemUrl.isEmpty) {
          imagemUrl = await _buscarImagemDoAsset(nasaId);
        }

        // Se mesmo assim não encontrou uma imagem válida,
        // não adiciona esse item.
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
      } catch (_) {
        // Se um item apresentar problema, continua
        // carregando os outros normalmente.
        continue;
      }
    }

    return fotos;
  }

  String _buscarLinkDaBusca(dynamic item) {
    try {
      final List links = item['links'] ?? [];

      for (final link in links) {
        final String render =
            link['render']?.toString() ?? '';

        final String href =
            link['href']?.toString() ?? '';

        if (render == 'image' && href.isNotEmpty) {
          return href;
        }
      }

      // Segundo método: procura qualquer link que pareça
      // ser um arquivo de imagem.
      for (final link in links) {
        final String href =
            link['href']?.toString() ?? '';

        final String url = href.toLowerCase();

        if (url.endsWith('.jpg') ||
            url.endsWith('.jpeg') ||
            url.endsWith('.png') ||
            url.endsWith('.webp')) {
          return href;
        }
      }
    } catch (_) {
      return '';
    }

    return '';
  }

  Future<String> _buscarImagemDoAsset(String nasaId) async {
    try {
      final uri = Uri.parse(
        '$baseUrl/asset/$nasaId',
      );

      final resposta = await http.get(uri);

      if (resposta.statusCode != 200) {
        return '';
      }

      final dados = jsonDecode(resposta.body);

      final List arquivos =
          dados['collection']?['items'] ?? [];

      // Procura primeiro por JPG/JPEG.
      for (final arquivo in arquivos) {
        final String href =
            arquivo['href']?.toString() ?? '';

        final String url = href.toLowerCase();

        if (url.endsWith('.jpg') ||
            url.endsWith('.jpeg')) {
          return href;
        }
      }

      // Depois tenta PNG ou WEBP.
      for (final arquivo in arquivos) {
        final String href =
            arquivo['href']?.toString() ?? '';

        final String url = href.toLowerCase();

        if (url.endsWith('.png') ||
            url.endsWith('.webp')) {
          return href;
        }
      }

      // Última tentativa: qualquer arquivo retornado.
      if (arquivos.isNotEmpty) {
        final String href =
            arquivos.first['href']?.toString() ?? '';

        if (href.isNotEmpty) {
          return href;
        }
      }
    } catch (_) {
      return '';
    }

    return '';
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

    return fotos
        .map(
          (foto) => Photo(
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
          ),
        )
        .toList();
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