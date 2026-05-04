import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/mensagens.dart';

class TelaConsulta extends StatefulWidget {
  @override
  _TelaConsultaState createState() => _TelaConsultaState();
}

class _TelaConsultaState extends State<TelaConsulta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consultar cliente"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('msg')
            .orderBy('dt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final dados = snapshot.data!.docs;

          if (dados.isEmpty) {
            return Center(child: Text("Nenhum registro encontrado"));
          }

          return ListView.builder(
            itemCount: dados.length,
            itemBuilder: (context, index) {
              final mensagem = Mensagens.fromSnapshot(dados[index]);

              return Card(
                child: ListTile(
                  title: Text(mensagem.msg),
                  subtitle: Text(
                    "${mensagem.user} → ${mensagem.friend}\n${mensagem.dt}",
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}