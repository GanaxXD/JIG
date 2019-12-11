import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_is_a_game_app/UI_User/creat_quest_screen.dart';
import 'package:job_is_a_game_app/UI_User/finish_quest_screen.dart';
import 'package:job_is_a_game_app/UI_User/out_screen.dart';
import 'package:job_is_a_game_app/UI_User/quests_aceepts_screen.dart';
import 'package:job_is_a_game_app/UI_User/reward_claim_screen.dart';
import 'package:job_is_a_game_app/UI_User/reward_claim_screen2.dart';
import 'package:job_is_a_game_app/models/questAccepts_model.dart';
import 'package:job_is_a_game_app/models/quests_accepts.dart';
import 'package:job_is_a_game_app/models/quets.dart';
import 'package:job_is_a_game_app/models/user.dart';
import 'package:job_is_a_game_app/tiles/quest_tile.dart';
import 'package:job_is_a_game_app/widgets/custom_drawer.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:job_is_a_game_app/tiles/level_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeUser extends StatefulWidget {
  final Quests quest = Quests();
  @override
  _HomeUserState createState() => _HomeUserState();

}

class _HomeUserState extends State<HomeUser>{

  //Future<QuerySnapshot> questsaceitas = Firestore.instance.collection("usuarios").getDocuments();
  //Quests q1 = Quests.preenchido(1, [1], "Teste título", "Uma coisa mais", DateTime.now(), DateTime.now(), 1);
  //Future<DocumentSnapshot> snapshot = Firestore.instance.collection("quests").document().get();
/*
  DocumentSnapshot leveis;
  Future<QuerySnapshot> snapshot;


  Future<List> listaAceitas;

  @override
  Future initState() async {
    //listaAceitas = await Firestore.instance.document("usuarios").
  }
*/
  final pageControler = PageController();
  QuestAcceptModel questsAceitas;
  List a = [];
  Future<List> questsDoUsuario;
  Future<DocumentSnapshot> qAceitas;
  String userFirebaseId;



  Future<List> loadMissions (User user) async {
    QuerySnapshot query = await Firestore.instance.collection("usuarios").document(user.firebaseUser.uid)
        .collection("questsAceitas").getDocuments();
    a = query.documents.map((doc) => QuestsAccepts.fromDocument(doc)).toList();

    return a;
  }


