import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_is_a_game_app/UI_User/home_user.dart';
import 'package:job_is_a_game_app/UI_User/workflow_image.dart';
import 'package:job_is_a_game_app/geral_screens/login_screen.dart';
import 'package:job_is_a_game_app/models/questAccepts_model.dart';
import 'package:job_is_a_game_app/models/quests_accepts.dart';
import 'package:job_is_a_game_app/models/quets.dart';
import 'package:job_is_a_game_app/models/user.dart';
import 'package:photo_view/photo_view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class QuestScreen extends StatefulWidget {

  //AULA 149 (5:40) e 150 :
  final Quests quest;
  User user;
  QuestScreen(this.quest, this.user);

  //NA AULA 150 (TEMPO 0:54'') ELE TEM UM CONSTRUTOR QUE RECEBE O PRODUTO. VERIFICAR COMO ELE FEZ ISSO
  @override
  _QuestScreenState createState() => _QuestScreenState(quest, user);
}

class _QuestScreenState extends State<QuestScreen> {
  //AULA 149 (6:00) e 150 :
  final Quests quest;
  List<QuestsAccepts> listaDeMissoesAceitas=[];
  String caminhoDaImagemWorkflow;
  User user;
  
  _QuestScreenState(this.quest, this.user);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final formato = DateFormat('dd/MM/yyyy');

  void _loadMissions() async{
    QuerySnapshot query = await Firestore.instance.collection("usuarios").document(this.user.firebaseUser.uid)
        .collection("questsAceitas").getDocuments();

    listaDeMissoesAceitas = query.documents.map((doc) => QuestsAccepts.fromDocument(doc)).toList();

  }

