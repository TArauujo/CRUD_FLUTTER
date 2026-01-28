import 'package:flutter/material.dart';
import '../entities/jogador.dart';

class TelaListaJogadores extends StatefulWidget {
  final List<Jogador> jogadores;
  final Function(int) onRemover;
  final Function(int, Jogador) onEditar;

  const TelaListaJogadores({
    super.key,
    required this.jogadores,
    required this.onRemover,
    required this.onEditar,
  });

  @override
  State<TelaListaJogadores> createState() => _TelaListaJogadoresState();
}

class _TelaListaJogadoresState extends State<TelaListaJogadores> {
  void removerJogador(int index) {
    setState(() {
      widget.jogadores.removeAt(index);
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
      appBar: AppBar(
        title: const Text('Jogadores'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Depois vamos navegar para a tela de CREATE
            },
          ),
        ],
      ),
      body: widget.jogadores.isEmpty
          ? const Center(
              child: Text(
                'Nenhum jogador cadastrado',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: widget.jogadores.length,
              itemBuilder: (context, index) {
                final jogador = widget.jogadores[index];

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  elevation: 3,
                  child: InkWell(
                    onTap: () {
                      widget.onEditar(index, jogador);
                    },
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
                                  jogador.nome,
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
    );
  }
}
