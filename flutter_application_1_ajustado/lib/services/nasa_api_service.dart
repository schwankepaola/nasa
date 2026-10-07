import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/camera.dart';
import '../models/photo.dart';
import '../models/rover.dart';

class NasaApiService {
  static const String baseUrl =
      'https://images-api.nasa.gov';

  Future<List<Photo>> buscarImagens({
    required String consulta,
    int page = 1,
    int pageSize = 30,
  }) async {
    final uri = Uri.parse(
      '$baseUrl/search',
    ).replace(
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

    final List itens =
        dados['collection']?['items'] ?? [];

    final List<Photo> fotos = [];

    for (final item in itens) {
      try {
        final List dadosImagem =
            item['data'] ?? [];

        if (dadosImagem.isEmpty) {
          continue;
        }

        final Map<String, dynamic> informacoes =
            Map<String, dynamic>.from(
          dadosImagem.first,
        );

        final List links =
            item['links'] ?? [];

        String imagemUrl = '';

        for (final link in links) {
          if (link['render'] == 'image') {
            imagemUrl =
                link['href']?.toString() ?? '';
            break;
          }
        }

        if (imagemUrl.isEmpty) {
          continue;
        }

        final String nasaId =
            informacoes['nasa_id']?.toString() ??
                '';

        final String titulo =
            informacoes['title']?.toString() ??
                'Imagem da NASA';

        final String data =
            informacoes['date_created']
                    ?.toString() ??
                '';

        final String fonte =
            informacoes['center']?.toString() ??
                'NASA';

        String ano = '';

        if (data.length >= 4) {
          ano = data.substring(0, 4);
        }

        final int id =
            nasaId.hashCode.abs();

        final camera = Camera(
          id: 0,
          name: 'NASA',
          fullName:
              'NASA Image and Video Library',
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
        continue;
      }
    }

    return fotos;
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

    String consulta =
        '$nomeRover Mars rover';

    if (camera != null &&
        camera.isNotEmpty) {
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
