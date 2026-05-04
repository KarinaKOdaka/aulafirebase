import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/mensagens.dart';

class TelaAdicionar extends StatefulWidget {
  @override
  _TelaAdicionarState createState() => _TelaAdicionarState();
}

class _TelaAdicionarState extends State<TelaAdicionar> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _friendController = TextEditingController();
  final TextEditingController _msgController = TextEditingController();

  void salvarMensagem() async {
    if (_msgController.text.isEmpty) return;

    final mensagem = Mensagens(
      user: _userController.text,
      friend: _friendController.text,
      msg: _msgController.text,
    );

    await FirebaseFirestore.instance
        .collection('msg')
        .add(mensagem.toJson());

    _msgController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Mensagem enviada!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrar cliente"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _userController,
              decoration: InputDecoration(labelText: "Usuário"),
            ),
            TextField(
              controller: _friendController,
              decoration: InputDecoration(labelText: "Amigo"),
            ),
            TextField(
              controller: _msgController,
              decoration: InputDecoration(labelText: "Mensagem"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: salvarMensagem,
              child: Text("Salvar"),
            )
          ],
        ),
      ),
    );
  }
}
