import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_is_a_game_app/UI_User/workflow_image.dart';
import 'package:job_is_a_game_app/UI_User/workflow_status_screen.dart';
import 'package:job_is_a_game_app/geral_screens/login_screen.dart';
import 'package:job_is_a_game_app/models/questAccepts_model.dart';
import 'package:job_is_a_game_app/models/quests_accepts.dart';
import 'package:job_is_a_game_app/models/quets.dart';
import 'package:job_is_a_game_app/models/user.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AceitasTile extends StatelessWidget {

  //CARTPRODUCT
  final QuestsAccepts questaceita;
  AceitasTile(this.questaceita, this.user);

  // Preciso disso pra acessa a colecao de quests aceitas
  // do usuário
  User user;


/*
CRIANDO CARD DAS QUESTS PROGRAMATICAMENTE
 */
  @override
  Widget build(BuildContext context) {
    var inicio = questaceita.dataInicio.millisecondsSinceEpoch;
    var fim = questaceita.dataFim.millisecondsSinceEpoch;

    Widget _buildContent(){
        return Column(
          children: <Widget>[
            Container(
              width: 90,
              //NA imagem posso tentar por uma minha do workflow.
              child: Image.asset('assets/img/aceita2.png', fit: BoxFit.cover,),
              padding: EdgeInsets.all(8.0),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //Elementos espaçados igualmente na vertical:
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Wrap(
                          children: <Widget>[
                            Text("Missão:  ", style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'Helvetica'
                            ),),

                            Text(questaceita.questData.titulo, style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18, fontFamily: 'Helvetica'
                            ),),
                          ],
                        ),

                        SizedBox(height: 20,),
                        Wrap(
                          children: <Widget>[
                            Text("Descrição da Missão:  ", style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Helvetica'
                            ),),

                            Text(questaceita.questData.descricao, style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 14, fontFamily: 'Helvetica'
                            ),),
                          ],
                        ),

                        SizedBox(height: 20,),
                        Wrap(
                          children: <Widget>[
                            Text("Recompensa:  ", style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12, fontFamily: 'Helvetica'
                            ),),

                            Text(" ${questaceita.questData.xp.toString()} de XP", style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 12, fontFamily: 'Helvetica'
                            ),),
                          ],
                        ),

                        SizedBox(height: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("Data de Início: ${DateFormat("dd/MM/yyyy").format(DateTime.fromMillisecondsSinceEpoch(inicio))}",
                              style: TextStyle(fontFamily: 'Helvetica',
                                fontWeight: FontWeight.normal, color: Colors.blueAccent[600], fontSize: 14,),),
                            questaceita.concluida == true ? Text("Data de Fim: ${DateFormat("dd/MM/yyyy").format(DateTime.fromMillisecondsSinceEpoch(fim))}", style: TextStyle(fontFamily: 'Helvetica',
                              fontWeight: FontWeight.normal, color: Colors.blueAccent[600], fontSize: 14,),textAlign: TextAlign.start,) :
                            Text("Data de Fim: Aguardando...", style: TextStyle(fontFamily: 'Helvetica',
                              fontWeight: FontWeight.normal, color: Colors.blueAccent[600], fontSize: 14,),textAlign: TextAlign.start,),
                          ]
                    ),


                        SizedBox(height: 20,),
                        WorkFlowStatus(questaceita.idQuestCopia, user, questaceita),


                        SizedBox(height: 40,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: BotaoCircular1(
                                fundo: Colors.redAccent,
                                texto: Text("Desistir?",
                                  style: TextStyle(fontFamily: 'Helvetica',
                                      color: Colors.white, fontSize: 20),
                                ),
                                corTexto: Colors.red,
                                apertar: () {
                                  return Alert(
                                    context: context,
                                    type: AlertType.warning,
                                    title: "Deseja Realmente Desistir?",
                                    desc: "Bravo guerreiro, desistir irá tirar de você a possibilidade"
                                        "de obter pontos de experiência desta missão. Tem certeza que"
                                        "deseja desistir da missão?\n\nP.S.: Você poderá aceitar a missão novamente"
                                        "na tela de \"Quests Disponíveis\"",

                                    buttons: [
                                      DialogButton(
                                        child: Text(
                                          "Sim",
                                          style: TextStyle(color: Colors.white, fontSize: 20),
                                        ),
                                        onPressed: () {
                                          print("QUANTIDADE: "+questaceita.quantidade_de_participantes.toString());
                                          //Firestore.instance.collection("quests").document(questaceita.titulo).collection("participantes").document(user.firebaseUser.uid).delete();
                                          Firestore.instance.collection("quests").document(questaceita.titulo).updateData({
                                            "aceita" : false,
                                            "quantidade_de_participantes" : questaceita.quantidade_de_participantes - 1,
                                          });

                                          questaceita.questData.aceita=false;
                                          questaceita.status_workflow = 1;
                                          questaceita.quantidade_de_participantes = questaceita.quantidade_de_participantes-1;
                                          QuestAcceptModel.of(context).removeQuest(questaceita);
                                          Navigator.pop(context);
                                        },
                                        width: 120,
                                      ),
                                      DialogButton(
                                        child: Text(
                                          "Não",
                                          style: TextStyle(color: Colors.white, fontSize: 20),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        width: 120,
                                      )
                                    ],
                                  ).show();
                                },
                              ),
                            ),

                          ],
                        ),

                        InkWell(
                          child: BotaoCircular1(
                            fundo: Colors.indigo,
                            texto: Text("Workflow",
                              style: TextStyle(
                                  color: Colors.white),
                            ),
                            corTexto: Colors.white,
                            apertar: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => WorkflowImage(_retornaCaminhoImagem(questaceita.idworkflow))));
                            },
                          ),
                        ),

                        SizedBox(height: 40,),

                        /*
                    AQUI EU PONHO a foto das pessoas que estão participando
                    da quest
                     */
                        Wrap(),



                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );


    }




    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: questaceita.questData == null ?
        FutureBuilder<DocumentSnapshot>(
          future: Firestore.instance.collection("quests")
              .document(questaceita.idQuestCopia).get(),
          builder: (context, snapshot){

            /*
            Se o snapshot tiver dados, eu acesso o método da classe Quests
            e passo ela para o atributo questData dentro de Quest_Accept_Model
             */
            if(snapshot.hasData){
              questaceita.questData = Quests.fromDocument(snapshot.data);
              questaceita.questData.titulo = snapshot.data["titulo_quest"];
              questaceita.questData.descricao = snapshot.data["descricao_quest"];
              questaceita.questData.xp = snapshot.data["xp"];
              questaceita.questData.status_workflow = snapshot.data["status_workflow"];
              questaceita.id = snapshot.data["id_Banco"];

              return _buildContent();
            } else {
              return Container(
                height: 70.0,
                child: CircularProgressIndicator(semanticsLabel: "Carregando...",),
                alignment: Alignment.center,
              );
            }
          }
        ) :
          _buildContent()
    );
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


}
