import 'package:flutter/foundation.dart';

import '../models/photo.dart';

class FavoritosService {
  static final ValueNotifier<List<Photo>> favoritos =
      ValueNotifier<List<Photo>>([]);

  static bool estaFavorito(Photo foto) {
    return favoritos.value.any(
      (item) => item.id == foto.id,
    );
  }

  static void alternar(Photo foto) {
    final lista = List<Photo>.from(favoritos.value);

    final indice = lista.indexWhere(
      (item) => item.id == foto.id,
    );

    if (indice >= 0) {
      lista.removeAt(indice);
    } else {
      lista.add(foto);
    }

    favoritos.value = lista;
  }
}