/*
AULA 161: nessa aula ele explica que o ideal é armazenar o id
dos produtos (quests) porque se elas forem alteradas, não
haverá problemas dos dados da quest estarem congeladas para o
usuário que a aceitar quando modificadas remotamente no banco de
dados.

Na aula ele coloca vários outros itens que estou desprezando.
 */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_is_a_game_app/models/quets.dart';
import 'package:job_is_a_game_app/models/user.dart';

/*
AULA 161: essa classe irá armazenar os dados de uma quest aceita
CARTPRODUCT
 */
class QuestsAccepts {
  //Id da dessa quest dentre as quests aceitas. É
  // o CID
  String idQuestsAceitas;

  //Id da quest que eu irei copiar. É o PID
  String idQuestCopia;


  //Esses dados abaixo apenas serão usados para teste, mas lembre que o titulo
  // e a descrição da quest poderá ser modificada, então epois tudo[
  // será ser pego da questData.
  // Dados coletados da quest que não irão mudar
  String titulo;
  String descricao;
  bool aceita;
  int id;



  //Inserido por mim para usar na quest_aceitas_tile
  User user;


  //Não para o banco de dados, mas só para carregar os dados na tela de quests aceitas
  Quests questData;

  QuestsAccepts();
  //Transforma os dados do banco em uma questAceita
  QuestsAccepts.fromDocument(DocumentSnapshot document){
    idQuestsAceitas = document.documentID;
    idQuestCopia = document.data["id_quest"];
    titulo = document.data["titulo_quest"];
    descricao = document.data["descricao_quest"];
    aceita = document.data["aceita"];
    id = document.data["id_quest"];

  }


  /*
  AULA 161: (5:47) Adicionando a quest aceita no banco de dados
   */
  Map<String, dynamic> toMap(){
    return {
      "idQuest": idQuestCopia,
      "titulo_quest": titulo,
      "descricao_quest": descricao,
      "aceita": aceita
      //"usuario": user.firebaseUser.uid,

      //"questResumo": questData.toResumeMap()
    };
  }

}