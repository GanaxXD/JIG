import 'package:flutter/material.dart';
import 'package:job_is_a_game_app/models/questAccepts_model.dart';
import 'package:job_is_a_game_app/models/user.dart';
import 'package:job_is_a_game_app/tiles/aceitas_tile.dart';
import 'package:scoped_model/scoped_model.dart';

/*
AULA 164 - criando o carrinho
 */

class QuestAcceptScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          /*appBar: AppBar(
            backgroundColor: Colors.indigo[300],
            title: Text("QUESTS ACEITAS!",
              textAlign: TextAlign.center,
              style: TextStyle( fontFamily: 'Helvetica',),
            ),
        *//*
        Quantidade de quests aceitas
         */
          /*actions: <Widget>[
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
        ],*/
          body: ScopedModelDescendant<QuestAcceptModel>(
              builder: (context, child, model){
                if (model.isLoading && User.of(context).isLoggedIn()){
                  return Center(
                    child: CircularProgressIndicator(
                      semanticsLabel: "Carregando...",
                      backgroundColor: Colors.indigo,
                    ),
                  );
                } else if (model.questesAceitas == null || model.questesAceitas.length ==0 ){
                  return Center(
                    child: Text("Nenhuma quest foi aceita por você.", style: TextStyle(
                        fontFamily: 'Helvetica', fontSize: 14, color: Colors.indigo[400]
                    ),),
                  );
                } else {
                  /*
              AULA 166 - inserindo as quests de forma programada, conforme
              quests aceitas pelo usuário.
               */
                  return ListView(
                    children: <Widget>[
                      Column(
                        children: model.questesAceitas.map((quest){
                          return AceitasTile(quest);
                        }
                        ).toList(),
                      ),
                    ],
                  );
                };
              }
          ),
        ),
        onWillPop: (){}
    );
  }
}
