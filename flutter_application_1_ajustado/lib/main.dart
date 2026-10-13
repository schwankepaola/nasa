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
      drawerTheme: DrawerThemeData(
        backgroundColor: temaEscuro
            ? const Color(0xFF0A0B0D)
            : const Color(0xFFE9EDE5),
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

  static const Color verde = Color(0xFFC6FF00);

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
      debugPrint('Erro ao abrir o link $endereco: $e');
    }
  }

  Future<void> visitarNasa() async {
    await abrirLink('https://www.nasa.gov/');
  }

  Future<void> abrirApisNasa() async {
    await abrirLink('https://api.nasa.gov/');
  }

  Widget criarSidebar({required bool mobile}) {
    return Sidebar(
      paginaSelecionada: paginaSelecionada,
      onPaginaSelecionada: (indice) {
        selecionarPagina(indice);

        if (mobile) {
          Navigator.of(context).pop();
        }
      },
      onVisitarNasa: visitarNasa,
      onAbrirApis: abrirApisNasa,
      temaEscuro: widget.temaEscuro,
      onAlternarTema: widget.onAlternarTema,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool mobile = constraints.maxWidth < 800;

        if (mobile) {
          return Scaffold(
            backgroundColor:
                Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              titleSpacing: 0,
              title: Row(
                children: [
                  Container(
                    width: 27,
                    height: 27,
                    decoration: BoxDecoration(
                      color: verde,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.all_inclusive,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 9),
                  const Text(
                    'órbita.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  tooltip: widget.temaEscuro
                      ? 'Ativar tema claro'
                      : 'Ativar tema escuro',
                  onPressed: widget.onAlternarTema,
                  icon: Icon(
                    widget.temaEscuro
                        ? Icons.light_mode_outlined
                        : Icons.dark_mode_outlined,
                    color: widget.temaEscuro
                        ? verde
                        : const Color(0xFF45651B),
                  ),
                ),
                const SizedBox(width: 6),
              ],
            ),
            drawer: Drawer(
              width: 220,
              child: SafeArea(
                child: criarSidebar(mobile: true),
              ),
            ),
            body: SafeArea(
              top: false,
              child: paginas[paginaSelecionada],
            ),
          );
        }

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Row(
            children: [
              SizedBox(
                width: 220,
                child: criarSidebar(mobile: false),
              ),
              Expanded(
                child: paginas[paginaSelecionada],
              ),
            ],
          ),
        );
      },
    );
  }
}
