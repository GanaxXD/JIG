
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_is_a_game_app/models/quests_accepts.dart';
import 'package:job_is_a_game_app/models/quets.dart';
import 'package:job_is_a_game_app/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

class FinishedModel extends Model{

  User user;
  List<QuestsAccepts> finished = [];
  List<Quests> questes = [];
  bool isLoading =false;


  //********************************
  Quests q;
  //********************************

  QuestsAccepts idQuestAceita;



  FinishedModel(this.user){
    if(user.isLoggedIn())
      _loadMissions();
  }

  static FinishedModel of(BuildContext context) =>
      ScopedModel.of<FinishedModel>(context);

  void addQuest(QuestsAccepts quest){
    finished.add(quest);

    /*
    Irei criar aqui uma coleção dentro do user, que irá conter
    as quests aceitas
     */
    Firestore.instance.collection("usuarios").document(user.firebaseUser.uid)
        .collection("questsConcluidas").add(quest.toMap(user.firebaseUser.uid)).then((doc){
      quest.idQuestsAceitas = doc.documentID;
    });

    notifyListeners();

  }

  void removeQuest(QuestsAccepts quest){
    Firestore.instance.collection("usuarios").document(user.firebaseUser.uid)
        .collection("questsConcluidas").document(quest.idQuestsAceitas).delete();

    finished.remove(quest);
    notifyListeners();
  }

  //RECUPERANDO DADOS Das missões
  void _loadMissions() async{
    QuerySnapshot query = await Firestore.instance.collection("usuarios").document(user.firebaseUser.uid)
        .collection("questsConcluidas").getDocuments();

    finished = query.documents.map((doc) => QuestsAccepts.fromDocument(doc)).toList();

    notifyListeners();
  }

  void loadMissionsExtern() async{
    QuerySnapshot query = await Firestore.instance.collection("usuarios").document(user.firebaseUser.uid)
        .collection("questsConcluidas").getDocuments();

    questes = query.documents.map((doc) => Quests.fromDocument(doc)).toList();

    notifyListeners();
  }

}