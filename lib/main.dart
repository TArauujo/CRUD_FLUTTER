import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TelaJogadores());
  }
}

class TelaJogadores extends StatefulWidget {
  const TelaJogadores({super.key});

  @override
  State<TelaJogadores> createState() => _TelaJogadoresState();
}

class Jogador {
  final String nome;
  final int idade;

  Jogador({required this.nome, required this.idade});
}

class _TelaJogadoresState extends State<TelaJogadores> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();

  final List<Jogador> jogadores = [];

  void adicionarJogador() {
    if (nomeController.text.isEmpty || idadeController.text.isEmpty) return;

    final int idade = int.tryParse(idadeController.text) ?? 0;

    setState(() {
      jogadores.add(Jogador(nome: nomeController.text, idade: idade));
      nomeController.clear();
      idadeController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CREATE simples'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            //CREATE
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome do Jogador',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 13),

            TextField(
              controller: idadeController,
              decoration: const InputDecoration(
                labelText: 'Idade do Jogador',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: adicionarJogador,
              child: const Text('Adicionar'),
            ),

            const SizedBox(height: 20),

            // CABEÇALHO
            const Text(
              'Jogadores Cadastrados',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            //READ
            Expanded(
              child: ListView.builder(
                itemCount: jogadores.length,
                itemBuilder: (context, index) {
                  //return ListTile(title: Text('Nome: ${jogadores[index]}')); //O ListTile, por padrão, alinha o texto sempre para a esquerda.
                  return ListTile(
                    title: Center(
                      child: Text(
                        'Nome: ${jogadores[index].nome} / Idade: ${jogadores[index].idade}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
