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

class OrbitaApp extends StatefulWidget {
  const OrbitaApp({super.key});

  @override
  State<OrbitaApp> createState() => _OrbitaAppState();
}

class _OrbitaAppState extends State<OrbitaApp> {
  bool temaEscuro = true;

  void alternarTema() {
    setState(() {
      temaEscuro = !temaEscuro;
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color verde = Color(0xFFC6FF00);

    final ThemeData tema = ThemeData(
      brightness: temaEscuro ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: temaEscuro
          ? const Color(0xFF08090B)
          : const Color(0xFFF4F6F1),
      fontFamily: 'Arial',
      colorScheme: ColorScheme.fromSeed(
        seedColor: verde,
        brightness: temaEscuro ? Brightness.dark : Brightness.light,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: temaEscuro
            ? const Color(0xFF08090B)
            : const Color(0xFFF4F6F1),
        foregroundColor:
            temaEscuro ? Colors.white : const Color(0xFF151715),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Órbita',
      theme: tema,
      home: PrincipalScreen(
        temaEscuro: temaEscuro,
        onAlternarTema: alternarTema,
      ),
    );
  }
}

class PrincipalScreen extends StatefulWidget {
  final bool temaEscuro;
  final VoidCallback onAlternarTema;

  const PrincipalScreen({
    super.key,
    required this.temaEscuro,
    required this.onAlternarTema,
  });

  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  int paginaSelecionada = 1;

  late final List<Widget> paginas = [
    const HomeScreen(),
    ExplorarFlowScreen(
      onPaginaSelecionada: selecionarPagina,
    ),
    FavoritosScreen(
      onExplorar: () => selecionarPagina(1),
    ),
    GalaxiasScreen(
      onPaginaSelecionada: selecionarPagina,
    ),
    MarteScreen(
      onPaginaSelecionada: selecionarPagina,
    ),
    TerraScreen(
      onPaginaSelecionada: selecionarPagina,
    ),
    LuaScreen(
      onPaginaSelecionada: selecionarPagina,
    ),
  ];

  void selecionarPagina(int indice) {
    if (indice < 0 || indice >= paginas.length) {
      return;
    }

    setState(() {
      paginaSelecionada = indice;
    });
  }

  Future<void> abrirLink(String endereco) async {
    final Uri url = Uri.parse(endereco);

    try {
      await launchUrl(
        url,
        webOnlyWindowName: '_blank',
      );
    } catch (e) {
      debugPrint('Não foi possível abrir o link: $e');
    }
  }

  Future<void> visitarNasa() async {
    await abrirLink('https://www.nasa.gov/');
  }

  Future<void> abrirApisNasa() async {
    await abrirLink('https://api.nasa.gov/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Row(
        children: [
          Sidebar(
            paginaSelecionada: paginaSelecionada,
            onPaginaSelecionada: selecionarPagina,
            onVisitarNasa: visitarNasa,
            onAbrirApis: abrirApisNasa,
            temaEscuro: widget.temaEscuro,
            onAlternarTema: widget.onAlternarTema,
          ),
          Expanded(
            child: paginas[paginaSelecionada],
          ),
        ],
      ),
    );
  }
}