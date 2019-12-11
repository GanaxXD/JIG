import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_is_a_game_app/models/user.dart';

//AULA 177 - ORDER TILE
class WorkFlowStatus extends StatelessWidget {

  //Esse questId tem que ser o idQuest disponível em questsAceitas
  final String questId;
  final User user;
  WorkFlowStatus(this.questId, this.user);

  
  @override
  Widget build(BuildContext context) {
    return Card(
          margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: StreamBuilder<DocumentSnapshot>(
              //Ao criar a quest, preciso inserir um campo chamado status. Talvez eu precise usar as questsAceitas
                stream: Firestore.instance.collection("quests")
                    .document(questId).snapshots(),//Firestore.instance.collection("quests").document(questId).snapshots(),
                builder: (context, snapshot){
                  if (!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(backgroundColor: Colors.indigo, semanticsValue: "Carregando...",semanticsLabel: "Carregando...",),
                    );
                  else {
                    int status = snapshot.data["status"];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Status da Missão: ", style: TextStyle(
                            fontWeight: FontWeight.bold, fontFamily: 'Helvetica', fontSize: 12
                        ),),
                        SizedBox(height: 4.0,),

                        //AULA 179: para o status, as quests precisam de um numero
                        // inteiro representando o status
                        SizedBox(height: 4.0),

                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: <Widget>[
                              _buildCircle("1", "Iniciada", status, 1),
                              //Linha entre ícones: AULA 179: 08:45
                              Container(
                                height: 1.0,
                                width: 40.0,
                                color: Colors.grey[500],
                              ),
                              _buildCircle("2", "Em Andamento", status, 2),
                              Container(
                                height: 1.0,
                                width: 40.0,
                                color: Colors.grey[500],
                              ),
                              _buildCircle("3", "Concluída", status, 3),
                            ],
                        ),

                      ],
                    );
                  }
                }
            ),

          ),
        );
  }

  //AULA 178: mostrando detalhes da quest por uma função. Não vou usar porque os dados já estão no card
  String _buildQuestsText (DocumentSnapshot snapshot){
    String text = "Descrição:\n";
    //São as listas do Firbase
    for(LinkedHashMap q in snapshot.data["questDados"]){
      text += "${q["xp"]}";
    }
  }

  //AULA 179:
  Widget _buildCircle(String titulo, String subtitulo, int status, int thisStatus){

    Color backColor;
    Widget child;

    if(status < thisStatus){
      backColor = Colors.black38;
      child = Text(titulo, style: TextStyle(
        color: Colors.white
      ),);
    } else if (status == thisStatus){
      backColor = Colors.indigo;
      child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(titulo, style: TextStyle(
          color: Colors.white
          ),),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      );
    } else {
      backColor = Colors.green;
      child = Icon(Icons.check, color: Colors.white,);
    }

    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20,
          backgroundColor: backColor,
          child: child,
        ),
        Text(subtitulo),
      ],
    );

  }
}
