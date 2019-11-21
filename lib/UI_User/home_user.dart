import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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


  @override
  Future initState() async {
    leveis = await Firestore.instance.collection("lista_Leveis").document("listaLev").get();
    snapshot = Firestore.instance.collection("lista_Leveis").getDocuments();
  }*/

  final pageControler = PageController();
  QuestAcceptModel questsAceitas;
  List questsDoUsuario = [];
  Future<DocumentSnapshot> qAceitas;

  List nextLevel;
  Future<List> nextLevel2;
  int d=0;
  Future<int> lll;
  int dd;

 /* Future<DocumentSnapshot> listaDeXp = Firestore.instance.collection("lista_Leveis").document("listaLev").get().then((doc){
    nextLevel.add(doc.data["xpNecessario"][0]);
  });*/

      /*.then((doc){
    int i = 0;
    while(i<=100){
      *//*nextLevel.add(doc.data["xpNecessario"][i]);
      nextLevel[i] = doc.data["xpNecessario"][i];*//*
      i++;
    }
  });*/

  Future<int> loadListLevels(int level) async{
    Iterable ll;
    DocumentSnapshot docLev = await Firestore.instance.collection("lista_Leveis").document("listaLv").get();
    nextLevel = docLev.data["level"];
    ll = nextLevel.getRange(level, level);
    return ll.elementAt(0);
  }

  Future<int> loadListLevels2(int level) async{
    DocumentSnapshot docLev = await Firestore.instance.collection("lista_Leveis").document("listaLv").get().then((doc){
      dd = doc.data[4];
    });
    //nextLevel.add(docLev.data[level.toString()]);
    //return ll = nextLevel[0];
    return dd;
  }

  /*List<Level> questesAceitas = [];

  void _loadLeveis() async{
    QuerySnapshot query = await Firestore.instance.collection("lista_Leveis").document("listaLev").getDocuments();

    questesAceitas = query.documents.map((doc) => Level.fromDocument(doc)).toList();

  }*/





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
              body: ScopedModelDescendant<User>(
                builder: (context, child, model){




                  this.lll = loadListLevels2(model.userData["level"]);




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
                                Wrap(
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  //crossAxisAlignment: CrossAxisAlignment.center,

                                  children: <Widget>[
                                    Padding(padding: EdgeInsets.only(right: 5), child: Text("Level: ",
                                      style: TextStyle(fontFamily: 'helvetica',fontSize: 16, fontWeight: FontWeight.bold),),),
                                    Padding(padding: EdgeInsets.only(right: 30), child: Text("${!model.isLoggedIn() ? "0" : model.userData["level"].toString()}",
                                      style: TextStyle(fontFamily: 'helvetica',fontSize: 16, fontWeight: FontWeight.normal),),),
                                    Text("XP", style: TextStyle(fontFamily: 'helvetica',fontSize: 16, fontWeight: FontWeight.bold),),
                                    Padding(padding: EdgeInsets.only(left: 5), child: Text("${!model.isLoggedIn() ? "0" : model.userData["xp"].toString()}"),),
                                    Padding(padding: EdgeInsets.only(left: 60), child: Text("Next Lv."),),
                                    model.userData["level"] == 0 ?
                                      Padding(padding: EdgeInsets.only(left: 10), child: Text("${d.toString()
                                          }",
                                        //!model.isLoggedIn() ? "0": leveis.data["${model.userData["level"]}"]
                                      ),)
                                    : Padding(padding: EdgeInsets.only(left: 10), child: Text("${[model.userData["level"]]}",
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
                                  itemBuilder: (context, index){

                                    if(!snapshot.data.documents[index]["concluida"] == true){
                                      return QuestTile(context, Quests.fromDocument(snapshot.data.documents[index]));
                                    }
                                    /*if(!snapshot.data.documents[index]["concluida"] == true || !snapshot.data.documents[index]["aceita"] == false){
                                      //return criaCard(context, snapshot.data.documents[index]);
                                      return QuestTile(context, Quests.fromDocument(snapshot.data.documents[index]));
                                    }*/
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
                        int q = model.questesAceitas.length;
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
                title: Text("Clamar Recompensas"),
                backgroundColor: Colors.indigo,
                centerTitle: true,
                //Colocar um ícone para exibir um snackbar informando que essa tela é destinada apenas a informações principais da quest
              ),
              //A appBar já foi definida na tela da classe quest_accept_screen
              body: RewardClaim2(pageControler),
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



  //Usarei um card para cada quest recuperada do banco
  //Aula 99
  /*Widget criaCard(BuildContext context, DocumentSnapshot snapshot) {
    return InkWell(
          //COLOCAR AQUI O NAVIGATOR PARA A TELA DE INFORMAÇÕES GERAIS DA QUEST
          onTap: (){
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=>QuestScreen(widget.quest))
            );
          },
          child: Card(
                //margem
                child: Padding(padding: EdgeInsets.all(14.0),
                  child: Row(
                    children: <Widget>[
                      //Imagem
                      Container(
                        //Criando o círculo no cantainer com medidas iguais pra não ficar achatado
                        width: 30.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/img/guerreiro.jpg'),
                            //fit: BoxFit.fill,
                          ),
                        ),
                      ),

                      //Espaço entre a imagem e o texto e os dados da quest
                      Padding(padding: EdgeInsets.only(left: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                          snapshot["titulo_quest"].length >20? Text("${snapshot["titulo_quest"]}".substring(0,20)+"...",
                              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: 'Helvetica'),
                            ) : Text("${snapshot["titulo_quest"]}",
                              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: 'Helvetica'),
                            ),
                          snapshot["descricao_quest"].length>20 ?
                          Text("Missão: ${snapshot["descricao_quest"]}".substring(0,40)+"...",
                            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, fontFamily: 'Helvetica')):
                              Text("Missão: ${snapshot["descricao_quest"]}", style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, fontFamily: 'Helvetica'),),

                          Text("XP: ${snapshot["xp"].toString()}",
                              style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.normal, fontFamily: 'Helvetica'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }*/

 /* Widget criaCard3(DocumentSnapshot snapshot) {
    return GestureDetector(
      //COLOCAR AQUI O NAVIGATOR PARA A TELA DE INFORMAÇÕES GERAIS DA QUEST
      onTap: (){},
      child: Card(
        //margem
        child: Padding(padding: EdgeInsets.all(14.0),
          child: Row(
            children: <Widget>[
              //Imagem
              Container(
                //Criando o círculo no cantainer com medidas iguais pra não ficar achatado
                width: 65.0,
                height: 65.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/img/guerreiro.jpg'),
                    //fit: BoxFit.fill,
                  ),
                ),
              ),

              //Espaço entre a imagem e o texto e os dados da quest
              Padding(padding: EdgeInsets.only(left: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(snapshot["titulo_quest"],
                      style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, fontFamily: 'Helvetica'),
                    ),
                    Text("Missao: ${snapshot["descricao_quest"]}", maxLines: 1,
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, fontFamily: 'Helvetica'),
                    ),
                    Text("XP: ${snapshot["xp"].toString()}",
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, fontFamily: 'Helvetica'),
                    ),
                  ],
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }*/

}
