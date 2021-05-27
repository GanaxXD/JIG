import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_is_a_game_app/models/quests_accepts.dart';
import 'package:job_is_a_game_app/models/quets.dart';
import 'package:job_is_a_game_app/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

class QuestAcceptModel extends Model{

  User user;
  List<QuestsAccepts> questesAcce = [];
  List<Quests> questes = [];
  bool isLoading =false;


  //********************************
  Quests q;
  //********************************

  QuestsAccepts idQuestAceita;



  QuestAcceptModel(this.user){
    if(user.isLoggedIn())
      _loadMissions();
  }

  static QuestAcceptModel of(BuildContext context) =>
      ScopedModel.of<QuestAcceptModel>(context);

  void addQuest(QuestsAccepts quest){
    questesAcce.add(quest);
    /*
    Irei criar aqui uma coleção dentro do user, que irá conter
    as quests aceitas
     */
    Firestore.instance.collection("usuarios").document(user.firebaseUser.uid)
    .collection("questsAceitas").add(quest.toMap(user.firebaseUser.uid)).then((doc){
      quest.idQuestsAceitas = doc.documentID;
    });

    quest.quantidade_de_participantes = quest.quantidade_de_participantes +1;

    Firestore.instance.collection("quests").document(quest.titulo).setData(
        {
          "participantes" : {
            quest.quantidade_de_participantes.toString() : user.firebaseUser.uid
          },
          "quantidade_de_participantes" : quest.quantidade_de_participantes
        }, merge: true);
    notifyListeners();
  }


  void removeQuest(QuestsAccepts quest){
    Firestore.instance.collection("usuarios").document(user.firebaseUser.uid)
        .collection("questsAceitas").document(quest.idQuestsAceitas).delete();

    questesAcce.remove(quest);
    notifyListeners();
  }

  void _loadMissions() async{
    QuerySnapshot query = await Firestore.instance.collection("usuarios").document(user.firebaseUser.uid)
        .collection("questsAceitas").getDocuments();

    questesAcce = query.documents.map((doc) => QuestsAccepts.fromDocument(doc)).toList();

    notifyListeners();
  }

  void loadMissionsExtern() async{
    QuerySnapshot query = await Firestore.instance.collection("usuarios").document(user.firebaseUser.uid)
        .collection("questsAceitas").getDocuments();

    questes = query.documents.map((doc) => Quests.fromDocument(doc)).toList();

    notifyListeners();
  }

}