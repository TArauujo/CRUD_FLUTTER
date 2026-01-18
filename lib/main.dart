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

class _TelaJogadoresState extends State<TelaJogadores> {
  final TextEditingController controller = TextEditingController();

  final List<String> jogadores = [];

  void adicionarJogador() {
    if (controller.text.isEmpty) return;

    setState(() {
      jogadores.add(controller.text);
      controller.clear();
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
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Nome do Jogador',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
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
                        'Nome: ${jogadores[index]}',
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
