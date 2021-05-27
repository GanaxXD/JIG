/*
o ideal é armazenar o id
das quests porque se elas forem alteradas, não
haverá problemas dos dados da quest estarem congeladas para o
usuário que a aceitar quando modificadas remotamente no banco de
dados.

 */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_is_a_game_app/models/quets.dart';
import 'package:job_is_a_game_app/models/user.dart';

/*
essa classe irá armazenar os dados de uma quest aceita
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
  String descricao, acoesTomadas;
  bool aceita;
  bool concluida = false;
  int id, idworkflow, status_workflow, quantidade_de_participantes;
  List<String> listaUsuariosAceitaram=[];
  Timestamp dataInicio, dataFim;


  //Inserido por mim para usar na quest_aceitas_tile
  User user;


  //Não para o banco de dados, mas só para carregar os dados na tela de quests aceitas
  Quests questData;

  QuestsAccepts();

  //Transforma os dados do banco em uma questAceita
  QuestsAccepts.fromDocument(DocumentSnapshot document){
    idQuestsAceitas = document.documentID;
    //idQuestsAceitas = document.data["titulo_quest"];
    idQuestCopia = document.data["idQuest"];
    titulo = document.data["titulo_quest"];
    descricao = document.data["descricao_quest"];
    aceita = document.data["aceita"];
    idworkflow = document.data["workflow"];
    id = document.data["id_quest"];
    status_workflow = document.data["status_workflow"];
    acoesTomadas = document.data["acoes_tomadas"];
    concluida = document.data["concluida"];
    quantidade_de_participantes = document.data["quantidade_de_participantes"];
    dataInicio = document.data["dtInicio"];
    dataFim = document.data["dtFim"];
  }


  /*
  Adicionando a quest aceita no banco de dados
   */
  Map<String, dynamic> toMap(String user) {
    return {
      "idQuest": idQuestCopia,
      "titulo_quest": titulo,
      "descricao_quest": descricao,
      "aceita": aceita,
      "workflow": idworkflow,
      "id_Banco": id,
      "questDados": questData.toResumeMap(),
      "status_workflow": status_workflow,
      "acoes_tomadas": acoesTomadas,
      "concluida": concluida,
      "quantidade_de_participantes" : quantidade_de_participantes,
      "participantes" : {
        (quantidade_de_participantes+1).toString(): user.toString()
      },
      "dtInicio" : dataInicio,
      "dtFim" : dataFim,


    };
  }

  Map<String, dynamic> toMap2(String userId) {
    return {
      "idQuest": idQuestCopia,
      "titulo_quest": titulo,
      "descricao_quest": descricao,
      "aceita": aceita,
      "workflow": idworkflow,
      "id_Banco": id,
      "questDados": questData.toResumeMap(),
      "status_workflow": status_workflow,
      "acoes_tomadas": acoesTomadas,
      "concluida": concluida,

    };
  }
}