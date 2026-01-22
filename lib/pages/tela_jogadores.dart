import 'package:flutter/material.dart';
import '../entities/jogador.dart';

class TelaJogadores extends StatefulWidget {
  const TelaJogadores({super.key});

  @override
  State<TelaJogadores> createState() => _TelaJogadoresState();
}

class _TelaJogadoresState extends State<TelaJogadores> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();
  final TextEditingController clubeController = TextEditingController();

  void editarJogador(int index) {
    nomeController.text = jogadores[index].nome;
    idadeController.text = jogadores[index].idade.toString();
    clubeController.text = jogadores[index].clube;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Jogador'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: idadeController,
                decoration: const InputDecoration(labelText: 'Idade'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: clubeController,
                decoration: const InputDecoration(labelText: 'Clube'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final int idade = int.tryParse(idadeController.text) ?? 0;

                setState(() {
                  jogadores[index] = Jogador(
                    nome: nomeController.text,
                    idade: idade,
                    clube: clubeController.text,
                  );
                });

                nomeController.clear();
                idadeController.clear();
                clubeController.clear();
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  final List<Jogador> jogadores = [];

  void adicionarJogador() {
    if (nomeController.text.isEmpty || idadeController.text.isEmpty) return;

    final int idade = int.tryParse(idadeController.text) ?? 0;

    setState(() {
      jogadores.add(
        Jogador(
          nome: nomeController.text,
          idade: idade,
          clube: clubeController.text,
        ),
      );
      nomeController.clear();
      idadeController.clear();
      clubeController.clear();
    });
  }

  void removerJogador(int index) {
    setState(() {
      jogadores.removeAt(index);
    });
  }

  void confirmarRemocao(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar exclusão!'),
          content: const Text('Deseja realmente remover este jogador?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                removerJogador(index);
                Navigator.of(context).pop();
              },
              child: const Text('Excluir', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
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

            SizedBox(height: 13),

            TextField(
              controller: clubeController,
              decoration: const InputDecoration(
                labelText: 'Clube do Jogador',
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

            const Text(
              'Clique em um jogador para editar as informações!!',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.deepOrange,
              ),
            ),

            //READ
            Expanded(
              child: ListView.builder(
                //Aqui que ele cria o index para cada jogador
                itemCount: jogadores.length,
                itemBuilder: (context, index) {
                  final jogador = jogadores[index];
                  //return ListTile(title: Text('Nome: ${jogadores[index]}')); //O ListTile, por padrão, alinha o texto sempre para a esquerda.
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    elevation: 3,
                    child: InkWell(
                      onTap: () => editarJogador(
                        //A função de editar sendo chamado. Com o clique no jogador, ele descobre o index. Muito Massa!!!
                        index,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Nome: ${jogador.nome}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => confirmarRemocao(index),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text('Idade: ${jogador.idade}'),
                            const SizedBox(height: 2),
                            Text('Clube: ${jogador.clube}'),
                          ],
                        ),
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
