import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_is_a_game_app/UI_User/home_user.dart';
import 'package:job_is_a_game_app/UI_User/quests_aceepts_screen.dart';
import 'package:job_is_a_game_app/geral_screens/login_screen.dart';
import 'package:job_is_a_game_app/models/finished_model.dart';
import 'package:job_is_a_game_app/models/questAccepts_model.dart';
import 'package:job_is_a_game_app/models/quests_accepts.dart';
import 'package:job_is_a_game_app/models/user.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scoped_model/scoped_model.dart';


class WorkFlowStatus extends StatefulWidget {
  final String questId;
  final User user;
  final QuestsAccepts questaceita;
  WorkFlowStatus(this.questId, this.user, this.questaceita);

  TextEditingController acao1_controller = TextEditingController();
  TextEditingController acao2_controller = TextEditingController();
  TextEditingController acao3_controller = TextEditingController();
  TextEditingController acao4_controller = TextEditingController();
  TextEditingController acao5_controller = TextEditingController();
  TextEditingController acao6_controller = TextEditingController();
  TextEditingController acao7_controller = TextEditingController();
  TextEditingController acao8_controller = TextEditingController();
  TextEditingController acao9_controller = TextEditingController();
  TextEditingController acao10_controller = TextEditingController();

  TextEditingController cabo1_controller = TextEditingController();
  TextEditingController cabo2_controller = TextEditingController();
  TextEditingController cabo3_controller = TextEditingController();
  TextEditingController cabo4_controller = TextEditingController();
  TextEditingController cabo5_controller = TextEditingController();
  TextEditingController cabo6_controller = TextEditingController();
  TextEditingController cabo7_controller = TextEditingController();
  TextEditingController cabo8_controller = TextEditingController();

  TextEditingController suprimento1_controller = TextEditingController();
  TextEditingController suprimento2_controller = TextEditingController();
  TextEditingController suprimento3_controller = TextEditingController();
  TextEditingController suprimento4_controller = TextEditingController();

  TextEditingController concerto1_controller = TextEditingController();
  TextEditingController concerto2_controller = TextEditingController();
  TextEditingController concerto3_controller = TextEditingController();
  TextEditingController concerto4_controller = TextEditingController();
  TextEditingController concerto5_controller = TextEditingController();
  TextEditingController concerto6_controller = TextEditingController();
  TextEditingController concerto7_controller = TextEditingController();
  TextEditingController concerto8_controller = TextEditingController();


  TextEditingController concerto9_controller = TextEditingController();

  GlobalKey chave = GlobalKey();

  @override
  _WorkFlowStatusState createState() => _WorkFlowStatusState(questId, user, questaceita);
}

class _WorkFlowStatusState extends State<WorkFlowStatus> {

  final String questId;
  final User user;
  final QuestsAccepts questaceita;
  _WorkFlowStatusState(this.questId, this.user, this.questaceita);

  TextEditingController acao1_controller = TextEditingController();
  TextEditingController acao2_controller = TextEditingController();
  TextEditingController acao3_controller = TextEditingController();
  TextEditingController acao4_controller = TextEditingController();
  TextEditingController acao5_controller = TextEditingController();
  TextEditingController acao6_controller = TextEditingController();
  TextEditingController acao7_controller = TextEditingController();
  TextEditingController acao8_controller = TextEditingController();
  TextEditingController acao9_controller = TextEditingController();
  TextEditingController acao10_controller = TextEditingController();

  TextEditingController cabo1_controller = TextEditingController();
  TextEditingController cabo2_controller = TextEditingController();
  TextEditingController cabo3_controller = TextEditingController();
  TextEditingController cabo4_controller = TextEditingController();
  TextEditingController cabo5_controller = TextEditingController();
  TextEditingController cabo6_controller = TextEditingController();
  TextEditingController cabo7_controller = TextEditingController();
  TextEditingController cabo8_controller = TextEditingController();

  TextEditingController suprimento1_controller = TextEditingController();
  TextEditingController suprimento2_controller = TextEditingController();
  TextEditingController suprimento3_controller = TextEditingController();
  TextEditingController suprimento4_controller = TextEditingController();

  TextEditingController concerto1_controller = TextEditingController();
  TextEditingController concerto2_controller = TextEditingController();
  TextEditingController concerto3_controller = TextEditingController();
  TextEditingController concerto4_controller = TextEditingController();
  TextEditingController concerto5_controller = TextEditingController();
  TextEditingController concerto6_controller = TextEditingController();
  TextEditingController concerto7_controller = TextEditingController();
  TextEditingController concerto8_controller = TextEditingController();

