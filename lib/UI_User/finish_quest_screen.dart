import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_is_a_game_app/models/quets.dart';
import 'package:job_is_a_game_app/models/user.dart';
import 'package:job_is_a_game_app/tiles/finished_tile.dart';

class QuestsConcluidas extends StatefulWidget {

  User model;
  QuestsConcluidas(this.model);
  QuestsConcluidas.Vazia();
  @override
  _QuestsConcluidasState createState() => _QuestsConcluidasState(this.model);
}

class _QuestsConcluidasState extends State<QuestsConcluidas> {

  final pageControler = PageController();
  User model;

  _QuestsConcluidasState(this.model);
  _QuestsConcluidasState.Vazia();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){},
        child: PageView(
                  controller: pageControler,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[

                    SingleChildScrollView(
                        //scrollDirection: Axis.vertical,
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[

                            Text("Seus feitos honrosos encontram-se registrados aqui. "
                                "Vanglorie-se de suas vitórias!",
                              style: TextStyle(color: Colors.grey,
                                  fontFamily: 'helvetica',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500), textAlign: TextAlign.center,),




                            //QUESTS VINDAS EM FORMATO DE CARDS DO BANCO DE DADOS
                            StreamBuilder(
                                stream: Firestore.instance.collection("usuarios").document(this.model.firebaseUser.uid).
                                    collection("questsConcluidas").snapshots(),
                                builder: (context, snapshot) {
                                  print("===============TELA CONCLUÍDAS ${model.firebaseUser.uid}");
                                  if (!snapshot.hasData) {
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Divider(height: 90,),
                                        Image.asset(
                                          'assets/img/guerreiro.jpg', height: 40,
                                          width: 26,
                                          fit: BoxFit.cover,),
                                        Text("Não há quests concluídas.",
                                          style: TextStyle(
                                              fontFamily: 'Helvetica',
                                              fontSize: 15.0,
                                              color: Colors.indigo),)
                                      ],
                                    );
                                  } else {
                                    return ListView.builder(
                                      itemCount: snapshot.data.documents.length,
                                      shrinkWrap: true,
                                      reverse: false,
                                      scrollDirection: Axis.vertical,
                                      physics: NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.all(12.0),
                                      itemBuilder: (context, index) {
                                          return FinishedTile(context, Quests.fromDocument(snapshot.data.documents[index]), model);

                                      },
                                    );
                                  } //else
                                }),


                          ],
                        ),
                      ),
                  ],
                ),

        );

  }
}
