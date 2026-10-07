import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'screens/explorar_flow_screen.dart';
import 'screens/favoritos_screen.dart';
import 'screens/galaxias_screen.dart';
import 'screens/home_screen.dart';
import 'screens/lua_screen.dart';
import 'screens/marte_screen.dart';
import 'screens/terra_screen.dart';
import 'widgets/sidebar.dart';

void main() {
  runApp(const OrbitaApp());
}

class OrbitaApp extends StatelessWidget {
  const OrbitaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Órbita',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor:
            const Color(0xFF08090B),
        fontFamily: 'Arial',
      ),
      home: const PrincipalScreen(),
    );
  }
}

class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({super.key});

  @override
  State<PrincipalScreen> createState() =>
      _PrincipalScreenState();
}

class _PrincipalScreenState
    extends State<PrincipalScreen> {
  int paginaSelecionada = 1;

  late final List<Widget> paginas = [
    const HomeScreen(),
    ExplorarFlowScreen(
      onPaginaSelecionada:
          selecionarPagina,
    ),
    FavoritosScreen(
      onExplorar: () => selecionarPagina(1),
    ),
    GalaxiasScreen(
      onPaginaSelecionada:
          selecionarPagina,
    ),
    MarteScreen(
      onPaginaSelecionada:
          selecionarPagina,
    ),
    TerraScreen(
      onPaginaSelecionada:
          selecionarPagina,
    ),
    LuaScreen(
      onPaginaSelecionada:
          selecionarPagina,
    ),
  ];

  void selecionarPagina(int indice) {
    if (indice < 0 ||
        indice >= paginas.length) {
      return;
    }

    setState(() {
      paginaSelecionada = indice;
    });
  }

  Future<void> visitarNasa() async {
    final Uri url = Uri.parse(
      'https://images-api.nasa.gov',
    );

    await launchUrl(
      url,
      webOnlyWindowName: '_blank',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF08090B),
      body: Row(
        children: [
          Sidebar(
            paginaSelecionada:
                paginaSelecionada,
            onPaginaSelecionada:
                selecionarPagina,
            onVisitarNasa:
                visitarNasa,
          ),
          Expanded(
            child: paginas[
                paginaSelecionada],
          ),
        ],
      ),
    );
  }
}
