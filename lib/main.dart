import 'package:flutter/material.dart';
import 'entities/jogador.dart';
import 'pages/tela_lista_jogadores.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatefulWidget {
  const MeuApp({super.key});

  @override
  State<MeuApp> createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {
  final List<Jogador> jogadores = [];

  void adicionarJogador(Jogador jogador) {
    setState(() {
      jogadores.add(jogador);
    });
  }

  void removerJogador(int index) {
    setState(() {
      jogadores.removeAt(index);
    });
  }

  void editarJogador(int index, Jogador jogador) {
    setState(() {
      jogadores[index] = jogador;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TelaListaJogadores(
        jogadores: jogadores,
        onRemover: removerJogador,
        onEditar: editarJogador,
      ),
    );
  }
}
