import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_is_a_game_app/models/quets.dart';
import 'package:job_is_a_game_app/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

class QuestModel extends Model {

  User usuario;
  List<Quests> missoes = [];

  QuestModel(this.usuario);

  static QuestModel of(BuildContext context) => ScopedModel.of<QuestModel>(context);

  //SALVAR MISSÃO
  //Acho que pode ser string o retorno pra enviar uma mensagem a ser exibida em um snackbar
  void addQuestPessoal(Quests quest){
    missoes.add(quest);

    /*
    Guardando quests aceitas pelo usuário, além da concluída.
    O id da quest será dado pelo firebase, logo, preciso fazer
    o .then ao fim do add. Para isso eu pego o id do documento e seto na quest
     */
    Firestore.instance.collection("usuarios")
        .document(usuario.firebaseUser.uid)
        .collection("questsAceitas").add(quest.toMap()).then((doc){
          quest.id = doc.documentID;
    });
    notifyListeners();
  }

  //DELETAR MISSÃO
  void deleteQuest(Quests quest) {
    Firestore.instance.collection("usuarios").document(usuario.firebaseUser.uid)
        .collection("questsAceitas").document(quest.id).delete();

    missoes.remove(quest);
    notifyListeners();
  }

  //DELETAR MISSÃO
  void deleteQuestPorString(String quest) async {

    Firestore.instance.collection("usuarios").document(usuario.firebaseUser.uid)
        .collection("questsAceitas").document(quest).delete();

    missoes.remove(quest);
    notifyListeners();
  }

}