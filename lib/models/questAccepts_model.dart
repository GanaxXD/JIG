import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_is_a_game_app/models/quests_accepts.dart';
import 'package:job_is_a_game_app/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

/*
Aula 162 - 3:00
 */
//É O CART MODEL
class QuestAcceptModel extends Model{

  User user;
  List<QuestsAccepts> questesAceitas = [];
  bool isLoading =false;

  QuestAcceptModel(this.user){
    if(user.isLoggedIn())
      _loadMissions();
  }

  //AULA 163
  static QuestAcceptModel of(BuildContext context) =>
      ScopedModel.of<QuestAcceptModel>(context);

  void addQuest(QuestsAccepts quest){
    questesAceitas.add(quest);

    /*
    Irei criar aqui uma coleção dentro do user, que irá conter
    as quests aceitas
     */
    Firestore.instance.collection("usuarios").document(user.firebaseUser.uid)
    .collection("questsAceitas").add(quest.toMap()).then((doc){
      quest.idQuestsAceitas = doc.documentID;
    });

    notifyListeners();

  }

  void removeQuest(QuestsAccepts quest){
    Firestore.instance.collection("usuarios").document(user.firebaseUser.uid)
        .collection("questsAceitas").document(quest.idQuestsAceitas).delete();

    questesAceitas.remove(quest);
    notifyListeners();
  }

  //AULA 168 - RECUPERANDO DADOS DO CARRINHO
  //3:40
   void _loadMissions() async{
      QuerySnapshot query = await Firestore.instance.collection("usuarios").document(user.firebaseUser.uid)
          .collection("questsAceitas").getDocuments();

      questesAceitas = query.documents.map((doc) => QuestsAccepts.fromDocument(doc)).toList();

      notifyListeners();
   }

}