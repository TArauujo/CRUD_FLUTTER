import 'package:flutter/material.dart';
import 'pages/tela_lista_jogadores.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TelaListaJogadores());
  }
}
