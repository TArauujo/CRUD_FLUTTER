import 'package:flutter/material.dart';
import '../entities/jogador.dart';

class TelaCadastroJogador extends StatefulWidget {
  final Jogador? jogador; // null = CREATE | preenchido = EDIT

  const TelaCadastroJogador({super.key, this.jogador});

  @override
  State<TelaCadastroJogador> createState() => _TelaCadastroJogadorState();
}

class _TelaCadastroJogadorState extends State<TelaCadastroJogador> {
  late TextEditingController nomeController;
  late TextEditingController idadeController;
  late TextEditingController clubeController;

  @override
  void initState() {
    super.initState();

    nomeController = TextEditingController(text: widget.jogador?.nome ?? '');
    idadeController = TextEditingController(
      text: widget.jogador?.idade.toString() ?? '',
    );
    clubeController = TextEditingController(text: widget.jogador?.clube ?? '');
  }

  void salvar() {
    if (nomeController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Informe um nome válido')));
      return;
    }

    final int idade = int.tryParse(idadeController.text) ?? 0;
    if (idade <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Idade inválida')));
      return;
    }

    if (clubeController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Informe um clube válido')));
      return;
    }

    final jogador = Jogador(
      nome: nomeController.text,
      idade: idade,
      clube: clubeController.text,
    );

    Navigator.pop(context, jogador); // 🔥 retorna o jogador
  }

  @override
  Widget build(BuildContext context) {
    final bool editando = widget.jogador != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(editando ? 'Editar Jogador' : 'Novo Jogador'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome do Jogador',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: idadeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Idade',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: clubeController,
              decoration: const InputDecoration(
                labelText: 'Clube',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: salvar,
              child: Text(editando ? 'Salvar Alterações' : 'Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
