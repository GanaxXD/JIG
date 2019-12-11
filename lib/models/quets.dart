import 'package:cloud_firestore/cloud_firestore.dart';

class Quests {

  //AULA 116(gravar dados) e 117(ler dados):
  //NOTA: COLEÇÃO -> DOCUMENTO: PODE SER CRIADO EM VÁRIOS NÍVEIS NO FIREBASE: EX:
  //Firestore.instance.collection("nomedacolecao").document("nomedodocumento").collection("nomedacolecao").document("nomedodocumento").collection("nomedacolecao").document("nomedodocumento")...


  //Escrever dados no Firebase:
  //nota: SE EU NÃO DER O NOME DO DOCUMENTO, ELE GERA UM NOME ALEATÓRIO E ÚNICO PARA O DOCUMENTO, JÁ QUE O NOME DO DOCUMENTO NÃO IMPORTA, MAS SIM O CONTEÚDO DO DOCUMENT
  //Firestore.instance.collection("nomedacolecao").document().setData({"Mapa com valores pra passar, OU SEJA: "NOME_DO_CAMPO_NO_FIREBASE": "VALOR", "NOME_DO_CAMPO_NO_FIREBASE": "VALOR"...});

  //Ler dados no Firebase:
  //LER SOMENTE UMA VEZ - na classe onde est+a sendo lido precisa do async -
  //DocumentSnapshot nomedaVariavel  = await Firestore.instance.collection("nomedacolecao").document("nomedodocumento").get(); //Esse documento tras um Future<Snapshot>, ou seja, ele só lê uma vez;
  //nomedaVariavel.data
  // Nao sabendo o nome do documento, passo ele pra uma vari+avel e depois leio o documento - String nomeDocumento  = snapshot.DocumentID

  // PARA PEGAR TODOS OS DOCUMENTOS_so uma vez
  // QuerySnapshot nomevariavel  = await Firestore.instance.collection("nomedacolecao").getDocuments()
  //

  // LER SEMPRE QUE HOUVER ATUALIZAÇAO NO BANCO - FICA LENDO O TEMPO t ODO
  //Firestore.instance.collection("nomedacolecao").document().snapshots().listen(ponha uma funçºao aqui que voce queira que ele faca);
  //Firestore.instance.collection("nomedacolecao").document().snapshots().listen((snapshot){
  //  for(DocumentSnapshot doc in snapshot.documents
  //        print(doc.data);
  // )
  // });


  String id; //vai ser o documento em que a quest esta
  List <int> guerreiros = List();
  String titulo, descricao;
  DateTime dataInicio, dataFim;
  int idworkflow, xp, idBanco;
  bool concluida;
  bool aceita = false;


  Quests();
  Quests.preenchido(this.id, this.guerreiros, this.titulo, this.descricao,
      this.dataInicio, this.dataFim, this.idworkflow, this.xp, this.concluida, this.aceita);

  //AULA 147 (8:27)
  /*Quests.fromDocument(DocumentSnapshot snapshot){
    this.id = snapshot.documentID;
    this.titulo = snapshot.data["titulo_quest"];
    this.descricao = snapshot.data["descricao_quest"];
    //As datas estão dando erro porque elas vêm em formato Timestamp do Firebase, e no Flutter elas são do tipo Date.
    //dataInicio = snapshot.data["dtInicio"];
    //dataFim = snapshot.data["dtFim"];
    this.xp = snapshot.data["xp"];
    this.concluida = snapshot.data["concluida"];
    this.aceita = snapshot.data["aceita"];
  }*/

  Quests.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.documentID;
    titulo = snapshot.data["titulo_quest"];
    descricao = snapshot.data["descricao_quest"];
    //As datas estão dando erro porque elas vêm em formato Timestamp do Firebase, e no Flutter elas são do tipo Date.
    //dataInicio = snapshot.data["dtInicio"];
    //dataFim = snapshot.data["dtFim"];
    xp = snapshot.data["xp"];
    concluida = snapshot.data["concluida"];
    aceita = snapshot.data["aceita"];
    idworkflow = snapshot.data["workflow"];
  }

  //Transformando dados do firebase na classe
  //AULA 143
  Quests.fromFirebase(DocumentSnapshot snapshot){
    id = snapshot.documentID;
    titulo = snapshot.data["titulo_quest"];
    descricao = snapshot.data["descricao_quest"];
    dataInicio = snapshot.data["dtInicio"];
    /*dataFim = snapshot.data["dtFim"];
    idworkflow = snapshot.data["id_workflow"];*/
    aceita = snapshot.data["aceita"];
  }

//AULA 162:
  Map<String, dynamic> toMap(){
    return{
      "id": id,
      "titulo_quest": titulo,
      "descricao_quest": descricao,
      //"dtInicio": dataInicio,
      //"dtFim": dataFim,
      "idworkflow": idworkflow,
      "concluida": false,
      "xp": 1,
      "aceita": true,
    };
  }

  /*
  AULA 161 (6:54) Resumo da quest para ser usada na
  classe QuestsAccepts
   */
  Map<String, dynamic> toResumeMap(){
    return{
      "titulo_quest": titulo,
      "descricao_quest": descricao,
      "xp": xp,
      "dtInicio_quest": dataInicio,
      "dtFim_quest" : dataFim,
      "id_quest" : id,
      "id_Banco" : idBanco,
      "id_workflow" : idworkflow,
      "aceita": true,
    };
  }

}