  GlobalKey chave = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<User>(
      builder: (context, child, model){
        FinishedModel fm = FinishedModel(user);
        return Card(
          key: chave,
          margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: StreamBuilder<DocumentSnapshot>(
              //Ao criar a quest, preciso inserir um campo chamado status. Talvez eu precise usar as questsAceitas
                stream: Firestore.instance.collection("quests")
                    .document(questId).snapshots(),//Firestore.instance.collection("quests").document(questId).snapshots(),
                // ignore: missing_return
                builder: (context, snapshot){
                  int status = snapshot.data["status"];
                  int idWorkflow = snapshot.data["workflow"];
                  int statusWorkflow = snapshot.data["status_workflow"];
                  int premio = snapshot.data["xp"];
                  if (!snapshot.hasData) {
                    Center(
                      child: CircularProgressIndicator( backgroundColor: Colors.indigo,),
                    );
                  }
                  switch (idWorkflow){
                    case 0:
                      {
                        int qtdProcessos = 10;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Status da Missão: ", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Helvetica',
                                fontSize: 12
                            ),),
                            SizedBox(height: 15,),
                            Text(
                              "Ações Tomadas em cada processo (preencha esse campo com ações realizadas por você): ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Helvetica',
                                  fontSize: 12
                              ),),

                            Column(
                              children: <Widget>[
                                TextField(
                                  controller: acao1_controller,
                                  decoration: InputDecoration(labelText: "1"),
                                  cursorColor: Colors.indigo,
                                ),
                                TextField(
                                  controller: acao2_controller,
                                  decoration: InputDecoration(labelText: "2"),
                                  cursorColor: Colors.indigo,
                                ),
                                TextField(
                                  controller: acao3_controller,
                                  decoration: InputDecoration(labelText: "3"),
                                  cursorColor: Colors.indigo,
                                ),
                                TextField(
                                  controller: acao4_controller,
                                  decoration: InputDecoration(labelText: "4"),
                                  cursorColor: Colors.indigo,
                                ),
                                TextField(
                                  controller: acao5_controller,
                                  decoration: InputDecoration(labelText: "5"),
                                  cursorColor: Colors.indigo,
                                ),
                                TextField(
                                  controller: acao6_controller,
                                  decoration: InputDecoration(labelText: "6"),
                                  cursorColor: Colors.indigo,
                                ),
                                TextField(
                                  controller: acao7_controller,
                                  decoration: InputDecoration(labelText: "7"),
                                  cursorColor: Colors.indigo,
                                ),
                                TextField(
                                  controller: acao8_controller,
                                  decoration: InputDecoration(labelText: "8"),
                                  cursorColor: Colors.indigo,
                                ),
                                TextField(
                                  controller: acao9_controller,
                                  decoration: InputDecoration(labelText: "9"),
                                  cursorColor: Colors.indigo,
                                ),
                                TextField(
                                  controller: acao10_controller,
                                  decoration: InputDecoration(labelText: "10"),
                                  cursorColor: Colors.indigo,
                                ),
                              ],
                            ),

                            SizedBox(height: 15,),

                            Text(
                              "Workflow resumo da Missão (olhe o workflow geral no botão \"Workflow\": ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Helvetica',
                                  fontSize: 12
                              ),),

                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: <Widget>[
                                _buildCircle("1", "Cliente solicita\nvisita",
                                    statusWorkflow, 1),
                                //Linha entre ícones
                                Container(
                                  height: 1.0,
                                  width: 40.0,
                                  color: Colors.grey[500],
                                ),
                                _buildCircle(
                                    "2", "Solicite info.\npara o chamado",
                                    statusWorkflow, 2),
                                Container(
                                  height: 1.0,
                                  width: 40.0,
                                  color: Colors.grey[500],
                                ),
                                _buildCircle(
                                    "3", "Verifique\nestoque", statusWorkflow,
                                    3),
                                Container(
                                  height: 1.0,
                                  width: 40.0,
                                  color: Colors.grey[500],
                                ),
                                _buildCircle(
                                    "4", "Abra\nchamado", statusWorkflow, 4),
                                Container(
                                  height: 1.0,
                                  width: 40.0,
                                  color: Colors.grey[500],
                                ),
                                _buildCircle(
                                    "5", "Dirija-se\nao local", statusWorkflow,
                                    5),
                                Container(
                                  height: 1.0,
                                  width: 40.0,
                                  color: Colors.grey[500],
                                ),
                                _buildCircle(
                                    "6", "Técnico testa\ncomp. defeituoso",
                                    statusWorkflow, 6),
                                Container(
                                  height: 1.0,
                                  width: 40.0,
                                  color: Colors.grey[500],
                                ),
                                _buildCircle("7", "Recolha o\ncomponente",
                                    statusWorkflow, 7),
                                Container(
                                  height: 1.0,
                                  width: 40.0,
                                  color: Colors.grey[500],
                                ),
                                _buildCircle("8", "Troque o \ncomponente",
                                    statusWorkflow, 8),
                                Container(
                                  height: 1.0,
                                  width: 40.0,
                                  color: Colors.grey[500],
                                ),
                                _buildCircle(
                                    "9", "Realize\num teste", statusWorkflow,
                                    9),
                                Container(
                                  height: 1.0,
                                  width: 40.0,
                                  color: Colors.grey[500],
                                ),
                                _buildCircle(
                                    "10", "Finalize\nchamado", statusWorkflow,
                                    10),
                              ],
                            ),

                            SizedBox(height: 20,),

                            InkWell(
                              child: BotaoCircular1(
                                fundo: Colors.grey,
                                texto: Text("Retornar Processo",
                                  style: TextStyle(
                                      color: Colors.indigo),
                                ),
                                corTexto: Colors.white,
                                apertar: (){
                                  statusWorkflow == 1 ?
                                  Firestore.instance.collection("quests").document(questId).updateData({
                                    "status_workflow": 1
                                  })
                                      : Firestore.instance.collection("quests").document(questId).updateData({
                                    "status_workflow": statusWorkflow-1
                                  });
                                },
                              ),
                            ),

                            InkWell(
                              child: BotaoCircular1(
                                fundo: Colors.indigoAccent,
                                texto: Text("Concluir Processo",
                                  style: TextStyle(
                                      color: Colors.white),
                                ),
                                corTexto: Colors.white,
                                apertar: () {
                                  if(statusWorkflow == qtdProcessos) {
                                    Alert(
                                      context: context,
                                      title: "Finalizar Missão?",
                                      desc: "Se a atividade já foi concluída, "
                                          "aperte em \"Sim\" para que você receba o seu prêmio, caso contrário, aperte em \"Não\".",
                                      type: AlertType.warning,
                                      buttons: [
                                        DialogButton(
                                          child: Text(
                                            "Sim",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontFamily: 'Helvetica'),
                                          ),
                                          onPressed: (){
                                            Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("questsAceitas").document(questaceita.idQuestsAceitas).updateData({
                                              "concluida": true,
                                              "acoes_tomadas" : "\n"+ acao1_controller.text +"\n"+ acao2_controller.text + "\n"+ acao3_controller.text
                                                  + "\n"+ acao4_controller.text + "\n"+ acao5_controller.text + "\n"+ acao6_controller.text + "\n"+ acao7_controller.text
                                                  + "\n"+ acao8_controller.text + "\n"+ acao9_controller.text + "\n"+ acao10_controller.text,
                                            });
                                            user.userData["xp"] = user.userData["xp"] + premio;
                                            Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).updateData({
                                              "xp": user.userData["xp"] + premio,
                                            });
                                            Firestore.instance.collection("quests").document(questId).updateData({
                                              "concluida": true,
                                              "acoes_tomadas" : "\n"+ acao1_controller.text +"\n"+ acao2_controller.text + "\n"+ acao3_controller.text
                                                  + "\n"+ acao4_controller.text + "\n"+ acao5_controller.text + "\n"+ acao6_controller.text + "\n"+ acao7_controller.text
                                                  + "\n"+ acao8_controller.text + "\n"+ acao9_controller.text + "\n"+ acao10_controller.text,
                                            });
                                            questaceita.concluida=true;
                                            questaceita.acoesTomadas = "\n"+ acao1_controller.text +"\n"+ acao2_controller.text + "\n"+ acao3_controller.text
                                                + "\n"+ acao4_controller.text + "\n"+ acao5_controller.text + "\n"+ acao6_controller.text + "\n"+ acao7_controller.text
                                                + "\n"+ acao8_controller.text + "\n"+ acao9_controller.text + "\n"+ acao10_controller.text;
                                            questaceita.questData.concluida=true;
                                            Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("questsConcluidas").add(questaceita.toMap(user.firebaseUser.uid)).then((doc){
                                              questaceita.idQuestsAceitas = doc.documentID;
                                            });
                                            //Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("questsAceitas").document(questId).delete();

                                            QuestAcceptModel.of(context).removeQuest(questaceita);
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context) => HomeUser()));

                                           /* Alert(
                                              context: context,
                                              title: "Missão Finalizada!",
                                              desc: "Parabéns guerreiro. Seu prêmio será lançado em breve à você.",
                                              buttons: [
                                                DialogButton(
                                                  child: Text(
                                                    "Não",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontFamily: 'Helvetica'),
                                                  ),
                                                  onPressed: () => Navigator.pop(context),
                                                  color: Colors.indigo[400],
                                                ),
                                              ],
                                            ).show();*/


                                          },
                                          color: Colors.indigo[400],
                                        ),
                                        DialogButton(
                                          child: Text(
                                            "Não",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontFamily: 'Helvetica'),
                                          ),
                                          onPressed: () => Navigator.pop(context),
                                          color: Colors.indigo[400],
                                        ),
                                      ],
                                    ).show();
                                  } else {
                                    Firestore.instance.collection("quests")
                                        .document(questId)
                                        .updateData({
                                      "status_workflow": statusWorkflow + 1
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        );
                      }
                    case 1:
                      {
                        int qtdProcessos = 8;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Status da Missão: ", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Helvetica',
                                fontSize: 12
                            ),),
                            SizedBox(height: 15.0,),
                            Text(
                              "Ações Tomadas em cada processo (preencha esse campo com ações realizadas por você): ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Helvetica',
                                  fontSize: 12
                              ),),

                            Column(
                              children: <Widget>[
                                TextField(
                                  controller: cabo1_controller,
                                  decoration: InputDecoration(labelText: "1"),
                                  cursorColor: Colors.indigo,
                                ),
                                TextField(
                                  controller: cabo2_controller,
                                  decoration: InputDecoration(labelText: "2"),
                                  cursorColor: Colors.indigo,
                                ),
                                TextField(
                                  controller: cabo3_controller,
                                  decoration: InputDecoration(labelText: "3"),
                                  cursorColor: Colors.indigo,
                                ),
                                TextField(
                                  controller: cabo4_controller,
                                  decoration: InputDecoration(labelText: "4"),
                                  cursorColor: Colors.indigo,
                                ),
                                TextField(
                                  controller: cabo5_controller,
                                  decoration: InputDecoration(labelText: "5"),
                                  cursorColor: Colors.indigo,
                                ),
                                TextField(
                                  controller: cabo6_controller,
                                  decoration: InputDecoration(labelText: "6"),
                                  cursorColor: Colors.indigo,
                                ),
                                TextField(
                                  controller: cabo7_controller,
                                  decoration: InputDecoration(labelText: "7"),
                                  cursorColor: Colors.indigo,
                                ),
                                TextField(
                                  controller: cabo8_controller,
                                  decoration: InputDecoration(labelText: "8"),
                                  cursorColor: Colors.indigo,
                                ),
                              ],
                            ),


                            Text(
                              "Workflow resumo da Missão (olhe o workflow geral no botão \"Workflow\": ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Helvetica',
                                  fontSize: 12
                              ),),

                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: <Widget>[
                                _buildCircle("1", "Cliente solicita\nserviço",
                                    statusWorkflow, 1),
                                //Linha entre ícones
                                Container(
                                  height: 1.0,
                                  width: 40.0,
                                  color: Colors.grey[500],
                                ),
                                _buildCircle(
                                    "2", "Solicite info.\npara o chamado",
                                    statusWorkflow, 2),
                                Container(
                                  height: 1.0,
                                  width: 40.0,
                                  color: Colors.grey[500],
                                ),
                                _buildCircle(
                                    "3", "Verifique\nestoque", statusWorkflow,
                                    3),
                                Container(
                                  height: 1.0,
                                  width: 40.0,
                                  color: Colors.grey[500],
                                ),
                                _buildCircle(
                                    "4", "Crie chamado", statusWorkflow, 4),
                                Container(
                                  height: 1.0,
                                  width: 40.0,
                                  color: Colors.grey[500],
                                ),
                                _buildCircle(
                                    "5", "Faça cabo\nno padrão", statusWorkflow,
                                    5),
                                Container(
                                  height: 1.0,
                                  width: 40.0,
                                  color: Colors.grey[500],
                                ),
                                _buildCircle(
                                    "6", "Dirija-se\nao local", statusWorkflow,
                                    6),
                                Container(
                                  height: 1.0,
                                  width: 40.0,
                                  color: Colors.grey[500],
                                ),
                                _buildCircle(
                                    "7", "Troque o\ncabo", statusWorkflow, 7),
                                Container(
                                  height: 1.0,
                                  width: 40.0,
                                  color: Colors.grey[500],
                                ),
                                _buildCircle(
                                    "8", "Finalize o \nchamado", statusWorkflow,
                                    8),
                              ],
                            ),


                            SizedBox(height: 20,),

                            InkWell(
                              child: BotaoCircular1(
                                fundo: Colors.grey,
                                texto: Text("Retornar Processo",
                                  style: TextStyle(
                                      color: Colors.indigo),
                                ),
                                corTexto: Colors.white,
                                apertar: (){
                                  statusWorkflow == 1 ?
                                  Firestore.instance.collection("quests").document(questId).updateData({
                                    "status_workflow": 1
                                  })
                                      : Firestore.instance.collection("quests").document(questId).updateData({
                                    "status_workflow": statusWorkflow-1
                                  });
                                },
                              ),
                            ),

                            InkWell(
                              child: BotaoCircular1(
                                fundo: Colors.indigoAccent,
                                texto: Text("Concluir Processo",
                                  style: TextStyle(
                                      color: Colors.white),
                                ),
                                corTexto: Colors.white,
                                apertar: () {
                                  if(statusWorkflow == qtdProcessos) {
                                    Alert(
                                      context: context,
                                      title: "Finalizar Missão?",
                                      desc: "Se a atividade já foi concluída, "
                                          "aperte em \"Sim\" para que você receba o seu prêmio, caso contrário, aperte em \"Não\".",
                                      type: AlertType.warning,
                                      buttons: [
                                        DialogButton(
                                          child: Text(
                                            "Sim",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontFamily: 'Helvetica'),
                                          ),
                                          onPressed: (){
                                            Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("questsAceitas").document(questaceita.idQuestsAceitas).updateData({
                                              "concluida": true,
                                              "acoes_tomadas" : "\n"+ cabo1_controller.text +"\n"+ cabo2_controller.text + "\n"+ cabo3_controller.text
                                                  + "\n"+ cabo4_controller.text + "\n"+ cabo5_controller.text + "\n"+ cabo6_controller.text + "\n"+ cabo7_controller.text
                                                  + "\n"+ cabo8_controller.text ,
                                            });
                                            user.userData["xp"] = user.userData["xp"] + premio;
                                            Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).updateData({
                                              "xp": user.userData["xp"] + premio,
                                            });
                                            Firestore.instance.collection("quests").document(questId).updateData({
                                              "concluida": true,
                                              "acoes_tomadas" : "\n"+ cabo1_controller.text +"\n"+ cabo2_controller.text + "\n"+ cabo3_controller.text
                                                  + "\n"+ cabo4_controller.text + "\n"+ cabo5_controller.text + "\n"+ cabo6_controller.text + "\n"+ cabo7_controller.text
                                                  + "\n"+ cabo8_controller.text ,
                                            });
                                            questaceita.concluida=true;
                                            questaceita.acoesTomadas = "\n"+ cabo1_controller.text +"\n"+ cabo2_controller.text + "\n"+ cabo3_controller.text
                                                + "\n"+ cabo4_controller.text + "\n"+ cabo5_controller.text + "\n"+ cabo6_controller.text + "\n"+ cabo7_controller.text
                                                + "\n"+ cabo8_controller.text;
                                            questaceita.questData.concluida=true;
                                            Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("questsConcluidas").add(questaceita.toMap(user.firebaseUser.uid)).then((doc){
                                              questaceita.idQuestsAceitas = doc.documentID;
                                            });
                                            //Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("questsAceitas").document(questId).delete();

                                            QuestAcceptModel.of(context).removeQuest(questaceita);
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context) => HomeUser()));

                                            /*Alert(
                                              context: context,
                                              title: "Missão Finalizada!",
                                              desc: "Parabéns guerreiro. Seu prêmio será lançado em breve à você.",
                                              buttons: [
                                                DialogButton(
                                                  child: Text(
                                                    "Não",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontFamily: 'Helvetica'),
                                                  ),
                                                  onPressed: () => Navigator.pop(context),
                                                  color: Colors.indigo[400],
                                                ),
                                              ],
                                            ).show();*/


                                          },
                                          color: Colors.indigo[400],
                                        ),
                                        DialogButton(
                                          child: Text(
                                            "Não",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontFamily: 'Helvetica'),
                                          ),
                                          onPressed: () => Navigator.pop(context),
                                          color: Colors.indigo[400],
                                        ),
                                      ],
                                    ).show();
                                  } else {
                                    Firestore.instance.collection("quests")
                                        .document(questId)
                                        .updateData({
                                      "status_workflow": statusWorkflow + 1
                                    });
                                  };
                                },
                              ),
                            ),

                          ],
                        );
                      }
                    case 2:
                      {
                        int qtdProcessos = 4;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Status da Missão: ", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Helvetica',
                                fontSize: 12
                            ),),
                            SizedBox(height: 15,),
                            Text(
                              "Ações Tomadas em cada processo (preencha esse campo com ações realizadas por você): ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Helvetica',
                                  fontSize: 12
                              ),),

                            Column(
                              children: <Widget>[
                                TextField(
                                  controller: suprimento1_controller,
                                  decoration: InputDecoration(labelText: "1"),
                                  cursorColor: Colors.indigo,
                                ),
                                TextField(
                                  controller: suprimento2_controller,
                                  decoration: InputDecoration(labelText: "2"),
                                  cursorColor: Colors.indigo,
                                ),
                                TextField(
                                  controller: suprimento3_controller,
                                  decoration: InputDecoration(labelText: "3"),
                                  cursorColor: Colors.indigo,
                                ),
                                TextField(
                                  controller: suprimento4_controller,
                                  decoration: InputDecoration(labelText: "4"),
                                  cursorColor: Colors.indigo,
                                ),
                              ],
                            ),


                            Text(
                              "Workflow resumo da Missão (olhe o workflow geral no botão \"Workflow\": ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Helvetica',
                                  fontSize: 12
                              ),),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: <Widget>[
                                _buildCircle(
                                    "1", "Entre em contato\ncom o fornecedor",
                                    statusWorkflow, 1),
                                Container(
                                  height: 1.0,
                                  width: 40.0,
                                  color: Colors.grey[500],
                                ),
                                _buildCircle("2",
                                    "Faça o pedido\nno sistema do\nfornecedor",
                                    statusWorkflow, 2),
                                Container(
                                  height: 1.0,
                                  width: 40.0,
                                  color: Colors.grey[500],
                                ),
                                _buildCircle(
                                    "3", "Aguarde o suprimento\nchegar",
                                    statusWorkflow, 3),
                                Container(
                                  height: 1.0,
                                  width: 40.0,
                                  color: Colors.grey[500],
                                ),
                                _buildCircle(
                                    "4", "Alimente o estoque", statusWorkflow,
                                    4),

                              ],

                            ),


                            SizedBox(height: 20,),

                            InkWell(
                              child: BotaoCircular1(
                                fundo: Colors.grey,
                                texto: Text("Retornar Processo",
                                  style: TextStyle(
                                      color: Colors.indigo),
                                ),
                                corTexto: Colors.white,
                                apertar: (){
                                  statusWorkflow == 1 ?
                                  Firestore.instance.collection("quests").document(questId).updateData({
                                    "status_workflow": 1
                                  })
                                      : Firestore.instance.collection("quests").document(questId).updateData({
                                    "status_workflow": statusWorkflow-1
                                  });
                                },
                              ),
                            ),

                            InkWell(
                              child: BotaoCircular1(
                                fundo: Colors.indigoAccent,
                                texto: Text("Concluir Processo",
                                  style: TextStyle(
                                      color: Colors.white),
                                ),
                                corTexto: Colors.white,
                                apertar: () {
                                  if(statusWorkflow == qtdProcessos) {
                                    Alert(
                                      context: context,
                                      title: "Finalizar Missão?",
                                      desc: "Se a atividade já foi concluída, "
                                          "aperte em \"Sim\" para que você receba o seu prêmio, caso contrário, aperte em \"Não\".",
                                      type: AlertType.warning,
                                      buttons: [
                                        DialogButton(
                                          child: Text(
                                            "Sim",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontFamily: 'Helvetica'),
                                          ),
                                          onPressed: (){
                                            Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("questsAceitas").document(questaceita.idQuestsAceitas).updateData({
                                              "concluida": true,
                                              "acoes_tomadas" : "\n"+ suprimento1_controller.text +"\n"+ suprimento2_controller.text + "\n"+ suprimento3_controller.text
                                                  + "\n"+ suprimento4_controller.text,
                                            });
                                            user.userData["xp"] = user.userData["xp"] + premio;
                                            Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).updateData({
                                              "xp": user.userData["xp"] + premio,
                                            });
                                            Firestore.instance.collection("quests").document(questId).updateData({
                                              "concluida": true,
                                              "acoes_tomadas" : "\n"+ suprimento1_controller.text +"\n"+ suprimento2_controller.text + "\n"+ suprimento3_controller.text
                                                  + "\n"+ suprimento4_controller.text,
                                            });
                                            questaceita.concluida=true;
                                            questaceita.acoesTomadas = "\n"+ suprimento1_controller.text +"\n"+ suprimento2_controller.text + "\n"+ suprimento3_controller.text
                                                + "\n"+ suprimento4_controller.text;
                                            questaceita.questData.concluida=true;
                                            Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("questsConcluidas").add(questaceita.toMap(user.firebaseUser.uid)).then((doc){
                                              questaceita.idQuestsAceitas = doc.documentID;
                                            });
                                            //Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("questsAceitas").document(questId).delete();

                                            QuestAcceptModel.of(context).removeQuest(questaceita);
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context) => HomeUser()));

                                           /* Alert(
                                              context: context,
                                              title: "Missão Finalizada!",
                                              desc: "Parabéns guerreiro. Seu prêmio será lançado em breve à você.",
                                              buttons: [
                                                DialogButton(
                                                  child: Text(
                                                    "Não",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontFamily: 'Helvetica'),
                                                  ),
                                                  onPressed: () => Navigator.pop(context),
                                                  color: Colors.indigo[400],
                                                ),
                                              ],
                                            ).show();*/


                                          },
                                          color: Colors.indigo[400],
                                        ),
                                        DialogButton(
                                          child: Text(
                                            "Não",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontFamily: 'Helvetica'),
                                          ),
                                          onPressed: () => Navigator.pop(context),
                                          color: Colors.indigo[400],
                                        ),
                                      ],
                                    ).show();
                                  } else {
                                    Firestore.instance.collection("quests")
                                        .document(questId)
                                        .updateData({
                                      "status_workflow": statusWorkflow + 1
                                    });
                                  };
                                },
                              ),
                            ),

                          ],
                        );
                      }
                    case 3:
                      {
                        int qtdProcessos = 8;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Status da Missão: ", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Helvetica',
                                fontSize: 12
                            ),),
                            SizedBox(height: 4.0,),
                            SizedBox(height: 15,),

                            Text(
                              "Ações Tomadas em cada processo (preencha esse campo com ações realizadas por você): ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Helvetica',
                                  fontSize: 12
                              ),),

                            Column(
                              children: <Widget>[
                                TextField(
                                  controller: concerto1_controller,
                                  decoration: InputDecoration(labelText: "1"),
                                  cursorColor: Colors.indigo,
                                ),
                                TextField(
                                  controller: concerto2_controller,
                                  decoration: InputDecoration(labelText: "2"),
                                  cursorColor: Colors.indigo,
                                ),
                                TextField(
                                  controller: concerto3_controller,
                                  decoration: InputDecoration(labelText: "3"),
                                  cursorColor: Colors.indigo,
                                ),
                                TextField(
                                  controller: concerto4_controller,
                                  decoration: InputDecoration(labelText: "4"),
                                  cursorColor: Colors.indigo,
                                ),
                                TextField(
                                  controller: concerto5_controller,
                                  decoration: InputDecoration(labelText: "5"),
                                  cursorColor: Colors.indigo,
                                ),
                                TextField(
                                  controller: concerto6_controller,
                                  decoration: InputDecoration(labelText: "6"),
                                  cursorColor: Colors.indigo,
                                ),
                                TextField(
                                  controller: concerto7_controller,
                                  decoration: InputDecoration(labelText: "7"),
                                  cursorColor: Colors.indigo,
                                ),
                                TextField(
                                  controller: concerto8_controller,
                                  decoration: InputDecoration(labelText: "8"),
                                  cursorColor: Colors.indigo,
                                ),
                              ],
                            ),

                            Text(
                              "Workflow resumo da Missão (olhe o workflow geral no botão \"Workflow\": ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Helvetica',
                                  fontSize: 12
                              ),),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: <Widget>[
                                _buildCircle("1", "Receba o\nequipamento",
                                    statusWorkflow, 1),
                                Container(
                                  height: 1.0,
                                  width: 40.0,
                                  color: Colors.grey[500],
                                ),
                                _buildCircle(
                                    "2", "Solicite info.\npara o chamado",
                                    statusWorkflow, 2),
                                Container(
                                  height: 1.0,
                                  width: 40.0,
                                  color: Colors.grey[500],
                                ),
                                _buildCircle(
                                    "3", "Abra o\nchamado", statusWorkflow,
                                    3),
                                Container(
                                  height: 1.0,
                                  width: 40.0,
                                  color: Colors.grey[500],
                                ),
                                _buildCircle(
                                    "4", "Avalie o\nequipameento", statusWorkflow, 4),
                                Container(
                                  height: 1.0,
                                  width: 40.0,
                                  color: Colors.grey[500],
                                ),
                                _buildCircle(
                                    "5", "Realize o\nconserto", statusWorkflow,
                                    5),
                                Container(
                                  height: 1.0,
                                  width: 40.0,
                                  color: Colors.grey[500],
                                ),
                                _buildCircle(
                                    "6", "Técnico testa\nequipamento\napós conserto",
                                    statusWorkflow, 6),
                                Container(
                                  height: 1.0,
                                  width: 40.0,
                                  color: Colors.grey[500],
                                ),
                                _buildCircle("7", "Devolva/Instale\no equipamento\nconsertado",
                                    statusWorkflow, 7),
                                Container(
                                  height: 1.0,
                                  width: 40.0,
                                  color: Colors.grey[500],
                                ),
                                _buildCircle("8", "Finalize o \nchamado",
                                    statusWorkflow, 8),
                              ],
                            ),


                            SizedBox(height: 20,),

                            InkWell(
                              child: BotaoCircular1(
                                fundo: Colors.grey,
                                texto: Text("Retornar Processo",
                                  style: TextStyle(
                                      color: Colors.indigo),
                                ),
                                corTexto: Colors.white,
                                apertar: (){
                                  statusWorkflow == 1 ?
                                  Firestore.instance.collection("quests").document(questId).updateData({
                                    "status_workflow": 1
                                  })
                                      : Firestore.instance.collection("quests").document(questId).updateData({
                                    "status_workflow": statusWorkflow-1
                                  });
                                },
                              ),
                            ),

                            InkWell(
                              child: BotaoCircular1(
                                fundo: Colors.indigoAccent,
                                texto: Text("Concluir Processo",
                                  style: TextStyle(
                                      color: Colors.white),
                                ),
                                corTexto: Colors.white,
                                apertar: () {
                                  if(statusWorkflow == qtdProcessos) {
                                    Alert(
                                      context: context,
                                      title: "Finalizar Missão?",
                                      desc: "Se a atividade já foi concluída, "
                                          "aperte em \"Sim\" para que você receba o seu prêmio, caso contrário, aperte em \"Não\".",
                                      type: AlertType.warning,
                                      buttons: [
                                        DialogButton(
                                          child: Text(
                                            "Sim",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontFamily: 'Helvetica'),
                                          ),
                                          onPressed: (){
                                            Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("questsAceitas").document(questaceita.idQuestsAceitas).updateData({
                                              "concluida": true,
                                              "acoes_tomadas" : "\n"+ concerto1_controller.text +"\n"+ concerto2_controller.text + "\n"+ concerto3_controller.text
                                                  + "\n"+ concerto4_controller.text+ "\n"+ concerto5_controller.text+ "\n"+ concerto6_controller.text+ "\n"+ concerto7_controller.text
                                                  + "\n"+ concerto8_controller.text,
                                            });
                                            user.userData["xp"] = user.userData["xp"] + premio;
                                            Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).updateData({
                                              "xp": user.userData["xp"] + premio,
                                            });
                                            Firestore.instance.collection("quests").document(questId).updateData({
                                              "concluida": true,
                                              "acoes_tomadas" : "\n"+ suprimento1_controller.text +"\n"+ suprimento2_controller.text + "\n"+ suprimento3_controller.text
                                                  + "\n"+ suprimento4_controller.text,
                                            });
                                            questaceita.concluida=true;
                                            questaceita.acoesTomadas = "\n"+ concerto1_controller.text +"\n"+ concerto2_controller.text + "\n"+ concerto3_controller.text
                                                + "\n"+ concerto4_controller.text+ "\n"+ concerto5_controller.text+ "\n"+ concerto6_controller.text+ "\n"+ concerto7_controller.text
                                                + "\n"+ concerto8_controller.text;
                                            questaceita.questData.concluida=true;
                                            Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("questsConcluidas").add(questaceita.toMap(user.firebaseUser.uid)).then((doc){
                                              questaceita.idQuestsAceitas = doc.documentID;
                                            });
                                            //Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("questsAceitas").document(questId).delete();

                                            QuestAcceptModel.of(context).removeQuest(questaceita);
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context) => HomeUser()));

                                            /*Alert(
                                              context: context,
                                              title: "Missão Finalizada!",
                                              desc: "Parabéns guerreiro. Seu prêmio será lançado em breve à você.",
                                              buttons: [
                                                DialogButton(
                                                  child: Text(
                                                    "Não",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontFamily: 'Helvetica'),
                                                  ),
                                                  onPressed: () => Navigator.pop(context),
                                                  color: Colors.indigo[400],
                                                ),
                                              ],
                                            ).show();*/


                                          },
                                          color: Colors.indigo[400],
                                        ),
                                        DialogButton(
                                          child: Text(
                                            "Não",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontFamily: 'Helvetica'),
                                          ),
                                          onPressed: () => Navigator.pop(context),
                                          color: Colors.indigo[400],
                                        ),
                                      ],
                                    ).show();
                                  } else {
                                    Firestore.instance.collection("quests")
                                        .document(questId)
                                        .updateData({
                                      "status_workflow": statusWorkflow + 1
                                    });
                                  };
                                },
                              ),
                            ),
                          ],
                        );
                      }
                  }
                }
            ),
          ),
        );
      },
    );

  }

  // mostrando detalhes da quest por uma função. Não vou usar porque os dados já estão no card
