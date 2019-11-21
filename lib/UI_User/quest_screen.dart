import 'package:flutter/material.dart';
import 'package:job_is_a_game_app/UI_User/documents_screen.dart';
import 'package:job_is_a_game_app/UI_User/home_user.dart';
import 'package:job_is_a_game_app/UI_User/workflow_screen.dart';
import 'package:job_is_a_game_app/geral_screens/login_screen.dart';
import 'package:job_is_a_game_app/models/questAccepts_model.dart';
import 'package:job_is_a_game_app/models/quests_accepts.dart';
import 'package:job_is_a_game_app/models/quets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class QuestScreen extends StatefulWidget {

  //AULA 149 (5:40) e 150 :
  final Quests quest;
  QuestScreen(this.quest);
  //NA AULA 150 (TEMPO 0:54'') ELE TEM UM CONSTRUTOR QUE RECEBE O PRODUTO. VERIFICAR COMO ELE FEZ ISSO
  @override
  _QuestScreenState createState() => _QuestScreenState(quest);
}

class _QuestScreenState extends State<QuestScreen> {
  //AULA 149 (6:00) e 150 :
  final Quests quest;
  List<Quests> listaDeMissoesAceitas;
  _QuestScreenState(this.quest);


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
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
                    Text(quest.id, style: TextStyle(fontFamily: 'Helvetica',
                        fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 20),
                      textAlign: TextAlign.center,),

                    Text(quest.titulo, style: TextStyle(fontFamily: 'Helvetica',
                        fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 20),
                      textAlign: TextAlign.center,),

                    Divider(height: 50,),

                    Text(quest.descricao, style: TextStyle(fontFamily: 'Helvetica',
                      fontWeight: FontWeight.normal, color: Colors.black38, fontSize: 18,),
                      textAlign: TextAlign.justify,),

                    Divider(height: 20,),

                    Text("Recompensa: ${quest.xp.toString()} de xp", style: TextStyle(fontFamily: 'Helvetica',
                      fontWeight: FontWeight.normal, color: Colors.black45, fontSize: 16,),
                      textAlign: TextAlign.justify,),
                    SizedBox(height: 20,),

/*
                    Text("Data de Início: ${quest.dataInicio.day.toString()} / ${quest.dataInicio.month.toString()} / ${quest.dataInicio.year.toString()} ", style: TextStyle(fontFamily: 'Helvetica',
                      fontWeight: FontWeight.normal, color: Colors.blueAccent[600], fontSize: 12,),),
                      quest.concluida == true ? Text("Data de Fim: ${quest.dataFim.day.toString()} / ${quest.dataFim.month.toString()} / ${quest.dataFim.year.toString()}", style: TextStyle(fontFamily: 'Helvetica',
                      fontWeight: FontWeight.normal, color: Colors.blueAccent[600], fontSize: 12,),) :
                    Text("Data de Fim: Aguardando...", style: TextStyle(fontFamily: 'Helvetica',
                      fontWeight: FontWeight.normal, color: Colors.blueAccent[600], fontSize: 12,),),
*/



                    Divider(height: 50,),

                    Text("Guerreiros Convocados para a missão:", style: TextStyle(fontFamily: 'Helvetica',
                      fontWeight: FontWeight.normal, color: Colors.indigoAccent, fontSize: 16,),
                      textAlign: TextAlign.justify,),
                    //Circulos com as imagens dos guerreiros: Uma ideia de organização dos ícones está na aula 151, 2:30. Já dos círculos, ver a aula do chat.

                    Divider(height: 50,),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: InkWell(
                              child: BotaoCircular1(
                                fundo: Colors.white,
                                texto: Text("Workflow",
                                  style: TextStyle(
                                      color: Colors.indigo),
                                ),
                                corTexto: Colors.white,
                                apertar: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => Workflow()));
                                },
                              ),
                            ),
                          ),

                          Expanded(child: InkWell(
                            child: BotaoCircular1(
                              fundo: Colors.white,
                              texto: Text("Documentos",
                                style: TextStyle(
                                    color: Colors.indigo),
                              ),
                              corTexto: Colors.white,
                              apertar: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => Documents()));
                              },
                            ),
                          ),),
                        ],
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
                          apertar: () {
                            //AULA 163 () - adicionando a quest na lista de quests aceitas
                            QuestsAccepts aceita = QuestsAccepts();
                            aceita.idQuestCopia = quest.id;
                            aceita.titulo = quest.titulo;
                            aceita.descricao = quest.descricao;
                            aceita.aceita = true;


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


                  ],
                ),
              ),

            ],
          ),
        ),
        onWillPop: (){});
  }
}
