import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/camera.dart';
import '../models/photo.dart';
import '../models/rover.dart';

class NasaApiService {
  static const String baseUrl =
      'https://images-api.nasa.gov';

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

    String pesquisa = '$nomeRover Mars rover';

    if (camera != null && camera.isNotEmpty) {
      pesquisa = '$pesquisa $camera';
    }

    final uri = Uri.parse(
      '$baseUrl/search',
    ).replace(
      queryParameters: {
        'q': pesquisa,
        'media_type': 'image',
        'page': page.toString(),
        'page_size': '30',
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
            imagemUrl = link['href'] ?? '';
            break;
          }
        }

        if (imagemUrl.isEmpty) {
          continue;
        }

        final String nasaId =
            informacoes['nasa_id']?.toString() ?? '';


        final String data =
            informacoes['date_created']?.toString() ??
                '';

        final int id =
            nasaId.hashCode.abs();

        final camera = Camera(
          id: 0,
          name: 'NASA',
          fullName: 'NASA Image and Video Library',
        );

        final roverInformacoes = Rover(
          id: 0,
          name: nomeRover,
          landingDate: '',
          launchDate: '',
          status: 'Ativo',
          maxSol: 0,
          maxDate: data,
          totalPhotos: 0,
        );

        final foto = Photo(
          id: id,
          sol: sol,
          imgSrc: imagemUrl,
          earthDate: data.isNotEmpty
              ? data.substring(0, 10)
              : '',
          camera: camera,
          rover: roverInformacoes,
        );

        fotos.add(foto);
      } catch (_) {
        continue;
      }
    }

    return fotos;
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