  @override
  Widget build(BuildContext context) {
    var inicio = quest.dataInicio.millisecondsSinceEpoch;
    var fim = quest.dataFim.millisecondsSinceEpoch;
    print (fim);
    _loadMissions();
    print("TAMANHO DA LISTA: "+listaDeMissoesAceitas.length.toString());
    //print (DateFormat("dd/MM/yyyy").format(inicio));
    //print (DateFormat("dd/MM/yyyy").format(DateTime.fromMillisecondsSinceEpoch(inicio)));

    return WillPopScope(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text("Missão: ${quest.titulo}", style: TextStyle(fontFamily: 'Helvetica',
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 17),
                textAlign: TextAlign.center,),
            centerTitle: true,
            backgroundColor: Colors.indigo,
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.info),
                tooltip: 'Ajuda',
                onPressed: () {
                  _onSuccess();
                },
              ),
            ],
          ),
          body: ListView(
            children: <Widget>[
              /* Ver na aula 150: Imagem em link
              A imagem do Workflow irá ficar logo no topo, para servir de referência.
              Utilizarei um AsectRatio para que a imagem não varie de tamanho conforme
              o aparelho. Dessa forma, o Aspect ratio sempre trará uma imagem que
              contém o resultado de largura/altura digitado.
               */

              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch, //Para que tudo ocupe o máximo de espaço possível
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Text("Descrição da Missão: ${quest.descricao}", style: TextStyle(fontFamily: 'Helvetica',
                      fontWeight: FontWeight.normal, color: Colors.black38, fontSize: 18,),
                      textAlign: TextAlign.justify,),

                    Divider(height: 20,),

                    Text("Recompensa: ${quest.xp.toString()} de xp", style: TextStyle(fontFamily: 'Helvetica',
                      fontWeight: FontWeight.normal, color: Colors.black45, fontSize: 16,),
                      textAlign: TextAlign.justify,),
                    SizedBox(height: 20,),


                    Text("Data de Início: ${DateFormat("dd/MM/yyyy").format(DateTime.fromMillisecondsSinceEpoch(inicio))}",
                        style: TextStyle(fontFamily: 'Helvetica',
                      fontWeight: FontWeight.normal, color: Colors.blueAccent[600], fontSize: 14,),),
                    quest.concluida == true ? Text("Data de Fim: ${DateFormat("dd/MM/yyyy").format(DateTime.fromMillisecondsSinceEpoch(fim))}", style: TextStyle(fontFamily: 'Helvetica',
                      fontWeight: FontWeight.normal, color: Colors.blueAccent[600], fontSize: 14,),) :
                       Text("Data de Fim: Aguardando...", style: TextStyle(fontFamily: 'Helvetica',
                      fontWeight: FontWeight.normal, color: Colors.blueAccent[600], fontSize: 14,),),


                    /*Divider(height: 50,),

                    Text("Guerreiros Convocados para a missão:", style: TextStyle(fontFamily: 'Helvetica',
                      fontWeight: FontWeight.normal, color: Colors.indigoAccent, fontSize: 16,),
                      textAlign: TextAlign.justify,),*/
                    //Circulos com as imagens dos guerreiros: Uma ideia de organização dos ícones está na aula 151, 2:30. Já dos círculos, ver a aula do chat.

                    Divider(height: 50,),

                    InkWell(
                          child: BotaoCircular1(
                            fundo: Colors.white,
                            texto: Text("Workflow",
                              style: TextStyle(
                                  color: Colors.indigo),
                            ),
                            corTexto: Colors.white,
                            apertar: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => WorkflowImage(_retornaCaminhoImagem(quest.idworkflow))));
                            },
                          ),
                        ),

                    Divider(height: 50,),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: InkWell(
                        child: BotaoCircular1(
                          fundo: Colors.white,
                          texto: Text("Aceitar",
                            style: TextStyle(
                                color: Colors.green),
                          ),
                          corTexto: Colors.green,
                          apertar: () { //async
                            int idUserQuest;
                            Future<DocumentSnapshot> a = Firestore.instance.collection("quests").document(quest.titulo).get().then((doc){
                              idUserQuest = doc.data["quantidade_de_participantes"]+1;
                            });

                            Firestore.instance.collection("quests").document(quest.titulo).updateData({
                              "aceita" : true,
                            });

                            //AULA 163 () - adicionando a quest na lista de quests aceitas
                            QuestsAccepts aceita = QuestsAccepts();
                            aceita.idQuestCopia = quest.id;
                            print("==============================: "+aceita.idQuestCopia);
                            aceita.titulo = quest.titulo;
                            print("==============================: "+aceita.titulo);
                            aceita.descricao = quest.descricao;
                            print("==============================: "+aceita.descricao);
                            aceita.aceita = true;
                            print("==============================: "+aceita.aceita.toString());
                            aceita.questData = quest;
                            aceita.idworkflow = quest.idworkflow;
                            aceita.concluida = false;
                            aceita.id = quest.idBanco;
                            aceita.status_workflow = quest.status_workflow;
                            aceita.listaUsuariosAceitaram.add(user.firebaseUser.uid);
                            aceita.dataInicio = quest.dataInicio;
                            aceita.dataFim = quest.dataFim;
                            aceita.quantidade_de_participantes = quest.quantidade_de_participantes;
                            print("USUARIO QUEM ACEITOU: "+aceita.listaUsuariosAceitaram[0] + "TAMANHO DA LISTA: "+ aceita.listaUsuariosAceitaram.length.toString());

                            QuestAcceptModel.of(context).addQuest(aceita);

                              Alert(
                                context: context,
                                title: "Quest Aceita!",
                                desc: "Parabéns por aceitar a missão guerreiro!"
                                    "\nVista-se para o combate! Verifique Suas missões em \"Missões Aceitas\"",
                                image: Image.asset('assets/img/aceita2.png', fit: BoxFit.fill,),
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "Fechar",
                                      style: TextStyle(color: Colors.white, fontSize: 20,
                                          fontFamily: 'Helvetica'),
                                    ),
                                    onPressed: () => Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => HomeUser())),
                                    color: Colors.indigo[400],
                                  ),
                                ],
                              ).show();
                          },
                        ),
                      ),
                    ),


                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: InkWell(
                        child: BotaoCircular1(
                          fundo: Colors.white,
                          texto: Text("Rejeitar",
                            style: TextStyle(
                                color: Colors.red),
                          ),
                          corTexto: Colors.red,
                          apertar: () {
                            return Alert(
                              context: context,
                              title: "Missão Recusada!",
                              desc: "É uma pena que você não queira ajudar nesta missão."
                                  "\nDe qualquer forma, se mudar de ideia, você poderá "
                                  "aceitar esta mesma missão enquanto ela não for concluída, "
                                  "bastando procurá-la na tela de Quests Disponíveis.",
                              image: Image.asset('assets/img/recusa_missao.png'),
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "Fechar",
                                    style: TextStyle(color: Colors.white, fontSize: 20,
                                        fontFamily: 'Helvetica'),
                                  ),
                                  onPressed: () => Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => HomeUser())),
                                  color: Colors.indigo[400],
                                ),
                              ],
                            ).show();
                          },
                        ),
                      ),
                    ),


                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: InkWell(
                        child: BotaoCircular1(
                          fundo: Colors.white,
                          texto: Text("Voltar",
                            style: TextStyle(
                                color: Colors.grey),
                          ),
                          corTexto: Colors.grey,
                          apertar: () => Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => HomeUser()
                                    )
                                  ),
                        ),
                      ),
                    ),


                  ],
                ),
              ),

            ],
          ),
        ),
        onWillPop: (){});
  }

  Widget _retornaImagem(int idWorkflow){
    if(idWorkflow == 0){
      return  Image.asset('assets/img/WorkflowJIG-Troca_de_hardware_ou_componente_defeituoso.png');
    } else if (idWorkflow == 1){
       return Image.asset('assets/img/WorkflowJIG-Troca_de_cabos_de_conexão_com_a_internet.png');
    } else if (idWorkflow == 2){
      return PhotoView(
          imageProvider: AssetImage('assets/img/WorkflowJIG-Solicitação_de_equipamentos_e_periféricos_aos_fornecedores.png', )
      );
    } else if (idWorkflow == 3){
      return PhotoView(
          imageProvider: AssetImage('assets/img/WorkflowJIG-Conserto_de_hardware_defeituoso.png', ));
    } else {
      return Text("Workflow não definido.");
    }
  }


  String _retornaCaminhoImagem(int idWorkflow){
    if(idWorkflow == 0){
      return  'assets/img/WorkflowJIG-Troca_de_hardware_ou_componente_defeituoso.png';
    } else if (idWorkflow == 1){
      return 'assets/img/WorkflowJIG-Troca_de_cabos_de_conexão_com_a_internet.png';
    } else if (idWorkflow == 2){
      return 'assets/img/WorkflowJIG-Solicitação_de_equipamentos_e_periféricos_aos_fornecedores.png';
    } else if (idWorkflow == 3){
      return 'assets/img/WorkflowJIG-Conserto_de_hardware_defeituoso.png';
    }
  }


  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.indigo,
      content: Text("Essas são as informações da missão. Você pode aceitar a missão, onde a mesma fará parte da "
          "sua lista de missões em andamento, ou rejeitá-la, sendo possível que você à veja ou aceite posteriormente!", style: TextStyle(
        color: Colors.white, fontFamily: 'Helvetica',
      ),),
      duration: Duration(seconds: 7),
    ));
  }
}