//  String _buildQuestsText (DocumentSnapshot snapshot){
//    String text = "Descrição:\n";
//    //São as listas do Firbase
//    for(LinkedHashMap q in snapshot.data["questDados"]){
//      text += "${q["xp"]}";
//    }
//  }

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

//ORDER TILE
/*
class WorkFlowStatus extends StatelessWidget {

  //Esse questId tem que ser o idQuest disponível em questsAceitas
  final String questId;
  final User user;
  final QuestsAccepts questaceita;
  WorkFlowStatus(this.questId, this.user, this.questaceita);

  TextEditingController acao1_controller = TextEditingController();
  TextEditingController acao2_controller = TextEditingController();
  TextEditingController acao3_controller = TextEditingController();
  TextEditingController acao4_controller = TextEditingController();
  TextEditingController acao5_controller = TextEditingController();
  TextEditingController acao6_controller = TextEditingController();
  TextEditingController acao7_controller = TextEditingController();
  TextEditingController acao8_controller = TextEditingController();
  TextEditingController acao9_controller = TextEditingController();
  TextEditingController acao10_controller = TextEditingController();

  TextEditingController cabo1_controller = TextEditingController();
  TextEditingController cabo2_controller = TextEditingController();
  TextEditingController cabo3_controller = TextEditingController();
  TextEditingController cabo4_controller = TextEditingController();
  TextEditingController cabo5_controller = TextEditingController();
  TextEditingController cabo6_controller = TextEditingController();
  TextEditingController cabo7_controller = TextEditingController();
  TextEditingController cabo8_controller = TextEditingController();

  TextEditingController suprimento1_controller = TextEditingController();
  TextEditingController suprimento2_controller = TextEditingController();
  TextEditingController suprimento3_controller = TextEditingController();
  TextEditingController suprimento4_controller = TextEditingController();

  TextEditingController concerto1_controller = TextEditingController();
  TextEditingController concerto2_controller = TextEditingController();
  TextEditingController concerto3_controller = TextEditingController();
  TextEditingController concerto4_controller = TextEditingController();
  TextEditingController concerto5_controller = TextEditingController();
  TextEditingController concerto6_controller = TextEditingController();
  TextEditingController concerto7_controller = TextEditingController();
  TextEditingController concerto8_controller = TextEditingController();

  GlobalKey chave = GlobalKey();
  
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<User>(
     builder: (context, child, model){
       FinishedModel fm = FinishedModel(user);
       return Card(
         key: chave,
         margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
         child: Padding(
           padding: EdgeInsets.all(8.0),
           child: StreamBuilder<DocumentSnapshot>(
             //Ao criar a quest, preciso inserir um campo chamado status. Talvez eu precise usar as questsAceitas
               stream: Firestore.instance.collection("quests")
                   .document(questId).snapshots(),//Firestore.instance.collection("quests").document(questId).snapshots(),
               // ignore: missing_return
               builder: (context, snapshot){
                 int status = snapshot.data["status"];
                 int idWorkflow = snapshot.data["workflow"];
                 int statusWorkflow = snapshot.data["status_workflow"];
                 int premio = snapshot.data["xp"];
                 if (!snapshot.hasData) {
                   Center(
                     child: CircularProgressIndicator( backgroundColor: Colors.indigo,),
                   );
                 }
                 switch (idWorkflow){
                   case 0:
                     {
                       int qtdProcessos = 10;
                       return Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                           Text("Status da Missão: ", style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontFamily: 'Helvetica',
                               fontSize: 12
                           ),),
                           SizedBox(height: 15,),
                           Text(
                             "Ações Tomadas em cada processo (preencha esse campo com ações realizadas por você): ",
                             style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 fontFamily: 'Helvetica',
                                 fontSize: 12
                             ),),

                           Column(
                             children: <Widget>[
                               TextField(
                                 controller: acao1_controller,
                                 decoration: InputDecoration(labelText: "1"),
                                 cursorColor: Colors.indigo,
                               ),
                               TextField(
                                 controller: acao2_controller,
                                 decoration: InputDecoration(labelText: "2"),
                                 cursorColor: Colors.indigo,
                               ),
                               TextField(
                                 controller: acao3_controller,
                                 decoration: InputDecoration(labelText: "3"),
                                 cursorColor: Colors.indigo,
                               ),
                               TextField(
                                 controller: acao4_controller,
                                 decoration: InputDecoration(labelText: "4"),
                                 cursorColor: Colors.indigo,
                               ),
                               TextField(
                                 controller: acao5_controller,
                                 decoration: InputDecoration(labelText: "5"),
                                 cursorColor: Colors.indigo,
                               ),
                               TextField(
                                 controller: acao6_controller,
                                 decoration: InputDecoration(labelText: "6"),
                                 cursorColor: Colors.indigo,
                               ),
                               TextField(
                                 controller: acao7_controller,
                                 decoration: InputDecoration(labelText: "7"),
                                 cursorColor: Colors.indigo,
                               ),
                               TextField(
                                 controller: acao8_controller,
                                 decoration: InputDecoration(labelText: "8"),
                                 cursorColor: Colors.indigo,
                               ),
                               TextField(
                                 controller: acao9_controller,
                                 decoration: InputDecoration(labelText: "9"),
                                 cursorColor: Colors.indigo,
                               ),
                               TextField(
                                 controller: acao10_controller,
                                 decoration: InputDecoration(labelText: "10"),
                                 cursorColor: Colors.indigo,
                               ),
                             ],
                           ),

                           SizedBox(height: 15,),

                           Text(
                             "Workflow resumo da Missão (olhe o workflow geral no botão \"Workflow\": ",
                             style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 fontFamily: 'Helvetica',
                                 fontSize: 12
                             ),),

                           Wrap(
                             crossAxisAlignment: WrapCrossAlignment.center,
                             children: <Widget>[
                               _buildCircle("1", "Cliente solicita\nvisita",
                                   statusWorkflow, 1),
                               Container(
                                 height: 1.0,
                                 width: 40.0,
                                 color: Colors.grey[500],
                               ),
                               _buildCircle(
                                   "2", "Solicite info.\npara o chamado",
                                   statusWorkflow, 2),
                               Container(
                                 height: 1.0,
                                 width: 40.0,
                                 color: Colors.grey[500],
                               ),
                               _buildCircle(
                                   "3", "Verifique\nestoque", statusWorkflow,
                                   3),
                               Container(
                                 height: 1.0,
                                 width: 40.0,
                                 color: Colors.grey[500],
                               ),
                               _buildCircle(
                                   "4", "Abra\nchamado", statusWorkflow, 4),
                               Container(
                                 height: 1.0,
                                 width: 40.0,
                                 color: Colors.grey[500],
                               ),
                               _buildCircle(
                                   "5", "Dirija-se\nao local", statusWorkflow,
                                   5),
                               Container(
                                 height: 1.0,
                                 width: 40.0,
                                 color: Colors.grey[500],
                               ),
                               _buildCircle(
                                   "6", "Técnico testa\ncomp. defeituoso",
                                   statusWorkflow, 6),
                               Container(
                                 height: 1.0,
                                 width: 40.0,
                                 color: Colors.grey[500],
                               ),
                               _buildCircle("7", "Recolha o\ncomponente",
                                   statusWorkflow, 7),
                               Container(
                                 height: 1.0,
                                 width: 40.0,
                                 color: Colors.grey[500],
                               ),
                               _buildCircle("8", "Troque o \ncomponente",
                                   statusWorkflow, 8),
                               Container(
                                 height: 1.0,
                                 width: 40.0,
                                 color: Colors.grey[500],
                               ),
                               _buildCircle(
                                   "9", "Realize\num teste", statusWorkflow,
                                   9),
                               Container(
                                 height: 1.0,
                                 width: 40.0,
                                 color: Colors.grey[500],
                               ),
                               _buildCircle(
                                   "10", "Finalize\nchamado", statusWorkflow,
                                   10),
                             ],
                           ),

                           SizedBox(height: 20,),

                           InkWell(
                             child: BotaoCircular1(
                               fundo: Colors.grey,
                               texto: Text("Retornar Processo",
                                 style: TextStyle(
                                     color: Colors.indigo),
                               ),
                               corTexto: Colors.white,
                               apertar: (){
                                 statusWorkflow == 1 ?
                                  Firestore.instance.collection("quests").document(questId).updateData({
                                   "status_workflow": 1
                                 })
                                     : Firestore.instance.collection("quests").document(questId).updateData({
                                   "status_workflow": statusWorkflow-1
                                 });
                               },
                             ),
                           ),

                           InkWell(
                             child: BotaoCircular1(
                               fundo: Colors.indigoAccent,
                               texto: Text("Concluir Processo",
                                 style: TextStyle(
                                     color: Colors.white),
                               ),
                               corTexto: Colors.white,
                               apertar: () {
                                 if(statusWorkflow == qtdProcessos) {
                                   Alert(
                                     context: context,
                                     title: "Finalizar Missão?",
                                     desc: "Se a atividade já foi concluída, "
                                         "aperte em \"Sim\" para que você receba o seu prêmio, caso contrário, aperte em \"Não\".",
                                     type: AlertType.warning,
                                     buttons: [
                                       DialogButton(
                                         child: Text(
                                           "Sim",
                                           style: TextStyle(
                                               color: Colors.white,
                                               fontSize: 20,
                                               fontFamily: 'Helvetica'),
                                         ),
                                         onPressed: (){
                                           Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("questsAceitas").document(questaceita.idQuestsAceitas).updateData({
                                             "concluida": true,
                                             "acoes_tomadas" : "\n"+ acao1_controller.text +"\n"+ acao2_controller.text + "\n"+ acao3_controller.text
                                                 + "\n"+ acao4_controller.text + "\n"+ acao5_controller.text + "\n"+ acao6_controller.text + "\n"+ acao7_controller.text
                                                 + "\n"+ acao8_controller.text + "\n"+ acao9_controller.text + "\n"+ acao10_controller.text,
                                           });
                                           user.userData["xp"] = user.userData["xp"] + premio;
                                           Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).updateData({
                                             "xp": user.userData["xp"] + premio,
                                           });
                                           Firestore.instance.collection("quests").document(questId).updateData({
                                             "concluida": true,
                                             "acoes_tomadas" : "\n"+ acao1_controller.text +"\n"+ acao2_controller.text + "\n"+ acao3_controller.text
                                                              + "\n"+ acao4_controller.text + "\n"+ acao5_controller.text + "\n"+ acao6_controller.text + "\n"+ acao7_controller.text
                                                              + "\n"+ acao8_controller.text + "\n"+ acao9_controller.text + "\n"+ acao10_controller.text,
                                           });
                                           questaceita.concluida=true;
                                           questaceita.acoesTomadas = "\n"+ acao1_controller.text +"\n"+ acao2_controller.text + "\n"+ acao3_controller.text
                                               + "\n"+ acao4_controller.text + "\n"+ acao5_controller.text + "\n"+ acao6_controller.text + "\n"+ acao7_controller.text
                                               + "\n"+ acao8_controller.text + "\n"+ acao9_controller.text + "\n"+ acao10_controller.text;
                                           questaceita.questData.concluida=true;
                                           Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("questsConcluidas").add(questaceita.toMap(user.firebaseUser.uid)).then((doc){
                                             questaceita.idQuestsAceitas = doc.documentID;
                                           });
                                          //Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("questsAceitas").document(questId).delete();

                                           QuestAcceptModel.of(context).removeQuest(questaceita);
                                           Navigator.push(context, MaterialPageRoute(
                                               builder: (context) => HomeUser()));

                                           Alert(
                                             context: context,
                                             title: "Missão Finalizada!",
                                             desc: "Parabéns guerreiro. Seu prêmio será lançado em breve à você.",
                                             buttons: [
                                               DialogButton(
                                                 child: Text(
                                                   "Não",
                                                   style: TextStyle(
                                                       color: Colors.white,
                                                       fontSize: 20,
                                                       fontFamily: 'Helvetica'),
                                                 ),
                                                 onPressed: () => Navigator.pop(context),
                                                 color: Colors.indigo[400],
                                               ),
                                             ],
                                           ).show();


                                         },
                                         color: Colors.indigo[400],
                                       ),
                                       DialogButton(
                                         child: Text(
                                           "Não",
                                           style: TextStyle(
                                               color: Colors.white,
                                               fontSize: 20,
                                               fontFamily: 'Helvetica'),
                                         ),
                                         onPressed: () => Navigator.pop(context),
                                         color: Colors.indigo[400],
                                       ),
                                     ],
                                   ).show();
                                 } else {
                                    Firestore.instance.collection("quests")
                                       .document(questId)
                                       .updateData({
                                     "status_workflow": statusWorkflow + 1
                                   });
                                 }
                               },
                             ),
                           ),
                         ],
                       );
                     }
                   case 1:
                     {
                       int qtdProcessos = 8;
                       return Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                           Text("Status da Missão: ", style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontFamily: 'Helvetica',
                               fontSize: 12
                           ),),
                           SizedBox(height: 15.0,),
                           Text(
                             "Ações Tomadas em cada processo (preencha esse campo com ações realizadas por você): ",
                             style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 fontFamily: 'Helvetica',
                                 fontSize: 12
                             ),),

                           Column(
                             children: <Widget>[
                               TextField(
                                 controller: cabo1_controller,
                                 decoration: InputDecoration(labelText: "1"),
                                 cursorColor: Colors.indigo,
                               ),
                               TextField(
                                 controller: cabo2_controller,
                                 decoration: InputDecoration(labelText: "2"),
                                 cursorColor: Colors.indigo,
                               ),
                               TextField(
                                 controller: cabo3_controller,
                                 decoration: InputDecoration(labelText: "3"),
                                 cursorColor: Colors.indigo,
                               ),
                               TextField(
                                 controller: cabo4_controller,
                                 decoration: InputDecoration(labelText: "4"),
                                 cursorColor: Colors.indigo,
                               ),
                               TextField(
                                 controller: cabo5_controller,
                                 decoration: InputDecoration(labelText: "5"),
                                 cursorColor: Colors.indigo,
                               ),
                               TextField(
                                 controller: cabo6_controller,
                                 decoration: InputDecoration(labelText: "6"),
                                 cursorColor: Colors.indigo,
                               ),
                               TextField(
                                 controller: cabo7_controller,
                                 decoration: InputDecoration(labelText: "7"),
                                 cursorColor: Colors.indigo,
                               ),
                               TextField(
                                 controller: cabo8_controller,
                                 decoration: InputDecoration(labelText: "8"),
                                 cursorColor: Colors.indigo,
                               ),
                             ],
                           ),


                           Text(
                             "Workflow resumo da Missão (olhe o workflow geral no botão \"Workflow\": ",
                             style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 fontFamily: 'Helvetica',
                                 fontSize: 12
                             ),),

                           Wrap(
                             crossAxisAlignment: WrapCrossAlignment.center,
                             children: <Widget>[
                               _buildCircle("1", "Cliente solicita\nserviço",
                                   statusWorkflow, 1),
                               Container(
                                 height: 1.0,
                                 width: 40.0,
                                 color: Colors.grey[500],
                               ),
                               _buildCircle(
                                   "2", "Solicite info.\npara o chamado",
                                   statusWorkflow, 2),
                               Container(
                                 height: 1.0,
                                 width: 40.0,
                                 color: Colors.grey[500],
                               ),
                               _buildCircle(
                                   "3", "Verifique\nestoque", statusWorkflow,
                                   3),
                               Container(
                                 height: 1.0,
                                 width: 40.0,
                                 color: Colors.grey[500],
                               ),
                               _buildCircle(
                                   "4", "Crie chamado", statusWorkflow, 4),
                               Container(
                                 height: 1.0,
                                 width: 40.0,
                                 color: Colors.grey[500],
                               ),
                               _buildCircle(
                                   "5", "Faça cabo\nno padrão", statusWorkflow,
                                   5),
                               Container(
                                 height: 1.0,
                                 width: 40.0,
                                 color: Colors.grey[500],
                               ),
                               _buildCircle(
                                   "6", "Dirija-se\nao local", statusWorkflow,
                                   6),
                               Container(
                                 height: 1.0,
                                 width: 40.0,
                                 color: Colors.grey[500],
                               ),
                               _buildCircle(
                                   "7", "Troque o\ncabo", statusWorkflow, 7),
                               Container(
                                 height: 1.0,
                                 width: 40.0,
                                 color: Colors.grey[500],
                               ),
                               _buildCircle(
                                   "8", "Finalize o \nchamado", statusWorkflow,
                                   8),
                             ],
                           ),


                           SizedBox(height: 20,),

                           InkWell(
                             child: BotaoCircular1(
                               fundo: Colors.grey,
                               texto: Text("Retornar Processo",
                                 style: TextStyle(
                                     color: Colors.indigo),
                               ),
                               corTexto: Colors.white,
                               apertar: (){
                                 statusWorkflow == 1 ?
                                 Firestore.instance.collection("quests").document(questId).updateData({
                                   "status_workflow": 1
                                 })
                                     : Firestore.instance.collection("quests").document(questId).updateData({
                                   "status_workflow": statusWorkflow-1
                                 });
                               },
                             ),
                           ),

                           InkWell(
                             child: BotaoCircular1(
                               fundo: Colors.indigoAccent,
                               texto: Text("Concluir Processo",
                                 style: TextStyle(
                                     color: Colors.white),
                               ),
                               corTexto: Colors.white,
                               apertar: () {
                                 if(statusWorkflow == qtdProcessos) {
                                   Alert(
                                     context: context,
                                     title: "Finalizar Missão?",
                                     desc: "Se a atividade já foi concluída, "
                                         "aperte em \"Sim\" para que você receba o seu prêmio, caso contrário, aperte em \"Não\".",
                                     type: AlertType.warning,
                                     buttons: [
                                       DialogButton(
                                         child: Text(
                                           "Sim",
                                           style: TextStyle(
                                               color: Colors.white,
                                               fontSize: 20,
                                               fontFamily: 'Helvetica'),
                                         ),
                                         onPressed: (){
                                           Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("questsAceitas").document(questaceita.idQuestsAceitas).updateData({
                                             "concluida": true,
                                             "acoes_tomadas" : "\n"+ cabo1_controller.text +"\n"+ cabo2_controller.text + "\n"+ cabo3_controller.text
                                                 + "\n"+ cabo4_controller.text + "\n"+ cabo5_controller.text + "\n"+ cabo6_controller.text + "\n"+ cabo7_controller.text
                                                 + "\n"+ cabo8_controller.text ,
                                           });
                                           user.userData["xp"] = user.userData["xp"] + premio;
                                           Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).updateData({
                                             "xp": user.userData["xp"] + premio,
                                           });
                                           Firestore.instance.collection("quests").document(questId).updateData({
                                             "concluida": true,
                                             "acoes_tomadas" : "\n"+ cabo1_controller.text +"\n"+ cabo2_controller.text + "\n"+ cabo3_controller.text
                                                 + "\n"+ cabo4_controller.text + "\n"+ cabo5_controller.text + "\n"+ cabo6_controller.text + "\n"+ cabo7_controller.text
                                                 + "\n"+ cabo8_controller.text ,
                                           });
                                           questaceita.concluida=true;
                                           questaceita.acoesTomadas = "\n"+ cabo1_controller.text +"\n"+ cabo2_controller.text + "\n"+ cabo3_controller.text
                                           + "\n"+ cabo4_controller.text + "\n"+ cabo5_controller.text + "\n"+ cabo6_controller.text + "\n"+ cabo7_controller.text
                                           + "\n"+ cabo8_controller.text;
                                           questaceita.questData.concluida=true;
                                           Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("questsConcluidas").add(questaceita.toMap(user.firebaseUser.uid)).then((doc){
                                             questaceita.idQuestsAceitas = doc.documentID;
                                           });
                                           //Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("questsAceitas").document(questId).delete();

                                           QuestAcceptModel.of(context).removeQuest(questaceita);
                                           Navigator.push(context, MaterialPageRoute(
                                               builder: (context) => HomeUser()));

                                           Alert(
                                             context: context,
                                             title: "Missão Finalizada!",
                                             desc: "Parabéns guerreiro. Seu prêmio será lançado em breve à você.",
                                             buttons: [
                                               DialogButton(
                                                 child: Text(
                                                   "Não",
                                                   style: TextStyle(
                                                       color: Colors.white,
                                                       fontSize: 20,
                                                       fontFamily: 'Helvetica'),
                                                 ),
                                                 onPressed: () => Navigator.pop(context),
                                                 color: Colors.indigo[400],
                                               ),
                                             ],
                                           ).show();


                                         },
                                         color: Colors.indigo[400],
                                       ),
                                       DialogButton(
                                         child: Text(
                                           "Não",
                                           style: TextStyle(
                                               color: Colors.white,
                                               fontSize: 20,
                                               fontFamily: 'Helvetica'),
                                         ),
                                         onPressed: () => Navigator.pop(context),
                                         color: Colors.indigo[400],
                                       ),
                                     ],
                                   ).show();
                                 } else {
                                   Firestore.instance.collection("quests")
                                       .document(questId)
                                       .updateData({
                                     "status_workflow": statusWorkflow + 1
                                   });
                                 };
                               },
                             ),
                           ),

                         ],
                       );
                     }
                   case 2:
                     {
                       int qtdProcessos = 4;
                       return Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                           Text("Status da Missão: ", style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontFamily: 'Helvetica',
                               fontSize: 12
                           ),),
                           SizedBox(height: 15,),
                           Text(
                             "Ações Tomadas em cada processo (preencha esse campo com ações realizadas por você): ",
                             style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 fontFamily: 'Helvetica',
                                 fontSize: 12
                             ),),

                           Column(
                             children: <Widget>[
                               TextField(
                                 controller: suprimento1_controller,
                                 decoration: InputDecoration(labelText: "1"),
                                 cursorColor: Colors.indigo,
                               ),
                               TextField(
                                 controller: suprimento2_controller,
                                 decoration: InputDecoration(labelText: "2"),
                                 cursorColor: Colors.indigo,
                               ),
                               TextField(
                                 controller: suprimento3_controller,
                                 decoration: InputDecoration(labelText: "3"),
                                 cursorColor: Colors.indigo,
                               ),
                               TextField(
                                 controller: suprimento4_controller,
                                 decoration: InputDecoration(labelText: "4"),
                                 cursorColor: Colors.indigo,
                               ),
                             ],
                           ),


                           Text(
                             "Workflow resumo da Missão (olhe o workflow geral no botão \"Workflow\": ",
                             style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 fontFamily: 'Helvetica',
                                 fontSize: 12
                             ),),
                           Wrap(
                             crossAxisAlignment: WrapCrossAlignment.center,
                             children: <Widget>[
                               _buildCircle(
                                   "1", "Entre em contato\ncom o fornecedor",
                                   statusWorkflow, 1),
                               Container(
                                 height: 1.0,
                                 width: 40.0,
                                 color: Colors.grey[500],
                               ),
                               _buildCircle("2",
                                   "Faça o pedido\nno sistema do\nfornecedor",
                                   statusWorkflow, 2),
                               Container(
                                 height: 1.0,
                                 width: 40.0,
                                 color: Colors.grey[500],
                               ),
                               _buildCircle(
                                   "3", "Aguarde o suprimento\nchegar",
                                   statusWorkflow, 3),
                               Container(
                                 height: 1.0,
                                 width: 40.0,
                                 color: Colors.grey[500],
                               ),
                               _buildCircle(
                                   "4", "Alimente o estoque", statusWorkflow,
                                   4),

                             ],

                           ),


                           SizedBox(height: 20,),

                           InkWell(
                             child: BotaoCircular1(
                               fundo: Colors.grey,
                               texto: Text("Retornar Processo",
                                 style: TextStyle(
                                     color: Colors.indigo),
                               ),
                               corTexto: Colors.white,
                               apertar: (){
                                 statusWorkflow == 1 ?
                                 Firestore.instance.collection("quests").document(questId).updateData({
                                   "status_workflow": 1
                                 })
                                     : Firestore.instance.collection("quests").document(questId).updateData({
                                   "status_workflow": statusWorkflow-1
                                 });
                               },
                             ),
                           ),

                           InkWell(
                             child: BotaoCircular1(
                               fundo: Colors.indigoAccent,
                               texto: Text("Concluir Processo",
                                 style: TextStyle(
                                     color: Colors.white),
                               ),
                               corTexto: Colors.white,
                               apertar: () {
                                 if(statusWorkflow == qtdProcessos) {
                                   Alert(
                                     context: context,
                                     title: "Finalizar Missão?",
                                     desc: "Se a atividade já foi concluída, "
                                         "aperte em \"Sim\" para que você receba o seu prêmio, caso contrário, aperte em \"Não\".",
                                     type: AlertType.warning,
                                     buttons: [
                                       DialogButton(
                                         child: Text(
                                           "Sim",
                                           style: TextStyle(
                                               color: Colors.white,
                                               fontSize: 20,
                                               fontFamily: 'Helvetica'),
                                         ),
                                         onPressed: (){
                                           Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("questsAceitas").document(questaceita.idQuestsAceitas).updateData({
                                             "concluida": true,
                                             "acoes_tomadas" : "\n"+ suprimento1_controller.text +"\n"+ suprimento2_controller.text + "\n"+ suprimento3_controller.text
                                                 + "\n"+ suprimento4_controller.text,
                                           });
                                           user.userData["xp"] = user.userData["xp"] + premio;
                                           Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).updateData({
                                             "xp": user.userData["xp"] + premio,
                                           });
                                           Firestore.instance.collection("quests").document(questId).updateData({
                                             "concluida": true,
                                             "acoes_tomadas" : "\n"+ suprimento1_controller.text +"\n"+ suprimento2_controller.text + "\n"+ suprimento3_controller.text
                                                 + "\n"+ suprimento4_controller.text,
                                           });
                                           questaceita.concluida=true;
                                           questaceita.acoesTomadas = "\n"+ suprimento1_controller.text +"\n"+ suprimento2_controller.text + "\n"+ suprimento3_controller.text
                                               + "\n"+ suprimento4_controller.text;
                                           questaceita.questData.concluida=true;
                                           Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("questsConcluidas").add(questaceita.toMap(user.firebaseUser.uid)).then((doc){
                                             questaceita.idQuestsAceitas = doc.documentID;
                                           });
                                           //Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("questsAceitas").document(questId).delete();

                                           QuestAcceptModel.of(context).removeQuest(questaceita);
                                           Navigator.push(context, MaterialPageRoute(
                                               builder: (context) => HomeUser()));

                                           Alert(
                                             context: context,
                                             title: "Missão Finalizada!",
                                             desc: "Parabéns guerreiro. Seu prêmio será lançado em breve à você.",
                                             buttons: [
                                               DialogButton(
                                                 child: Text(
                                                   "Não",
                                                   style: TextStyle(
                                                       color: Colors.white,
                                                       fontSize: 20,
                                                       fontFamily: 'Helvetica'),
                                                 ),
                                                 onPressed: () => Navigator.pop(context),
                                                 color: Colors.indigo[400],
                                               ),
                                             ],
                                           ).show();


                                         },
                                         color: Colors.indigo[400],
                                       ),
                                       DialogButton(
                                         child: Text(
                                           "Não",
                                           style: TextStyle(
                                               color: Colors.white,
                                               fontSize: 20,
                                               fontFamily: 'Helvetica'),
                                         ),
                                         onPressed: () => Navigator.pop(context),
                                         color: Colors.indigo[400],
                                       ),
                                     ],
                                   ).show();
                                 } else {
                                   Firestore.instance.collection("quests")
                                       .document(questId)
                                       .updateData({
                                     "status_workflow": statusWorkflow + 1
                                   });
                                 };
                               },
                             ),
                           ),

                         ],
                       );
                     }
                   case 3:
                     {
                       int qtdProcessos = 8;
                       return Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                           Text("Status da Missão: ", style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontFamily: 'Helvetica',
                               fontSize: 12
                           ),),
                           SizedBox(height: 4.0,),
                           SizedBox(height: 15,),

                           Text(
                             "Ações Tomadas em cada processo (preencha esse campo com ações realizadas por você): ",
                             style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 fontFamily: 'Helvetica',
                                 fontSize: 12
                             ),),

                           Column(
                             children: <Widget>[
                               TextField(
                                 controller: concerto1_controller,
                                 decoration: InputDecoration(labelText: "1"),
                                 cursorColor: Colors.indigo,
                               ),
                               TextField(
                                 controller: concerto2_controller,
                                 decoration: InputDecoration(labelText: "2"),
                                 cursorColor: Colors.indigo,
                               ),
                               TextField(
                                 controller: concerto3_controller,
                                 decoration: InputDecoration(labelText: "3"),
                                 cursorColor: Colors.indigo,
                               ),
                               TextField(
                                 controller: concerto4_controller,
                                 decoration: InputDecoration(labelText: "4"),
                                 cursorColor: Colors.indigo,
                               ),
                               TextField(
                                 controller: concerto5_controller,
                                 decoration: InputDecoration(labelText: "5"),
                                 cursorColor: Colors.indigo,
                               ),
                               TextField(
                                 controller: concerto6_controller,
                                 decoration: InputDecoration(labelText: "6"),
                                 cursorColor: Colors.indigo,
                               ),
                               TextField(
                                 controller: concerto7_controller,
                                 decoration: InputDecoration(labelText: "7"),
                                 cursorColor: Colors.indigo,
                               ),
                               TextField(
                                 controller: concerto8_controller,
                                 decoration: InputDecoration(labelText: "8"),
                                 cursorColor: Colors.indigo,
                               ),
                             ],
                           ),

                           Text(
                             "Workflow resumo da Missão (olhe o workflow geral no botão \"Workflow\": ",
                             style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 fontFamily: 'Helvetica',
                                 fontSize: 12
                             ),),
                           Wrap(
                             crossAxisAlignment: WrapCrossAlignment.center,
                             children: <Widget>[
                               _buildCircle("1", "Receba o\nequipamento",
                                   statusWorkflow, 1),
                               Container(
                                 height: 1.0,
                                 width: 40.0,
                                 color: Colors.grey[500],
                               ),
                               _buildCircle(
                                   "2", "Solicite info.\npara o chamado",
                                   statusWorkflow, 2),
                               Container(
                                 height: 1.0,
                                 width: 40.0,
                                 color: Colors.grey[500],
                               ),
                               _buildCircle(
                                   "3", "Abra o\nchamado", statusWorkflow,
                                   3),
                               Container(
                                 height: 1.0,
                                 width: 40.0,
                                 color: Colors.grey[500],
                               ),
                               _buildCircle(
                                   "4", "Avalie o\nequipameento", statusWorkflow, 4),
                               Container(
                                 height: 1.0,
                                 width: 40.0,
                                 color: Colors.grey[500],
                               ),
                               _buildCircle(
                                   "5", "Realize o\nconserto", statusWorkflow,
                                   5),
                               Container(
                                 height: 1.0,
                                 width: 40.0,
                                 color: Colors.grey[500],
                               ),
                               _buildCircle(
                                   "6", "Técnico testa\nequipamento\napós conserto",
                                   statusWorkflow, 6),
                               Container(
                                 height: 1.0,
                                 width: 40.0,
                                 color: Colors.grey[500],
                               ),
                               _buildCircle("7", "Devolva/Instale\no equipamento\nconsertado",
                                   statusWorkflow, 7),
                               Container(
                                 height: 1.0,
                                 width: 40.0,
                                 color: Colors.grey[500],
                               ),
                               _buildCircle("8", "Finalize o \nchamado",
                                   statusWorkflow, 8),
                             ],
                           ),


                           SizedBox(height: 20,),

                           InkWell(
                             child: BotaoCircular1(
                               fundo: Colors.grey,
                               texto: Text("Retornar Processo",
                                 style: TextStyle(
                                     color: Colors.indigo),
                               ),
                               corTexto: Colors.white,
                               apertar: (){
                                 statusWorkflow == 1 ?
                                 Firestore.instance.collection("quests").document(questId).updateData({
                                   "status_workflow": 1
                                 })
                                     : Firestore.instance.collection("quests").document(questId).updateData({
                                   "status_workflow": statusWorkflow-1
                                 });
                               },
                             ),
                           ),

                           InkWell(
                             child: BotaoCircular1(
                               fundo: Colors.indigoAccent,
                               texto: Text("Concluir Processo",
                                 style: TextStyle(
                                     color: Colors.white),
                               ),
                               corTexto: Colors.white,
                               apertar: () {
                                 if(statusWorkflow == qtdProcessos) {
                                   Alert(
                                     context: context,
                                     title: "Finalizar Missão?",
                                     desc: "Se a atividade já foi concluída, "
                                         "aperte em \"Sim\" para que você receba o seu prêmio, caso contrário, aperte em \"Não\".",
                                     type: AlertType.warning,
                                     buttons: [
                                       DialogButton(
                                         child: Text(
                                           "Sim",
                                           style: TextStyle(
                                               color: Colors.white,
                                               fontSize: 20,
                                               fontFamily: 'Helvetica'),
                                         ),
                                         onPressed: (){
                                           Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("questsAceitas").document(questaceita.idQuestsAceitas).updateData({
                                             "concluida": true,
                                             "acoes_tomadas" : "\n"+ concerto1_controller.text +"\n"+ concerto2_controller.text + "\n"+ concerto3_controller.text
                                                 + "\n"+ concerto4_controller.text+ "\n"+ concerto5_controller.text+ "\n"+ concerto6_controller.text+ "\n"+ concerto7_controller.text
                                                 + "\n"+ concerto8_controller.text,
                                           });
                                           user.userData["xp"] = user.userData["xp"] + premio;
                                           Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).updateData({
                                             "xp": user.userData["xp"] + premio,
                                           });
                                           Firestore.instance.collection("quests").document(questId).updateData({
                                             "concluida": true,
                                             "acoes_tomadas" : "\n"+ suprimento1_controller.text +"\n"+ suprimento2_controller.text + "\n"+ suprimento3_controller.text
                                                 + "\n"+ suprimento4_controller.text,
                                           });
                                           questaceita.concluida=true;
                                           questaceita.acoesTomadas = "\n"+ concerto1_controller.text +"\n"+ concerto2_controller.text + "\n"+ concerto3_controller.text
                                               + "\n"+ concerto4_controller.text+ "\n"+ concerto5_controller.text+ "\n"+ concerto6_controller.text+ "\n"+ concerto7_controller.text
                                               + "\n"+ concerto8_controller.text;
                                           questaceita.questData.concluida=true;
                                           Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("questsConcluidas").add(questaceita.toMap(user.firebaseUser.uid)).then((doc){
                                             questaceita.idQuestsAceitas = doc.documentID;
                                           });
                                           //Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("questsAceitas").document(questId).delete();

                                           QuestAcceptModel.of(context).removeQuest(questaceita);
                                           Navigator.push(context, MaterialPageRoute(
                                               builder: (context) => HomeUser()));

                                           Alert(
                                             context: context,
                                             title: "Missão Finalizada!",
                                             desc: "Parabéns guerreiro. Seu prêmio será lançado em breve à você.",
                                             buttons: [
                                               DialogButton(
                                                 child: Text(
                                                   "Não",
                                                   style: TextStyle(
                                                       color: Colors.white,
                                                       fontSize: 20,
                                                       fontFamily: 'Helvetica'),
                                                 ),
                                                 onPressed: () => Navigator.pop(context),
                                                 color: Colors.indigo[400],
                                               ),
                                             ],
                                           ).show();


                                         },
                                         color: Colors.indigo[400],
                                       ),
                                       DialogButton(
                                         child: Text(
                                           "Não",
                                           style: TextStyle(
                                               color: Colors.white,
                                               fontSize: 20,
                                               fontFamily: 'Helvetica'),
                                         ),
                                         onPressed: () => Navigator.pop(context),
                                         color: Colors.indigo[400],
                                       ),
                                     ],
                                   ).show();
                                 } else {
                                   Firestore.instance.collection("quests")
                                       .document(questId)
                                       .updateData({
                                     "status_workflow": statusWorkflow + 1
                                   });
                                 };
                               },
                             ),
                           ),
                         ],
                       );
                     }
                 }
               }
           ),
         ),
       );
     },
    );

  }

  //mostrando detalhes da quest por uma função. Não vou usar porque os dados já estão no card
  String _buildQuestsText (DocumentSnapshot snapshot){
    String text = "Descrição:\n";
    //São as listas do Firbase
    for(LinkedHashMap q in snapshot.data["questDados"]){
      text += "${q["xp"]}";
    }
  }

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
*/
