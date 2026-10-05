import 'package:flutter/material.dart';

import 'screens/explorar_screen.dart';
import 'screens/galaxias_screen.dart';
import 'screens/lua_screen.dart';
import 'screens/marte_screen.dart';
import 'screens/terra_screen.dart';
import 'widgets/top_navigation.dart';

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
  int paginaSelecionada = 0;

  final List<Widget> paginas = const [
    ExplorarScreen(),
    GalaxiasScreen(),
    MarteScreen(),
    TerraScreen(),
    LuaScreen(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF08090B),
      body: Column(
        children: [
          TopNavigation(
            paginaSelecionada:
                paginaSelecionada,
            onPaginaSelecionada:
                selecionarPagina,
          ),

          Expanded(
            child: paginas[
              paginaSelecionada
            ],
          ),
        ],
      ),
    );
  }
}