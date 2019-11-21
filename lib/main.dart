import 'package:flutter/material.dart';
import 'package:job_is_a_game_app/geral_screens/login_screen.dart';
import 'package:job_is_a_game_app/models/questAccepts_model.dart';
import 'package:job_is_a_game_app/models/quest_model.dart';
import 'package:job_is_a_game_app/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

void main(){
  
//  DocumentSnapshot snapshot2 = await Firestore.instance.collection("quests").document().get();
//  Stream<QuerySnapshot> snapshot = await Firestore.instance.collection("quests").snapshots();
//  print(snapshot.first);
  
  runApp(new MyHome());
}//=> runApp(new MyHome());

class MyHome extends StatelessWidget {

  //Conexão testada e funcionando com o Firebase
  //Firestore.instance.collection("teste").document("TESTE").setData({"teste" : "testando 123"});

  @override
  Widget build(BuildContext context) {
    //AULA 154 - ScopedModel pegara o model usuário e todos os estados dele (está logado,
    // dados das quests, etc), estarão disponíveis em todas as telas do app
    return ScopedModel<User>(
      //Defino o model: neste caso, o usuário
      model: User(),
      //AULA 162 - 4:02: toda vez que eu mudar de user, as quests aceitas vão mudar
      child: ScopedModelDescendant<User>(
          builder: (context, child, model){
            return ScopedModel<QuestAcceptModel>(
              model: QuestAcceptModel(model),
              child: MaterialApp(
                title: "Job is a Game",
                home: Login(),
                debugShowCheckedModeBanner: false,
              ),
            );
          }
      ),
    );
  }
}

