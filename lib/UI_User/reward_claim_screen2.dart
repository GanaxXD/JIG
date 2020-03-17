import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_is_a_game_app/models/user.dart';
import 'package:job_is_a_game_app/widgets/card_reward.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RewardClaim2 extends StatelessWidget {

  PageController controller = PageController();
  User model;
  int i;
  Future<int> ii;
  RewardClaim2(this.controller, this.model);
  int xp1 = 10,xp2 = 12, xp3 = 15, xp4 = 19, xp5 = 15, xp6 = 17, xp7 = 19, xp8 = 21, xp9=25, xp10=30, xp11=34, xp12=38,
      xp13=41, xp14 = 28, xp15 = 32, xp16 = 41, xp17 = 50, xp18 = 60;
  String regra = "É necessário questionar antes com o "
      "seu chefe imediato se existe possibilidade"
      "de usar benefício no dia pretendido por você."
      "\n"
      "Não poderá ser acumulado com outras recompensas.\nComprar"
      "uma recompensa não dá direito de reservar a mesma para usar posteriormente, ou seja,"
      "compre a recompensa somente no dia em que você for usá-la.";

  Future<int> recuperaLv(int lv) async {
    DocumentSnapshot pl = await Firestore.instance.collection("lista_Leveis").document("listaLv").get().then((doc) {
      this.xp1 =  doc.data[lv.toString()];
      this.i =  doc.data[lv.toString()];
      this.ii =  doc.data[lv.toString()];
    });
    print("=================AAAA: "+ i.toString());
    print("=================AAAAAAA: "+ xp1.toString());
    return i;
  }

  @override
  Widget build(BuildContext context) {

    int levelUser = model.userData["level"];
    print("==: LEVEL USER: "+levelUser.toString());
    ii = recuperaLv(levelUser);

    return Scaffold(
      body: WillPopScope(
          child: ListView(
            children: <Widget>[
              //CABEÇALHO
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Wrap(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Text("Level: ",
                              style: TextStyle(
                                  fontFamily: 'helvetica',
                                  fontSize: 16,
                                  fontWeight: FontWeight
                                      .bold),),),
                          Padding(
                            padding: EdgeInsets.only(right: 30),
                            child: Text("${!model.isLoggedIn()
                                ? "0"
                                : model.userData["level"]
                                .toString()}",
                              style: TextStyle(
                                  fontFamily: 'helvetica',
                                  fontSize: 16,
                                  fontWeight: FontWeight
                                      .normal),),),
                          Text("XP", style: TextStyle(
                              fontFamily: 'helvetica',
                              fontSize: 16,
                              fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text("${!model.isLoggedIn()
                                ? "0"
                                : model.userData["xp"]
                                .toString()}"),),
                          Padding(
                            padding: EdgeInsets.only(left: 40),
                            child: Text("Next Lv. "),),
                          model.userData["level"] == 0 ?
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text("15"),
                          )
                              : i == null ? Container(
                            child: Padding (
                              padding: EdgeInsets.only(left: 10),
                              child: Text("Carregando dados...",),
                            ),
                          )
                              :Container(
                            child: Padding (
                              padding: EdgeInsets.only(left: 10),
                              child: Text("${i.toString()}",),
                            ),
                          ),

                        ],
                      ),
                      //},
                      //),
                    ],
                  ),
                ),
              ),

              Text("Level 1", style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black26, fontFamily: 'Helvetica',
                fontSize: 30, decoration: TextDecoration.overline,
              ), textAlign: TextAlign.center,),
              Divider(height: 30,),

              Card(
                shape: Border.all(
                  color: Colors.indigo, width: 2, style: BorderStyle.solid,
                ),

                child: Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Wrap(
                        alignment: WrapAlignment.center,
                        children: <Widget>[
                          //Imagem
                          Container(
                            //Criando o círculo no cantainer com medidas iguais pra não ficar achatado
                            width: 90.0,
                            height: 90.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage('assets/img/guerreiro.jpg'),
                                //fit: BoxFit.fill,
                              ),
                            ),
                          ),

                          Padding(padding: EdgeInsets.only(left: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text("+ 30 min. de Almoço", style: TextStyle(
                                    color: Colors.black45, fontSize: 20,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,),

                                SizedBox(height: 20,),

                                Text("Cumpra missões para desfrutar \nde um dia  com "
                                    "o acréscimo de \nmeia hora no tempo total de \nalmoço.", style: TextStyle(
                                  color: Colors.black45, fontSize: 16,
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.normal,),
                                  softWrap: true, maxLines: 10, overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.justify,),

                                SizedBox(height: 20,),

                                Text("Preço: ${xp1} de XP", style: TextStyle(
                                  color: Colors.black45, fontSize: 16,
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.normal,),
                                  softWrap: true, maxLines: 10, overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.justify,),

                                SizedBox(height: 30,),

                                Text("Regra: ", style: TextStyle(
                                    color: Colors.black45, fontSize: 16,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.justify,),

                                SizedBox(height: 10,),

                                Text(regra, style: TextStyle(
                                    color: Colors.black45, fontSize: 16,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.normal),
                                  textAlign: TextAlign.justify,),

                                SizedBox(height: 30,),


                                RaisedButton(
                                  shape: Border.all(color: Colors.indigo, width: 1.5, style: BorderStyle.solid),
                                  child: Text("Clamar Recompensa", textAlign: TextAlign.center,style: TextStyle(
                                      color: Colors.indigo, fontWeight: FontWeight.bold, fontFamily: 'Helvetica',
                                      fontSize: 15
                                  ),),
                                  onPressed: model.userData["level"] >= 1 ? (){
                                    if(model.userData["xp"] >= xp1){
                                      //model.userData["xp"] = model.userData["xp"] - xp1;
                                      Firestore.instance.collection("usuarios").document(model.firebaseUser.uid)
                                          .updateData({"xp" : model.userData["xp"] = model.userData["xp"] - xp1});
                                      return Alert(
                                        context: context,
                                        title: "Recompensa clamada!",
                                        desc: "Parabéns pela recompensa clamada. Aproveite.",
                                        image: Image.asset('assets/img/trofeu.png', fit: BoxFit.fill,),
                                        buttons: [
                                          DialogButton(
                                            child: Text(
                                              "Fechar",
                                              style: TextStyle(color: Colors.white, fontSize: 20,
                                                  fontFamily: 'Helvetica'),
                                            ),
                                            onPressed: () => Navigator.pop(context),
                                            color: Colors.indigo[400],
                                          ),
                                        ],
                                      ).show();
                                    } else {
                                      return Alert(
                                        context: context,
                                        title: "Experiência Insuficiente!",
                                        desc: "Infelizmente você não possui XP suficiente para realizar a compra"
                                            "da recompensa. Continue realizando suas missões para conseguir comprar"
                                            "recompensas.",
                                        image: Image.asset('assets/img/banimento.png', fit: BoxFit.fill,),
                                        buttons: [
                                          DialogButton(
                                            child: Text(
                                              "Fechar",
                                              style: TextStyle(color: Colors.white, fontSize: 20,
                                                  fontFamily: 'Helvetica'),
                                            ),
                                            onPressed: () => Navigator.pop(context),
                                            color: Colors.indigo[400],
                                          ),
                                        ],
                                      ).show();
                                    }
                                  } : null,
                                ),
                              ],
                            ),

                          ),

                        ],
                      ),

                    ],),

                ),

              ),


              Card(
                shape: Border.all(
                  color: Colors.indigo, width: 2, style: BorderStyle.solid,
                ),

                child: Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Wrap(
                        alignment: WrapAlignment.center,
                        children: <Widget>[
                          //Imagem
                          Container(
                            //Criando o círculo no cantainer com medidas iguais pra não ficar achatado
                            width: 90.0,
                            height: 90.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage('assets/img/guerreiro.jpg'),
                                //fit: BoxFit.fill,
                              ),
                            ),
                          ),

                          Padding(padding: EdgeInsets.only(left: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text("+ 40 min. de Almoço", style: TextStyle(
                                    color: Colors.black45, fontSize: 20,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,),

                                SizedBox(height: 20,),

                                Text("Cumpra missões para desfrutar de um dia  com "
                                    "o acréscimo de quarenta minutos no tempo total de almoço.", style: TextStyle(
                                  color: Colors.black45, fontSize: 16,
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.normal,),
                                  softWrap: true, maxLines: 10, overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.justify,),

                                SizedBox(height: 20,),

                                Text("Preço: ${xp2} de XP", style: TextStyle(
                                  color: Colors.black45, fontSize: 16,
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.normal,),
                                  softWrap: true, maxLines: 10, overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.justify,),

                                SizedBox(height: 30,),

                                Text("Regra: ", style: TextStyle(
                                    color: Colors.black45, fontSize: 16,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.justify,),

                                SizedBox(height: 10,),

                                Text(regra, style: TextStyle(
                                    color: Colors.black45, fontSize: 16,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.normal),
                                  textAlign: TextAlign.justify,),

                                SizedBox(height: 30,),


                                InkWell(
                                  child: RaisedButton(
                                      shape: Border.all(color: Colors.indigo, width: 1.5, style: BorderStyle.solid),
                                      child: Text("Clamar Recompensa", textAlign: TextAlign.center,style: TextStyle(
                                          color: Colors.indigo, fontWeight: FontWeight.bold, fontFamily: 'Helvetica',
                                          fontSize: 15
                                      ),),
                                      onPressed: model.userData["level"] >= 1 ? (){
                                        if(model.userData["xp"] >= xp2){
                                          Firestore.instance.collection("usuarios").document(model.firebaseUser.uid)
                                              .updateData({"xp" : model.userData["xp"] = model.userData["xp"] - xp2});
                                          return Alert(
                                            context: context,
                                            title: "Recompensa clamada!",
                                            desc: "Parabéns pela recompensa clamada. Aproveite.",
                                            image: Image.asset('assets/img/trofeu.png', fit: BoxFit.fill,),
                                            buttons: [
                                              DialogButton(
                                                child: Text(
                                                  "Fechar",
                                                  style: TextStyle(color: Colors.white, fontSize: 20,
                                                      fontFamily: 'Helvetica'),
                                                ),
                                                onPressed: () => Navigator.pop(context),
                                                color: Colors.indigo[400],
                                              ),
                                            ],
                                          ).show();
                                        } else {
                                          return Alert(
                                            context: context,
                                            title: "Experiência Insuficiente!",
                                            desc: "Infelizmente você não possui XP suficiente para realizar a compra"
                                                "da recompensa. Continue realizando suas missões para conseguir comprar"
                                                "recompensas.",
                                            image: Image.asset('assets/img/banimento.png', fit: BoxFit.fill,),
                                            buttons: [
                                              DialogButton(
                                                child: Text(
                                                  "Fechar",
                                                  style: TextStyle(color: Colors.white, fontSize: 20,
                                                      fontFamily: 'Helvetica'),
                                                ),
                                                onPressed: () => Navigator.pop(context),
                                                color: Colors.indigo[400],
                                              ),
                                            ],
                                          ).show();
                                        }
                                      } : null
                                  ),
                                ),
                              ],
                            ),

                          ),

                        ],
                      ),

                    ],),

                ),

              ),

              SizedBox(height: 30,),
              Divider(height: 30,),
              Text("Level 2", style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black26, fontFamily: 'Helvetica',
                fontSize: 30, decoration: TextDecoration.overline,
              ), textAlign: TextAlign.center,),


              Card(
                shape: Border.all(
                  color: Colors.indigo, width: 2, style: BorderStyle.solid,
                ),

                child: Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Wrap(
                        alignment: WrapAlignment.center,
                        children: <Widget>[
                          //Imagem
                          Container(
                            //Criando o círculo no cantainer com medidas iguais pra não ficar achatado
                            width: 90.0,
                            height: 90.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage('assets/img/guerreiro.jpg'),
                                //fit: BoxFit.fill,
                              ),
                            ),
                          ),

                          Padding(padding: EdgeInsets.only(left: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text("+ 50 min. de Almoço", style: TextStyle(
                                    color: Colors.black45, fontSize: 20,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,),

                                SizedBox(height: 20,),

                                Text("Cumpra missões para desfrutar de um dia  com "
                                    "o acréscimo de cinquenta minutos no tempo total de almoço.", style: TextStyle(
                                  color: Colors.black45, fontSize: 16,
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.normal,),
                                  softWrap: true, maxLines: 10, overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.justify,),

                                SizedBox(height: 20,),

                                Text("Preço: ${xp3} de XP", style: TextStyle(
                                  color: Colors.black45, fontSize: 16,
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.normal,),
                                  softWrap: true, maxLines: 10, overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.justify,),

                                SizedBox(height: 30,),

                                Text("Regra: ", style: TextStyle(
                                    color: Colors.black45, fontSize: 16,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.justify,),

                                SizedBox(height: 10,),

                                Text(regra, style: TextStyle(
                                    color: Colors.black45, fontSize: 16,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.normal),
                                  textAlign: TextAlign.justify,),

                                SizedBox(height: 30,),


                                InkWell(
                                  child: RaisedButton(
                                      shape: Border.all(color: Colors.indigo, width: 1.5, style: BorderStyle.solid),
                                      child: Text("Clamar Recompensa", textAlign: TextAlign.center,style: TextStyle(
                                          color: Colors.indigo, fontWeight: FontWeight.bold, fontFamily: 'Helvetica',
                                          fontSize: 15
                                      ),),
                                      onPressed: model.userData["level"] >= 2 ? (){
                                        if(model.userData["xp"] >= xp3){
                                          Firestore.instance.collection("usuarios").document(model.firebaseUser.uid)
                                              .updateData({"xp" : model.userData["xp"] = model.userData["xp"] - xp3});
                                          return Alert(
                                            context: context,
                                            title: "Recompensa clamada!",
                                            desc: "Parabéns pela recompensa clamada. Aproveite.",
                                            image: Image.asset('assets/img/trofeu.png', fit: BoxFit.fill,),
                                            buttons: [
                                              DialogButton(
                                                child: Text(
                                                  "Fechar",
                                                  style: TextStyle(color: Colors.white, fontSize: 20,
                                                      fontFamily: 'Helvetica'),
                                                ),
                                                onPressed: () => Navigator.pop(context),
                                                color: Colors.indigo[400],
                                              ),
                                            ],
                                          ).show();
                                        } else {
                                          return Alert(
                                            context: context,
                                            title: "Experiência Insuficiente!",
                                            desc: "Infelizmente você não possui XP suficiente para realizar a compra"
                                                "da recompensa. Continue realizando suas missões para conseguir comprar"
                                                "recompensas.",
                                            image: Image.asset('assets/img/banimento.png', fit: BoxFit.fill,),
                                            buttons: [
                                              DialogButton(
                                                child: Text(
                                                  "Fechar",
                                                  style: TextStyle(color: Colors.white, fontSize: 20,
                                                      fontFamily: 'Helvetica'),
                                                ),
                                                onPressed: () => Navigator.pop(context),
                                                color: Colors.indigo[400],
                                              ),
                                            ],
                                          ).show();
                                        }
                                      } : (){}
                                  ),
                                ),
                              ],
                            ),

                          ),

                        ],
                      ),

                    ],),
                ),

              ),

              CardReward(
                  tituloRecompensa: "+ 60 min. de Almoço",
                  descrRecompensa: "Cumpra missões para desfrutar de um dia  com "
                      "o acréscimo de cinquenta minutos no tempo total de almoço.",
                  regraUsoRecompensa: "É necessário questionar antes com o "
                      "seu chefe imediato se existe possibilidade"
                      "de usar benefício no dia pretendido por você."
                      "\n"
                      "Não poderá ser acumulado com outras recompensas.",
                  mensagemLvInsuficiente: "Level insuficiente",
                  idUserFirebase: model.firebaseUser.uid, xpCusto: xp4, lvRequerido: 2,
                  lvUsuario: model.userData["level"], xpTotaldoUsuario: model.userData["xp"]
              ),

              SizedBox(height: 30,),
              Divider(height: 30,),
              Text("Level 3", style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black26, fontFamily: 'Helvetica',
                fontSize: 30, decoration: TextDecoration.overline,
              ), textAlign: TextAlign.center,),

              CardReward(
                  tituloRecompensa: "Relevar 20 min. de Atraso",
                  descrRecompensa: "Precisa de um desconto no horário de sua "
                      "chegada? Compre esta recompensa para relevar 20 minutos de "
                      "atraso em sua chegada em um um dia de trabalho.",
                  regraUsoRecompensa: regra,
                  mensagemLvInsuficiente: "Level insuficiente",
                  idUserFirebase: model.firebaseUser.uid, xpCusto: xp5, lvRequerido: 3,
                  lvUsuario: model.userData["level"], xpTotaldoUsuario: model.userData["xp"]
              ),

              CardReward(
                  tituloRecompensa: "Relevar 30 min. de Atraso",
                  descrRecompensa: "Precisa de um desconto no horário de sua "
                      "chegada? Compre esta recompensa para relevar 20 minutos de "
                      "atraso em sua chegada em um um dia de trabalho.",
                  regraUsoRecompensa: regra,
                  mensagemLvInsuficiente: "Level insuficiente",
                  idUserFirebase: model.firebaseUser.uid, xpCusto: xp7, lvRequerido: 3,
                  lvUsuario: model.userData["level"], xpTotaldoUsuario: model.userData["xp"]
              ),

              SizedBox(height: 30,),
              Divider(height: 30,),
              Text("Level 4", style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black26, fontFamily: 'Helvetica',
                fontSize: 30, decoration: TextDecoration.overline,
              ), textAlign: TextAlign.center,),

              CardReward(
                  tituloRecompensa: "Relevar 40 min. de Atraso",
                  descrRecompensa: "Precisa de um desconto no horário de sua "
                      "chegada? Compre esta recompensa para relevar 40 minutos de "
                      "atraso em sua chegada em um dia de trabalho.",
                  regraUsoRecompensa: regra,
                  mensagemLvInsuficiente: "Level insuficiente",
                  idUserFirebase: model.firebaseUser.uid, xpCusto: xp9, lvRequerido: 4,
                  lvUsuario: model.userData["level"], xpTotaldoUsuario: model.userData["xp"]
              ),

              CardReward(
                  tituloRecompensa: "Relevar 50 min. de Atraso",
                  descrRecompensa: "Precisa de um desconto no horário de sua "
                      "chegada? Compre esta recompensa para relevar 50 minutos de "
                      "atraso em sua chegada em um dia de trabalho.",
                  regraUsoRecompensa: regra,
                  mensagemLvInsuficiente: "Level insuficiente",
                  idUserFirebase: model.firebaseUser.uid, xpCusto: xp11, lvRequerido: 4,
                  lvUsuario: model.userData["level"], xpTotaldoUsuario: model.userData["xp"]
              ),

              SizedBox(height: 30,),
              Divider(height: 30,),
              Text("Level 5", style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black26, fontFamily: 'Helvetica',
                fontSize: 30, decoration: TextDecoration.overline,
              ), textAlign: TextAlign.center,),

              CardReward(
                  tituloRecompensa: "Horas trabalhadas: +30 min.",
                  descrRecompensa: "Precisa sair mais cedo? Adicione 30 minutos"
                      "de horas trabalhadas em um dia de trabalho.",
                  regraUsoRecompensa: regra,
                  mensagemLvInsuficiente: "Level insuficiente",
                  idUserFirebase: model.firebaseUser.uid, xpCusto: xp14, lvRequerido: 5,
                  lvUsuario: model.userData["level"], xpTotaldoUsuario: model.userData["xp"]
              ),

              CardReward(
                  tituloRecompensa: "Horas trabalhadas: +40 min.",
                  descrRecompensa: "Precisa sair mais cedo? Adicione 40 minutos"
                      "de horas trabalhadas em um dia de trabalho.",
                  regraUsoRecompensa: regra,
                  mensagemLvInsuficiente: "Level insuficiente",
                  idUserFirebase: model.firebaseUser.uid, xpCusto: xp15, lvRequerido: 5,
                  lvUsuario: model.userData["level"], xpTotaldoUsuario: model.userData["xp"]
              ),

              SizedBox(height: 30,),
              Divider(height: 30,),
              Text("Level 6", style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black26, fontFamily: 'Helvetica',
                fontSize: 30, decoration: TextDecoration.overline,
              ), textAlign: TextAlign.center,),

              CardReward(
                  tituloRecompensa: "Horas trabalhadas: +50 min.",
                  descrRecompensa: "Precisa sair mais cedo? Adicione 50 minutos"
                      "de horas trabalhadas em um dia de trabalho.",
                  regraUsoRecompensa: regra,
                  mensagemLvInsuficiente: "Level insuficiente",
                  idUserFirebase: model.firebaseUser.uid, xpCusto: xp16, lvRequerido: 6,
                  lvUsuario: model.userData["level"], xpTotaldoUsuario: model.userData["xp"]
              ),

              CardReward(
                  tituloRecompensa: "Horas trabalhadas: +60 min.",
                  descrRecompensa: "Precisa sair mais cedo? Adicione 60 minutos"
                      "de horas trabalhadas em um dia de trabalho.",
                  regraUsoRecompensa: regra,
                  mensagemLvInsuficiente: "Level insuficiente",
                  idUserFirebase: model.firebaseUser.uid, xpCusto: xp17, lvRequerido: 6,
                  lvUsuario: model.userData["level"], xpTotaldoUsuario: model.userData["xp"]
              ),

              SizedBox(height: 30,),
              Divider(height: 30,),
              Text("Level 7", style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black26, fontFamily: 'Helvetica',
                fontSize: 30, decoration: TextDecoration.overline,
              ), textAlign: TextAlign.center,),

              CardReward(
                  tituloRecompensa: "Folga Merecida",
                  descrRecompensa: "Precisa resolver uma missão dada por outro oráculo? Sem problemas."
                      "Receba um dia de folga com essa recompensa.",
                  regraUsoRecompensa: regra,
                  mensagemLvInsuficiente: "Level insuficiente",
                  idUserFirebase: model.firebaseUser.uid, xpCusto: xp18, lvRequerido: 7,
                  lvUsuario: model.userData["level"], xpTotaldoUsuario: model.userData["xp"]
              ),

              SizedBox(height: 30,),
              Divider(height: 30,),
              Text("Level 8", style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black26, fontFamily: 'Helvetica',
                fontSize: 30, decoration: TextDecoration.overline,
              ), textAlign: TextAlign.center,),

              Text("Em breve.", style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black38, fontFamily: 'Helvetica',
                fontSize: 18, decoration: TextDecoration.overline,
              ), textAlign: TextAlign.center,),

            ],
          ),
          onWillPop: null),
    );
  }
}
