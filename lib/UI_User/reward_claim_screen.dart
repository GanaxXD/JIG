import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_is_a_game_app/models/user.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scoped_model/scoped_model.dart';

class RewardClaim extends StatefulWidget {

  RewardClaim(this.pageControler);
  final PageController pageControler;

  @override
  _RewardClaimState createState() => _RewardClaimState(pageControler);
}

class _RewardClaimState extends State<RewardClaim> {


  final PageController pageControler;
  _RewardClaimState(this.pageControler);

  @override
  Widget build(BuildContext context) {

    int xp1 = 10,xp2 = 12, xp3 = 15, xp4 = 19, xp5 = 15, xp6 = 17, xp7 = 19, xp8 = 21, xp9=25, xp10=30, xp11=34, xp12=38,
    xp13=41, xp14 = 25;


    return Scaffold(

      body: ScopedModelDescendant<User>(
          builder: (context, child, model){

            return WillPopScope(
              onWillPop: () {},

              child: ListView(


                children: <Widget>[

                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Wrap(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.center,

                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(right: 5), child: Text("Level: ",
                          style: TextStyle(fontFamily: 'helvetica',fontSize: 16, fontWeight: FontWeight.bold),),),
                        Padding(padding: EdgeInsets.only(right: 30), child: Text("${!model.isLoggedIn() ? "0" : model.userData["level"].toString()}",
                          style: TextStyle(fontFamily: 'helvetica',fontSize: 16, fontWeight: FontWeight.normal),),),
                        Text("XP", style: TextStyle(fontFamily: 'helvetica',fontSize: 16, fontWeight: FontWeight.bold),),
                        Padding(padding: EdgeInsets.only(left: 5), child: Text("${!model.isLoggedIn() ? "0" : model.userData["xp"].toString()}"),),
                        Padding(padding: EdgeInsets.only(left: 60), child: Text("Next Lv."),),
                        model.userData["level"] == 0 ?
                        Padding(padding: EdgeInsets.only(left: 10), child: Text("0",
                          //!model.isLoggedIn() ? "0": leveis.data["${model.userData["level"]}"]
                        ),)
                            : Padding(padding: EdgeInsets.only(left: 10), child: Text("${[model.userData["level"]]}",
                          //!model.isLoggedIn() ? "0": leveis.data["${model.userData["level"]}"]
                        ),),
                      ],
                    ),
                  ),

                  SizedBox(height: 30,),
                  Divider(height: 30,),
                  Text("Level 1", style: TextStyle(
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

                                    Text("É necessário questionar antes com o "
                                        "seu chefe imediato se existe possibilidade"
                                        "de usar benefício no dia pretendido por você."
                                        "\n"
                                        "Não poderá ser acumulado com outra recompensa"
                                        "do mesmo nome desta.", style: TextStyle(
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

                                    Text("É necessário questionar antes com o "
                                        "seu chefe imediato se existe possibilidade"
                                        "de usar benefício no dia pretendido por você."
                                        "\n"
                                        "Não poderá ser acumulado com outras recompensas.", style: TextStyle(
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

                                    Text("É necessário questionar antes com o "
                                        "seu chefe imediato se existe possibilidade"
                                        "de usar benefício no dia pretendido por você."
                                        "\n"
                                        "Não poderá ser acumulado com outras recompensas.", style: TextStyle(
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
                                    Text("+ 60 min. de Almoço", style: TextStyle(
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

                                    Text("Preço: ${xp4} de XP", style: TextStyle(
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

                                    Text("É necessário questionar antes com o "
                                        "seu chefe imediato se existe possibilidade"
                                        "de usar benefício no dia pretendido por você."
                                        "\n"
                                        "Não poderá ser acumulado com outras recompensas.", style: TextStyle(
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
                                            if(model.userData["xp"] >= xp4){
                                              Firestore.instance.collection("usuarios").document(model.firebaseUser.uid)
                                                  .updateData({"xp" : model.userData["xp"] = model.userData["xp"] - xp4});
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
                                          Text("Relevar 20 min. de Atraso", style: TextStyle(
                                              color: Colors.black45, fontSize: 20,
                                              fontFamily: 'Helvetica',
                                              fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,),

                                          SizedBox(height: 20,),

                                          Text("Precisa de um desconto no horário de sua "
                                              "chegada? Compre esta recompensa para relevar 20 minutos de "
                                              "atraso em sua chegada em um um dia de trabalho.", style: TextStyle(
                                            color: Colors.black45, fontSize: 16,
                                            fontFamily: 'Helvetica',
                                            fontWeight: FontWeight.normal,),
                                            softWrap: true, maxLines: 10, overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.justify,),

                                          SizedBox(height: 20,),

                                          Text("Preço: ${xp5} de XP", style: TextStyle(
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

                                          Text("É necessário questionar antes com o "
                                              "seu chefe imediato se existe possibilidade"
                                              "de usar benefício no dia pretendido por você."
                                              "\n"
                                              "Não poderá ser acumulado com outras recompensas.", style: TextStyle(
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
                                                onPressed: model.userData["level"] >=2 ? (){
                                                  if(model.userData["xp"] >= xp2){
                                                    Firestore.instance.collection("usuarios").document(model.firebaseUser.uid)
                                                        .updateData({"xp" : model.userData["xp"] = model.userData["xp"] - xp5});
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
                                    Text("Relevar 25 min. de Atraso", style: TextStyle(
                                        color: Colors.black45, fontSize: 20,
                                        fontFamily: 'Helvetica',
                                        fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,),

                                    SizedBox(height: 20,),

                                    Text("Precisa de um desconto no horário de sua "
                                        "chegada? Compre esta recompensa para relevar 25 minutos de "
                                        "atraso em sua chegada em um um dia de trabalho.", style: TextStyle(
                                      color: Colors.black45, fontSize: 16,
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.normal,),
                                      softWrap: true, maxLines: 10, overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.justify,),

                                    SizedBox(height: 20,),

                                    Text("Preço: ${xp6} de XP", style: TextStyle(
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

                                    Text("É necessário questionar antes com o "
                                        "seu chefe imediato se existe possibilidade"
                                        "de usar benefício no dia pretendido por você."
                                        "\n"
                                        "Não poderá ser acumulado com outras recompensas.", style: TextStyle(
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
                                            if(model.userData["xp"] >= xp2){
                                              Firestore.instance.collection("usuarios").document(model.firebaseUser.uid)
                                                  .updateData({"xp" : model.userData["xp"] = model.userData["xp"] - xp6});
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
                                          } : Alert(
                                            context: context,
                                            title: "Level muito baixo!",
                                            desc: "Infelizmente você não possui o Level requerido para realizar a compra"
                                                "da recompensa. Continue realizando suas missões para aumentar seu level.",
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
                                          ).show()
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
                                    Text("Relevar 30 min. de Atraso", style: TextStyle(
                                        color: Colors.black45, fontSize: 20,
                                        fontFamily: 'Helvetica',
                                        fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,),

                                    SizedBox(height: 20,),

                                    Text("Precisa de um desconto no horário de sua "
                                        "chegada? Compre esta recompensa para relevar 30 minutos de "
                                        "atraso em sua chegada em um dia de trabalho.", style: TextStyle(
                                      color: Colors.black45, fontSize: 16,
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.normal,),
                                      softWrap: true, maxLines: 10, overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.justify,),

                                    SizedBox(height: 20,),

                                    Text("Preço: ${xp7} de XP", style: TextStyle(
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

                                    Text("É necessário questionar antes com o "
                                        "seu chefe imediato se existe possibilidade"
                                        "de usar benefício no dia pretendido por você."
                                        "\n"
                                        "Não poderá ser acumulado com outras recompensas.", style: TextStyle(
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
                                          if(model.userData["xp"] >= xp2){
                                            Firestore.instance.collection("usuarios").document(model.firebaseUser.uid)
                                                .updateData({"xp" : model.userData["xp"] = model.userData["xp"] - xp7});
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
                                        } : Alert(
                                          context: context,
                                          title: "Level muito baixo!",
                                          desc: "Infelizmente você não possui o Level requerido para realizar a compra"
                                              "da recompensa. Continue realizando suas missões para aumentar seu level.",
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
                                        ).show()
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
                  Text("Level 3", style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black26, fontFamily: 'Helvetica',
                    fontSize: 30, decoration: TextDecoration.overline,
                  ), textAlign: TextAlign.center,),

                  //XP8 = atraso de 35 min
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
                                    Text("Relevar 35 min. de Atraso", style: TextStyle(
                                        color: Colors.black45, fontSize: 20,
                                        fontFamily: 'Helvetica',
                                        fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,),

                                    SizedBox(height: 20,),

                                    Text("Precisa de um desconto no horário de sua "
                                        "chegada? Compre esta recompensa para relevar 35 minutos de "
                                        "atraso em sua chegada em um um dia de trabalho.", style: TextStyle(
                                      color: Colors.black45, fontSize: 16,
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.normal,),
                                      softWrap: true, maxLines: 10, overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.justify,),

                                    SizedBox(height: 20,),

                                    Text("Preço: ${xp8} de XP", style: TextStyle(
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

                                    Text("É necessário questionar antes com o "
                                        "seu chefe imediato se existe possibilidade"
                                        "de usar benefício no dia pretendido por você."
                                        "\n"
                                        "Não poderá ser acumulado com outras recompensas.", style: TextStyle(
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
                                        onPressed: model.userData["level"] >= 3 ? (){
                                          if(model.userData["xp"] >= xp8){
                                            Firestore.instance.collection("usuarios").document(model.firebaseUser.uid)
                                                .updateData({"xp" : model.userData["xp"] = model.userData["xp"] - xp8});
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
                                        } : Alert(
                                          context: context,
                                          title: "Level muito baixo!",
                                          desc: "Infelizmente você não possui o Level requerido para realizar a compra"
                                              "da recompensa. Continue realizando suas missões para aumentar seu level.",
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
                                        ).show()
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
                                    Text("Relevar 40 min. de Atraso", style: TextStyle(
                                        color: Colors.black45, fontSize: 20,
                                        fontFamily: 'Helvetica',
                                        fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,),

                                    SizedBox(height: 20,),

                                    Text("Precisa de um desconto no horário de sua "
                                        "chegada? Compre esta recompensa para relevar 40 minutos de "
                                        "atraso em sua chegada em um dia de trabalho.", style: TextStyle(
                                      color: Colors.black45, fontSize: 16,
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.normal,),
                                      softWrap: true, maxLines: 10, overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.justify,),

                                    SizedBox(height: 20,),

                                    Text("Preço: ${xp9} de XP", style: TextStyle(
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

                                    Text("É necessário questionar antes com o "
                                        "seu chefe imediato se existe possibilidade"
                                        "de usar benefício no dia pretendido por você."
                                        "\n"
                                        "Não poderá ser acumulado com outras recompensas.", style: TextStyle(
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
                                        onPressed: model.userData["level"] >= 3 ? (){
                                          if(model.userData["xp"] >= xp9){
                                            Firestore.instance.collection("usuarios").document(model.firebaseUser.uid)
                                                .updateData({"xp" : model.userData["xp"] = model.userData["xp"] - xp9});
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
                                        } : Alert(
                                          context: context,
                                          title: "Level muito baixo!",
                                          desc: "Infelizmente você não possui o Level requerido para realizar a compra"
                                              "da recompensa. Continue realizando suas missões para aumentar seu level.",
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
                                        ).show()
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

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Relevar 45 min. de Atraso", style: TextStyle(
                                        color: Colors.black45, fontSize: 20,
                                        fontFamily: 'Helvetica',
                                        fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,),

                                    SizedBox(height: 20,),

                                    Text("Precisa de um desconto no horário de sua "
                                        "chegada? Compre esta recompensa para relevar 45 minutos de "
                                        "atraso em sua chegada em um dia de trabalho.", style: TextStyle(
                                      color: Colors.black45, fontSize: 16,
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.normal,),
                                      softWrap: true, maxLines: 10, overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.justify,),

                                    SizedBox(height: 20,),

                                    Text("Preço: ${xp10} de XP", style: TextStyle(
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

                                    Text("É necessário questionar antes com o "
                                        "seu chefe imediato se existe possibilidade"
                                        "de usar benefício no dia pretendido por você."
                                        "\n"
                                        "Não poderá ser acumulado com outras recompensas.", style: TextStyle(
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
                                        onPressed: model.userData["level"] >= 3 ?(){
                                          if(model.userData["xp"] >= xp10){
                                            Firestore.instance.collection("usuarios").document(model.firebaseUser.uid)
                                                .updateData({"xp" : model.userData["xp"] = model.userData["xp"] - xp10});
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
                                        } : Alert(
                                          context: context,
                                          title: "Level muito baixo!",
                                          desc: "Infelizmente você não possui o Level requerido para realizar a compra"
                                              "da recompensa. Continue realizando suas missões para aumentar seu level.",
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
                                        ).show()
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
                                    Text("Relevar 50 min. de Atraso", style: TextStyle(
                                        color: Colors.black45, fontSize: 20,
                                        fontFamily: 'Helvetica',
                                        fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,),

                                    SizedBox(height: 20,),

                                    Text("Precisa de um desconto no horário de sua "
                                        "chegada? Compre esta recompensa para relevar 50 minutos de "
                                        "atraso em sua chegada em um um dia de trabalho.", style: TextStyle(
                                      color: Colors.black45, fontSize: 16,
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.normal,),
                                      softWrap: true, maxLines: 10, overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.justify,),

                                    SizedBox(height: 20,),

                                    Text("Preço: ${xp11} de XP", style: TextStyle(
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

                                    Text("É necessário questionar antes com o "
                                        "seu chefe imediato se existe possibilidade"
                                        "de usar benefício no dia pretendido por você."
                                        "\n"
                                        "Não poderá ser acumulado com outras recompensas.", style: TextStyle(
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
                                        onPressed: model.userData["level"] >= 3 ? (){
                                          if(model.userData["xp"] >= xp11){
                                            Firestore.instance.collection("usuarios").document(model.firebaseUser.uid)
                                                .updateData({"xp" : model.userData["xp"] = model.userData["xp"] - xp11});
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
                                        }: Alert(
                                          context: context,
                                          title: "Level muito baixo!",
                                          desc: "Infelizmente você não possui o Level requerido para realizar a compra"
                                              "da recompensa. Continue realizando suas missões para aumentar seu level.",
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
                                        ).show()
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
                                    Text("Relevar 55 min. de Atraso", style: TextStyle(
                                        color: Colors.black45, fontSize: 20,
                                        fontFamily: 'Helvetica',
                                        fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,),

                                    SizedBox(height: 20,),

                                    Text("Precisa de um desconto no horário de sua "
                                        "chegada? Compre esta recompensa para relevar 55 minutos de "
                                        "atraso em sua chegada em um dia de trabalho.", style: TextStyle(
                                      color: Colors.black45, fontSize: 16,
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.normal,),
                                      softWrap: true, maxLines: 10, overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.justify,),

                                    SizedBox(height: 20,),

                                    Text("Preço: ${xp12} de XP", style: TextStyle(
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

                                    Text("É necessário questionar antes com o "
                                        "seu chefe imediato se existe possibilidade"
                                        "de usar benefício no dia pretendido por você."
                                        "\n"
                                        "Não poderá ser acumulado com outras recompensas.", style: TextStyle(
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
                                        onPressed: model.userData["level"] >= 3 ? (){
                                          if(model.userData["xp"] >= xp12){
                                            Firestore.instance.collection("usuarios").document(model.firebaseUser.uid)
                                                .updateData({"xp" : model.userData["xp"] = model.userData["xp"] - xp12});
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
                                        } : Alert(
                                          context: context,
                                          title: "Level muito baixo!",
                                          desc: "Infelizmente você não possui o Level requerido para realizar a compra"
                                              "da recompensa. Continue realizando suas missões para aumentar seu level.",
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
                                        ).show()
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
                                    Text("Relevar 60 min. de Atraso", style: TextStyle(
                                        color: Colors.black45, fontSize: 20,
                                        fontFamily: 'Helvetica',
                                        fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,),

                                    SizedBox(height: 20,),

                                    Text("Precisa de um desconto no horário de sua "
                                        "chegada? Compre esta recompensa para relevar 60 minutos de "
                                        "atraso em sua chegada em um dia de trabalho.", style: TextStyle(
                                      color: Colors.black45, fontSize: 16,
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.normal,),
                                      softWrap: true, maxLines: 10, overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.justify,),

                                    SizedBox(height: 20,),

                                    Text("Preço: ${xp13} de XP", style: TextStyle(
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

                                    Text("É necessário questionar antes com o "
                                        "seu chefe imediato se existe possibilidade"
                                        "de usar benefício no dia pretendido por você."
                                        "\n"
                                        "Não poderá ser acumulado com outras recompensas.", style: TextStyle(
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
                                        onPressed: model.userData["level"] >= 3 ? (){
                                          if(model.userData["xp"] >= xp13){
                                            Firestore.instance.collection("usuarios").document(model.firebaseUser.uid)
                                                .updateData({"xp" : model.userData["xp"] = model.userData["xp"] - xp13});
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
                                        }: Alert(
                                          context: context,
                                          title: "Level muito baixo!",
                                          desc: "Infelizmente você não possui o Level requerido para realizar a compra"
                                              "da recompensa. Continue realizando suas missões para aumentar seu level.",
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
                                        ).show()
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
                  Text("Level 4", style: TextStyle(
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
                                    Text("Horas trabalhadas: +30 min.", style: TextStyle(
                                        color: Colors.black45, fontSize: 20,
                                        fontFamily: 'Helvetica',
                                        fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,),

                                    SizedBox(height: 20,),

                                    Text("Precisa sair mais cedo? Adicione 30 minutos"
                                        "de horas trabalhadas em um dia de trabalho."
                                        , style: TextStyle(
                                      color: Colors.black45, fontSize: 16,
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.normal,),
                                      softWrap: true, maxLines: 10, overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.justify,),

                                    SizedBox(height: 20,),

                                    Text("Preço: ${xp14} de XP", style: TextStyle(
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

                                    Text("É necessário questionar antescom o "
                                        "seu chefe imediato se existe possibilidade"
                                        "de usar benefício no dia pretendido por você."
                                        "\n"
                                        "Não poderá ser acumulado com outras recompensas.", style: TextStyle(
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
                                        onPressed: model.userData["level"] >= 4 ? (){
                                          if(model.userData["xp"] >= xp14){
                                            Firestore.instance.collection("usuarios").document(model.firebaseUser.uid)
                                                .updateData({"xp" : model.userData["xp"] = model.userData["xp"] - xp14});
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
                                        } : Alert(
                                          context: context,
                                          title: "Level muito baixo!",
                                          desc: "Infelizmente você não possui o Level requerido para realizar a compra"
                                              "da recompensa. Continue realizando suas missões para aumentar seu level.",
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
                                        ).show()
                                    ),
                                  ],
                                ),

                              ),

                            ],
                          ),

                        ],),

                    ),

                  ),



                ],
              ),


            );

          }
      ),);
  }

  Widget RewardCard(String tituloCard, String descricao, int custoXp){

  }

}
