import 'package:flutter/material.dart';
import '../entities/jogador.dart';

class TelaCadastroJogador extends StatefulWidget {
  final Jogador? jogador;

  const TelaCadastroJogador({super.key, this.jogador});

  @override
  State<TelaCadastroJogador> createState() => _TelaCadastroJogadorState();
}

class _TelaCadastroJogadaorState extends State<TelaCadastroJogador> {
  late TextEditingController nomeController;
  late TextEditingController idadeController;
  late TextEditingController clubeController;
}