  @override
  Widget build(BuildContext context){
    //print(this.snapshot.toString());
    //ACESSANDO O ATRIBUTO DA CLASSE:
    //this.q1.gravarQuest(q1);
    //this.q1.deletarQuest(q1);


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
              body: ScopedModelDescendant<User> (
                builder: (context, child, model) {

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
                                StreamBuilder<DocumentSnapshot>(
                                  //Ao criar a quest, preciso inserir um campo chamado status. Talvez eu precise usar as questsAceitas
                                  stream: Firestore.instance.collection("usuarios").document(model.firebaseUser.uid).snapshots(),//Firestore.instance.collection("quests").document(questId).snapshots(),
                                  builder: (context, snapshot){
                                    print("=====================: ${model.firebaseUser.uid}");
                                    return Wrap(
                                      children: <Widget>[
                                        Padding(padding: EdgeInsets.only(right: 5), child: Text("Level: ",
                                          style: TextStyle(fontFamily: 'helvetica',
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),),),
                                        Padding(padding: EdgeInsets.only(right: 30),
                                          child: Text("${!model.isLoggedIn() ? "0" : model.userData["level"]
                                              .toString()}",
                                            style: TextStyle(fontFamily: 'helvetica',
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal),),),
                                        Text("XP", style: TextStyle(fontFamily: 'helvetica',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),),
                                        Padding(padding: EdgeInsets.only(left: 5),
                                          child: Text("${!model.isLoggedIn() ? "0": snapshot.data["xp"].toString()}"),),
                                        Padding(
                                          padding: EdgeInsets.only(left: 60),
                                          child: Text("Next Lv. "),),
                                            model.userData["level"] == 0 ?
                                            Padding(
                                              padding: EdgeInsets.only(left: 10), child: Text("0"),
                                        )
                                            : Padding(padding: EdgeInsets.only(left: 10),
                                          child: StreamBuilder<DocumentSnapshot>(
                                              stream: Firestore.instance.collection("lista_Leveis")
                                                  .document("listaLv").snapshots(),//Firestore.instance.collection("quests").document(questId).snapshots(),
                                              builder: (context, snapshot) {
                                                return Text("${snapshot.data["${model.userData["level"].toString()}"]}",
                                                );
                                              }
                                          ),
                                        ),

                                      ],
                                    );

                                  },
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
                                  reverse: false,
                                  scrollDirection: Axis.vertical,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.all(12.0),
                                  itemBuilder: (context, index){

                                    if(!snapshot.data.documents[index]["concluida"] == true){// && questsDoUsuario[index]["idQuest"] != snapshot.data.documents[index]["titulo_quest"]){
                                      return QuestTile(context, Quests.fromDocument(snapshot.data.documents[index]));
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

            /*
        Inserindo as outras telas
         */
            Scaffold(
              //A appBar já foi definida na tela da classe quest_accept_screen
              appBar: AppBar(
                title: Text("Quest Aceita"),
                backgroundColor: Colors.indigo,
                centerTitle: true,
                //Colocar um ícone para exibir um snackbar informando que essa tela é destinada apenas a informações principais da quest

                actions: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(right: 10),
                    child: ScopedModelDescendant<QuestAcceptModel>(
                      builder: (context, child, model){
                        int q = model.questesAcce.length;
                        //1ª Expressão: Se q for nulo, ele retorna zero, se não, retorna o valor de q.
                        //2ª expressão: se q = 1 ou =0, escrevo Quest. Se for mais, escrevo Quests
                        return Text("${q ?? 0} ${q == 1 || q == 0 ? "Quest" : "Quests"}",
                          style: TextStyle( fontSize: 16, fontFamily: 'Helvetica'), );
                      },
                    ),
                  ),
                ],
              ),
              body: QuestAcceptScreen(),
              drawer: CustomDrawer(pageControler),

            ),

            Scaffold(
              appBar: AppBar(
                title: Text("Quests Concluídas"),
                backgroundColor: Colors.indigo,
                centerTitle: true,
                //Colocar um ícone para exibir um snackbar informando que essa tela é destinada apenas a informações principais da quest
              ),
              //A appBar já foi definida na tela da classe quest_accept_screen
              body: QuestsConcluidas(),
              drawer: CustomDrawer(pageControler),

            ),

            Scaffold(
              appBar: AppBar(
                title: Text("Clamar Recompensas"),
                backgroundColor: Colors.indigo,
                centerTitle: true,
                //Colocar um ícone para exibir um snackbar informando que essa tela é destinada apenas a informações principais da quest
              ),
              drawer: CustomDrawer(pageControler),
              //A appBar já foi definida na tela da classe quest_accept_screen
              body: ScopedModelDescendant<User>(
                builder: (context, child, model) {
                  return RewardClaim2(pageControler, userFirebaseId);
                },


              ),),


            Scaffold(
              appBar: AppBar(
                title: Text("Criar Missão"),
                backgroundColor: Colors.indigo,
                centerTitle: true,
                //Colocar um ícone para exibir um snackbar informando que essa tela é destinada apenas a informações principais da quest
              ),
              //A appBar já foi definida na tela da classe quest_accept_screen
              body: CriarQuest(pageControler),
              drawer: CustomDrawer(pageControler),

            ),

            Scaffold(
              appBar: AppBar(
                title: Text("Sair"),
                backgroundColor: Colors.indigo,
                centerTitle: true,
                //Colocar um ícone para exibir um snackbar informando que essa tela é destinada apenas a informações principais da quest
              ),
              //A appBar já foi definida na tela da classe quest_accept_screen
              body: Sair(pageControler),
              drawer: CustomDrawer(pageControler),

            ),


          ],
        ),
        onWillPop: (){});


  }

}
