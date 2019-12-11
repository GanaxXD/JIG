import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  AceitasTile(this.questaceita);
  //EU quem inseri isso, na aula 166 ele não faz,
  // Preciso disso pra acessa a colecao de quests aceitas
  // do usuário
  User user;


/*
AULA 166 - CRIANDO CARD DOS PRODUTOS PROGRAMATICAMENTE
 */
  @override
  Widget build(BuildContext context) {
    /*
    AULA 167
     */
    Widget _buildContent(){
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            //NA AULA ELE POE 120
            width: 90,
            //NA imagem posso tentar por uma minhatra do workflow. Ele usa um NetworkImage (AULA 167 - 0:57)
            child: Image.asset('assets/img/guerreiro.png', fit: BoxFit.cover,),
            padding: EdgeInsets.all(8.0),
          ),
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
                    WorkFlowStatus(questaceita.idQuestCopia, user),





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
                                type: AlertType.error,
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
                                      questaceita.questData.aceita=false;
                                      QuestAcceptModel.of(context).removeQuest(questaceita);
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

                    Row(
                      //Espaçamento igual entre os widets da linha
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[

                        Container(
                          width: 70,
                          alignment: Alignment.center,
                          child: InkWell(
                            child: BotaoCircular1(
                              fundo: Colors.white,
                              texto: Text("Workflow",
                                style: TextStyle(
                                    color: Colors.indigo),
                              ),
                              corTexto: Colors.indigo,
                              apertar: () {

                              },
                            ),
                          ),
                        ),

                        Container(
                          width: 70,
                          alignment: Alignment.center,
                          child: InkWell(
                            child: BotaoCircular1(
                              fundo: Colors.white,
                              texto: Text("Documentos",
                                style: TextStyle(
                                    color: Colors.indigo),
                              ),
                              corTexto: Colors.indigo,
                              apertar: () {

                              },
                            ),
                          ),
                        ),

                      ],
                    ),

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
            AULA 166 - 6:00 a 7:00 aproximadamente
            Se o snapshot tiver dados, eu acesso o método da classe Quests
            e passo ela para o atributo questData dentro de Quest_Accept_Model
             */
            if(snapshot.hasData){
              print("==================: "+snapshot.data["titulo_quest"]);
              questaceita.questData = Quests.fromDocument(snapshot.data);
              questaceita.questData.titulo = snapshot.data["titulo_quest"];
              questaceita.questData.descricao = snapshot.data["descricao_quest"];
              questaceita.questData.xp = snapshot.data["xp"];
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
}
