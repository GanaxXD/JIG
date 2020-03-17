import 'package:flutter/material.dart';
import 'package:job_is_a_game_app/models/questAccepts_model.dart';
import 'package:job_is_a_game_app/models/user.dart';
import 'package:job_is_a_game_app/tiles/aceitas_tile.dart';
import 'package:scoped_model/scoped_model.dart';

/*
AULA 164 - criando o carrinho
 */

class QuestAcceptScreen extends StatelessWidget {

  User user;
  QuestAcceptScreen(this.user);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: ScopedModelDescendant<QuestAcceptModel>(
              builder: (context, child, model){
                if (model.isLoading){
                  return Center(
                    child: CircularProgressIndicator(
                      semanticsLabel: "Carregando...",
                      backgroundColor: Colors.indigo,
                    ),
                  );
                } else if (model.questesAcce == null || model.questesAcce.length ==0 ){
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
                        children: model.questesAcce.map(
                                (quest){
                                   return AceitasTile(quest, this.user);
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
