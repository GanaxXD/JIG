import 'package:flutter/material.dart';
import 'package:job_is_a_game_app/UI_User/finish_quest_screen.dart';
import 'package:job_is_a_game_app/UI_User/home_user.dart';
import 'package:job_is_a_game_app/UI_User/workflow_image.dart';
import 'package:job_is_a_game_app/geral_screens/login_screen.dart';
import 'package:job_is_a_game_app/models/quets.dart';
import 'package:job_is_a_game_app/models/user.dart';

class FinishedScreen extends StatefulWidget {

  final Quests quest;
  FinishedScreen(this.quest, this.model);
  User model;
  //ELE TEM UM CONSTRUTOR QUE RECEBE O PRODUTO. VERIFICAR COMO ELE FEZ ISSO
  @override
  _FinishedScreenState createState() => _FinishedScreenState(quest, model);
}

class _FinishedScreenState extends State<FinishedScreen> {

  final Quests quest;
  User model;
   _FinishedScreenState(this.quest, this.model);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));


  @override
  Widget build(BuildContext context) {
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
               Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch, //Para que tudo ocupe o máximo de espaço possível
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Text("Missão: ${quest.titulo}", style: TextStyle(fontFamily: 'Helvetica',
                      fontWeight: FontWeight.normal, color: Colors.black38, fontSize: 20,),
                      textAlign: TextAlign.justify,),

                    Text("Descrição da Missão: ${quest.descricao}", style: TextStyle(fontFamily: 'Helvetica',
                      fontWeight: FontWeight.normal, color: Colors.black38, fontSize: 18,),
                      textAlign: TextAlign.justify,),

                    SizedBox(height: 20,),

                    Text("Recompensa recebida: ${quest.xp.toString()} de xp", style: TextStyle(fontFamily: 'Helvetica',
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

                    SizedBox(height: 50,),

                    Text("Guerreiros que participaram da conclusão da missão:", style: TextStyle(fontFamily: 'Helvetica',
                      fontWeight: FontWeight.normal, color: Colors.indigoAccent, fontSize: 16,),
                      textAlign: TextAlign.justify,),
                    //Circulos com as imagens dos guerreiros: Uma ideia de organização dos ícones.

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

                    SizedBox(height: 50,),

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
                          apertar: () => Navigator.pop(context),
                        ),
                      ),
                    ),


                  ],
                ),
              ),

            ],
          ),
        ),
        onWillPop: (){},
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


  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.indigo,
      content: Text("Bravo guerreiro, parabéns por ter cncluído suas missões."
          "Para que você veja as possíveis ações toamdas nas soluções das missões,"
          "clique no card.", style: TextStyle(
        color: Colors.white, fontFamily: 'Helvetica',
      ),),
      duration: Duration(seconds: 7),
    ));
  }
}

