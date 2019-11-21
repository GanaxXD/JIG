import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_is_a_game_app/models/user.dart';
import 'package:job_is_a_game_app/widgets/card_reward.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scoped_model/scoped_model.dart';

class RewardClaim2 extends StatefulWidget {

  RewardClaim2(this.pageControler);
  final PageController pageControler;

  @override
  _RewardClaimState2 createState() => _RewardClaimState2(pageControler);
}

class _RewardClaimState2 extends State<RewardClaim2> {

  final PageController pageControler;
  _RewardClaimState2(this.pageControler);

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


                  CardReward(
                      tituloRecompensa: "Teste Card",
                      descrRecompensa: "Este é apenas um teste",
                      regraUsoRecompensa: "Tesstes para o app",
                      mensagemLvInsuficiente: "Sem  level requerido",
                      idUserFirebase: model.firebaseUser.uid,
                      xpCusto: 10,
                      lvRequerido: 1,
                      lvUsuario: model.userData["level"],
                      xpTotaldoUsuario: model.userData["xp"],
                      //user: model,

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
