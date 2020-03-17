import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_is_a_game_app/UI_User/creat_quest_screen.dart';
import 'package:job_is_a_game_app/UI_User/finish_quest_screen.dart';
import 'package:job_is_a_game_app/UI_User/out_screen.dart';
import 'package:job_is_a_game_app/UI_User/quests_aceepts_screen.dart';
import 'package:job_is_a_game_app/UI_User/reward_claim_screen2.dart';
import 'package:job_is_a_game_app/models/questAccepts_model.dart';
import 'package:job_is_a_game_app/models/quests_accepts.dart';
import 'package:job_is_a_game_app/models/quets.dart';
import 'package:job_is_a_game_app/models/user.dart';
import 'package:job_is_a_game_app/tiles/quest_tile.dart';
import 'package:job_is_a_game_app/widgets/custom_drawer.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:job_is_a_game_app/tiles/level_tile.dart';

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
  List a = [];
  Future<List> questsDoUsuario;
  Future<DocumentSnapshot> qAceitas;
  String userFirebaseId;
  Level listaLeveis;
  User user;
  int id;

  int i;
  int qtdQuestsConcluidas = 0;

  List<Quests> questes = [];
  List<QuestsAccepts> questesAcce = [];
  List<String> participantes = List();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final SnackBar snackBar = const SnackBar(content: Text('Aqui estão listadas '
      'todas as missões criadas. Clique nelas para mais informações, para '
      'aceitar a missão ou rejeitá-la.', style: TextStyle(color: Colors.white),), backgroundColor: Colors.indigo,);


  final GlobalKey<ScaffoldState> _scaffoldKeyConcluidas = GlobalKey<ScaffoldState>();
  final SnackBar snackBarConcluidas = const SnackBar(content: Text('Aqui estão listadas '
      'todas as missões finalizadas nas quais ocê fazia parte do grupo de guerreiros.',
    style: TextStyle(color: Colors.white),), backgroundColor: Colors.indigo,);

  /*
 @override
  void initState() {
   loadMissionsExtern();
  }*/

  //Retorna maior que 0 para verdadeiro e 1 para falso
  int aceitaPeloUsuario (AsyncSnapshot snapshot, int index, String user) {
    int i =0;
    const int padrao =0;
    int result = padrao;
    int total = snapshot.data.documents[index]["quantidade_de_participantes"];
    while (i < total){
      print("\nINDEX: "+index.toString()+"\nMISSÃO: "+ snapshot.data.documents[index]["titulo_quest"] +"\nTOTAL DE USUÁRIOS: "+total.toString() +"\nUSUARIO: "+user);
      user = user.toLowerCase();
      print("RESULT ANTES DO IF NO INDEX ${index.toString()}: "+result.toString()+"\n PARTICIPANTE: "+snapshot.data.documents[index]["participantes"][index.toString()].toString());

      print("RESULTADO DO TESTE DAS STRINGS NO INDEX ${index.toString()}: "+ (user.compareTo(snapshot.data.documents[index]["participantes"][index.toString()].toString().toLowerCase())).toString());

      if(user.compareTo(snapshot.data.documents[index]["participantes"][i.toString()].toString().toLowerCase()) == 0){
        result = result+1;
        print("RESULT DENTRO DO IF: "+result.toString());
      }
      i = i+1;
    }
    return result;
  }

  void recuperaLv(int lv) async {
    DocumentSnapshot pl = await Firestore.instance.collection("lista_Leveis").document("listaLv").get().then((doc){
      this.i =  doc.data[lv.toString()];;
    });
    print("================= RESULTADO(XP PROX NIV): "+ i.toString());
  }

  void _loadMissions() async{
    QuerySnapshot query = await Firestore.instance.collection("usuarios").document(user.firebaseUser.uid)
        .collection("questsAceitas").getDocuments();
    this.questesAcce = query.documents.map((doc) => QuestsAccepts.fromDocument(doc)).toList();
  }

  void _qtdMissoesCumpridas(User model)  {
    /*StreamSubscription<QuerySnapshot> q = Firestore.instance.collection("usuarios").document(model.firebaseUser.uid).collection("questsConcluidas").snapshots().listen((snapshot){
      for(DocumentSnapshot doc in snapshot.documents) {
        qtdQuestsConcluidas = qtdQuestsConcluidas + 1;
      }
    });*/
    var a = Firestore.instance.collection("usuarios").document(user.firebaseUser.uid)
        .collection("questsConcluidas").getDocuments().then((snapshot) async {
          //for(DocumentSnapshot doc in snapshot.documents){
            print("QUANTIDADE DE DOCUMENTOS: "+ await snapshot.documents.length.toString());
            qtdQuestsConcluidas = await snapshot.documents.length;
          //}
    });
    //await Firestore.instance.collection("usuarios").document(model.firebaseUser.uid).collection("questsConcluidas").snapshots(includeMetadataChanges: true).length;
  }

  @override
  Widget build(BuildContext context){
    return ScopedModelDescendant<User>(
                builder: (context, child, model){
                  _loadMissions();
                  this.user = model;
                  userFirebaseId = model.firebaseUser.uid;
                  print("NOME: "+user.userData["nome"]);
                  print("LEVEL: "+user.userData["level"].toString());
                  print("XP: "+user.userData["xp"].toString());
                  print("ID: "+user.userData["id"].toString());
                  print("IDADE: "+user.userData["idade"].toString());
                  print("USER FIREBASE: "+user.firebaseUser.uid);

                  int levelUser = user.userData["level"];
                  print("==: LEVEL USER: "+levelUser.toString());
                  recuperaLv(levelUser);
                  _qtdMissoesCumpridas(model);
                  print("QTD MISSÔES: "+qtdQuestsConcluidas.toString());


                  return WillPopScope(
                      child: PageView(
                        controller: pageControler,
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          Scaffold(
                            key: _scaffoldKey,
                            appBar: AppBar(
                              actions: <Widget>[
                                IconButton(
                                    icon: Icon(Icons.info),
                                    onPressed: () {
                                      _scaffoldKey.currentState.showSnackBar(snackBar);
                                    }
                                ),
                              ],
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
                            body: SingleChildScrollView(
                              //scrollDirection: Axis.vertical,
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                children: <Widget>[
                                  //CABEÇALHO
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Wrap(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.only(right: 5),
                                                child: Text("Level: ",
                                                  style: TextStyle(
                                                      fontFamily: 'helvetica',
                                                      fontSize: 16,
                                                      fontWeight: FontWeight
                                                          .bold),),),
                                              Padding(
                                                padding: EdgeInsets.only(right: 30),
                                                child: Text("${!model.isLoggedIn()
                                                    ? "0"
                                                    : model.userData["level"]
                                                    .toString()}",
                                                  style: TextStyle(
                                                      fontFamily: 'helvetica',
                                                      fontSize: 16,
                                                      fontWeight: FontWeight
                                                          .normal),),),
                                              Text("XP", style: TextStyle(
                                                  fontFamily: 'helvetica',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),),
                                              Padding(
                                                padding: EdgeInsets.only(left: 5),
                                                child: Text("${!model.isLoggedIn()
                                                    ? "0"
                                                    : model.userData["xp"]
                                                    .toString()}"),),
                                              Padding(
                                                padding: EdgeInsets.only(left: 40),
                                                child: Text("Next Lv. "),),
                                              model.userData["level"] == 0 ?
                                              Padding(
                                                padding: EdgeInsets.only(left: 10),
                                                child: Text("15"),
                                              )
                                                  : i == null ? Container(
                                                child: Padding (
                                                  padding: EdgeInsets.only(left: 10),
                                                  child: Text("Carregando dados...",),
                                                ),
                                              )
                                                  :Container(
                                                child: Padding (
                                                  padding: EdgeInsets.only(left: 10),
                                                  child: Text("${i.toString()}",),
                                                ),
                                              ),

                                            ],
                                          ),
                                          //},
                                          //),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Divider(height: 10,),

                                  Row(
                                    children: <Widget>[
                                      Container(
                                        height: 210,
                                        child: Image.asset('assets/img/aceito.png', fit: BoxFit.cover, width: 170, height: 170,),
                                      ),

                                      Container(
                                        height: 210,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.all(14),
                                              child: FlatButton.icon(
                                                onPressed: (){
                                                  return Alert(
                                                    context: context,
                                                    title: "Deseja subir de nível?",
                                                    desc: "Para subir de nível, você precisará pagar \b${i.toString()}\b em experiência (XP). Deseja realmente pagar?",
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
                                                        onPressed: () {
                                                          if(model.userData["xp"] >= i){
                                                            Firestore.instance.collection("usuarios").document(model.firebaseUser.uid).updateData({
                                                              "level" : model.userData["level"] + 1,
                                                              "xp" : user.userData["xp"] - i,
                                                            });
                                                            model.userData["level"]= model.userData["level"]+1;
                                                            model.userData["xp"] = model.userData["xp"] - i;
                                                            Alert(
                                                              context: context,
                                                              title: "Level Aumentado",
                                                              desc: "Parabéns guerreiro. Seu level foi aumentado. Continue cumprindo suas missões para aumentar mais seu level.",
                                                              type: AlertType.success,
                                                              buttons: [
                                                                DialogButton(
                                                                  child: Text(
                                                                    "Fechar",
                                                                    style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 20,
                                                                        fontFamily: 'Helvetica'),
                                                                  ),
                                                                  onPressed: () {
                                                                    Navigator.push(context, MaterialPageRoute(
                                                                        builder: (context) => HomeUser()));
                                                                    //Navigator.pop(context);
                                                                  },
                                                                  //},
                                                                  color: Colors.indigo[400],
                                                                ),
                                                              ],
                                                            ).show();
                                                          } else {
                                                            Alert(
                                                              context: context,
                                                              title: "XP Insuficiente!",
                                                              desc: "Guerreiro, sua quantidade atual de XP não é suficiente. Continue cumprindo suas missões para aumentar mais sua experiência (XP).",
                                                              type: AlertType.error,
                                                              buttons: [
                                                                DialogButton(
                                                                  child: Text(
                                                                    "Fechar",
                                                                    style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 20,
                                                                        fontFamily: 'Helvetica'),
                                                                  ),
                                                                  onPressed: () {
                                                                    Navigator.push(context, MaterialPageRoute(
                                                                        builder: (context) => HomeUser()));
                                                                    //Navigator.pop(context);
                                                                  },
                                                                  //},
                                                                  color: Colors.indigo[400],
                                                                ),
                                                              ],
                                                            ).show();
                                                          }
                                                        },
                                                        //},
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
                                                        onPressed: () {
                                                          Navigator.push(context, MaterialPageRoute(
                                                              builder: (context) => HomeUser()));
                                                        },
                                                        //},
                                                        color: Colors.indigo[400],
                                                      ),
                                                    ],
                                                  ).show();
                                                },
                                                label: Text("Subir Nível", style: TextStyle(fontFamily: 'Helvetica', fontSize: 12, color: Colors.indigo),textAlign: TextAlign.justify,),
                                                icon: Icon(Icons.add, size: 25, color: Colors.indigo,),
                                              ),
                                            ),
                                            Wrap(
                                              //mainAxisAlignment: MainAxisAlignment.start,
                                              //crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(left: 25),
                                                  child: Icon(Icons.check, size: 25, color: Colors.indigo,),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(3),
                                                  child: Text("Quantidade de\nmissões cumpridas: ", style: TextStyle(fontFamily: 'Helvetica', fontSize: 12, color: Colors.indigo),textAlign: TextAlign.start,),
                                                ),
                                                qtdQuestsConcluidas == 0 ?
                                                Padding(
                                                  padding: EdgeInsets.all(3),
                                                  child: Text("0", style: TextStyle(fontFamily: 'Helvetica', fontSize: 12, color: Colors.indigo),textAlign: TextAlign.start,),
                                                ) :
                                                Padding(
                                                  padding: EdgeInsets.all(3),
                                                  child: Text("${qtdQuestsConcluidas.toString()}", style: TextStyle(fontFamily: 'Helvetica', fontSize: 12, color: Colors.indigo),textAlign: TextAlign.start,),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  Container(
                                    padding: EdgeInsets.all(10),
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Divider(height: 50,),
                                        Center(
                                          child: Text("Quests Disponíveis",
                                            style: TextStyle(color: Colors.grey,
                                                fontFamily: 'helvetica',
                                                fontSize: 22,
                                                fontWeight: FontWeight.w500),),
                                        ),
                                      ],
                                    ),
                                  ),

                                  //QUESTS VINDAS EM FORMATO DE CARDS DO BANCO DE DADOS
                                  StreamBuilder(
                                      stream: Firestore.instance.collection("quests").snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData || snapshot == null) {
                                          return Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Divider(height: 90,),
                                              Image.asset(
                                                'assets/img/guerreiro.jpg', height: 40,
                                                width: 26,
                                                fit: BoxFit.cover,),
                                              Text("Não há quests lançadas ou abertas.",
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
                                            // ignore: missing_return
                                            itemBuilder: (context, index) {
                                              //print("RESULTADO da função: "+aceitaPeloUsuario(snapshot, index, userFirebaseId).toString());
                                              if(!snapshot.data.documents[index]["concluida"] == true && snapshot.data.documents[index]["aceita"] == false){//&& aceitaPeloUsuario(snapshot, index, userFirebaseId)<=0){ //&& snapshot.data.documents[index]["participantes"][index] != user.firebaseUser.uid) {
                                                  return QuestTile(context, Quests.fromDocument(snapshot.data.documents[index]), model);
                                                } else {
                                                  return Text("",
                                                    style: TextStyle(
                                                        fontSize: 1.0),);
                                                }

                                            },
                                          );
                                        } //else
                                      }),


                                ],
                              ),
                            ),),

                          /*
                Inserindo as outras telas
                 */

                          //TELA QUESTS ACEITAS
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
                                    builder: (context, child, model) {
                                      int q = model.questesAcce.length;
                                      //1ª Expressão: Se q for nulo, ele retorna zero, se não, retorna o valor de q.
                                      //2ª expressão: se q = 1 ou =0, escrevo Quest. Se for mais, escrevo Quests
                                      return Text("${q ?? 0} ${q == 1 || q == 0
                                          ? "Quest"
                                          : "Quests"}",
                                        style: TextStyle(
                                            fontSize: 16, fontFamily: 'Helvetica'),);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            body: QuestAcceptScreen(model),
                            drawer: CustomDrawer(pageControler),

                          ),

                          //TELA QUESTS CONCLUÍDAS
                          Scaffold(
                            key: _scaffoldKeyConcluidas,
                            appBar: AppBar(
                              title: Text("Quests Concluídas"),
                              backgroundColor: Colors.indigo,
                              centerTitle: true,
                              actions: <Widget>[
                                IconButton(
                                    icon: Icon(Icons.info),
                                    onPressed: () {
                                      _scaffoldKeyConcluidas.currentState.showSnackBar(snackBarConcluidas);
                                    }
                                ),
                              ],
                              //Colocar um ícone para exibir um snackbar informando que essa tela é destinada apenas a informações principais da quest
                            ),
                            //A appBar já foi definida na tela da classe quest_accept_screen
                            body: QuestsConcluidas(user),
                            drawer: CustomDrawer(pageControler),

                          ),

                          //TELA CLAMAR RECOMPENSAS
                          Scaffold(
                            appBar: AppBar(
                              title: Text("Clamar Recompensas"),
                              backgroundColor: Colors.indigo,
                              centerTitle: true,
                              //Colocar um ícone para exibir um snackbar informando que essa tela é destinada apenas a informações principais da quest
                            ),
                            drawer: CustomDrawer(pageControler),
                            //A appBar já foi definida na tela da classe quest_accept_screen
                            body: RewardClaim2(pageControler, user),

                          ),

                          //TELA CRIAR MISSÃO
                          Scaffold(
                            appBar: AppBar(
                              title: Text("Criar Missão"),
                              backgroundColor: Colors.indigo,
                              centerTitle: true,
                              //Colocar um ícone para exibir um snackbar informando que essa tela é destinada apenas a informações principais da quest
                            ),
                            //A appBar já foi definida na tela da classe quest_accept_screen
                            body: CriarQuest(pageControler, user.firebaseUser.uid),
                            drawer: CustomDrawer(pageControler),

                          ),

                          //TELA SAIR
                          Scaffold(
                            appBar: AppBar(
                              title: Text("Sair"),
                              backgroundColor: Colors.indigo,
                              centerTitle: true,
                              //Colocar um ícone para exibir um snackbar informando que essa tela é destinada apenas a informações principais da quest
                            ),
                            //A appBar já foi definida na tela da classe quest_accept_screen
                            body: ScopedModelDescendant<User>(
                                builder: (context, child, model){
                                  return Sair(pageControler, model);
                                }
                            ),
                            drawer: CustomDrawer(pageControler),

                          ),

                        ],
                      ),
                      onWillPop: null);
                });
  }

  void RecuperaNextLevel() async {
    int iterator =0;

    var xpBanco = await Firestore.instance.collection("lista_Leveis").document("listaLv").get().then((doc){
      while(iterator <= 15){
        this.a.add(doc.data[iterator]);
        iterator ++;
      }
    });
  }
}
