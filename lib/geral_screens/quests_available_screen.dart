import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_is_a_game_app/UI_User/quest_screen.dart';
import 'package:job_is_a_game_app/UI_User/quests_aceepts_screen.dart';
import 'package:job_is_a_game_app/models/questAccepts_model.dart';
import 'package:job_is_a_game_app/models/quets.dart';
import 'package:job_is_a_game_app/models/user.dart';
import 'package:job_is_a_game_app/tiles/quest_tile.dart';
import 'package:job_is_a_game_app/widgets/custom_drawer.dart';
import 'package:scoped_model/scoped_model.dart';

class QuestsAvaliable extends StatefulWidget {

  final Quests quest = Quests();

  @override
  _QuestsAvaliableState createState() => _QuestsAvaliableState();
}

class _QuestsAvaliableState extends State<QuestsAvaliable> {


  final pageControler = PageController();
  QuestAcceptModel questsAceitas;
  User user;
  List questsDoUsuario = [];


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: PageView(
      controller: pageControler,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigo[300],
            title: Text("QUESTS!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Helvetica',
              ),
            ),
            centerTitle: true,
          ),

          //BURGUER MENU
          drawer: CustomDrawer(pageControler),

          //pARA QUE A TELA SEJA MODIFICADA COM OS ESTADOS DO USER, QUE É UM MODEL,
          //EU USO O SCOPEDMODELDESCENDENT, ESPECIFICANDO
          //UM BIULDER COM UM CONTEXTO, UM CHILD E UM MODEL. ESSE MODEL PODERÁ SER ACESSADO POR QUALQUER PARTE DA PÁGINA CRIADA
          body: ScopedModelDescendant<User>(
            builder: (context, child, model){
              this.questsAceitas = QuestAcceptModel(model);
              this.questsDoUsuario = questsAceitas.questesAcce;
              return SingleChildScrollView(
                //scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("XP", style: TextStyle(fontFamily: 'helvetica',fontSize: 16, fontWeight: FontWeight.bold),),
                                Padding(padding: EdgeInsets.only(left: 10), child: Text("${!model.isLoggedIn() ? "0" : model.userData["xp"].toString()}"),),
                                Padding(padding: EdgeInsets.only(left: 150), child: Text("Next Lv."),),
                                Padding(padding: EdgeInsets.only(left: 10), child: Text("20"
                                  //!model.isLoggedIn() ? "0": leveis.data["${model.userData["level"]}"]
                                ),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),


                    Container(
                      height: 140,
                      child: Image.asset('assets/img/aceito.png', fit: BoxFit.fill,),
                    ),


                    Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Divider(height: 50,),
                          Center(
                            child: Text("Quests Disponíveis", style: TextStyle(color: Colors.grey, fontFamily: 'helvetica',fontSize: 22, fontWeight: FontWeight.w500),),
                          ),
                        ],
                      ),
                    ),

                    //QUESTS VINDAS EM FORMATO DE CARDS
                    StreamBuilder(
                        stream: Firestore.instance.collection("quests").snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData || snapshot == null) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Divider(height: 90,),
                                Image.asset('assets/img/guerreiro.jpg', height: 40,
                                  width: 26,
                                  fit: BoxFit.cover,),
                                Text("Não há novas quests.", style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontSize: 15.0,
                                    color: Colors.indigo),)
                              ],
                            );
                          } else {
                            return ListView.builder(
                              itemCount: snapshot.data.documents.length,
                              shrinkWrap: true,
                              reverse: true,
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.all(12.0),
                              itemBuilder: (context, index) {
                                if(!snapshot.data.documents[index]["concluida"] == true){
                                  //return criaCard(context, snapshot.data.documents[index]);
                                  //return QuestTile(context, Quests.fromDocument(snapshot.data.documents[index]),);
                                }
                              },
                            );
                          }//else
                        }),


                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
        onWillPop: (){});
  }
}
