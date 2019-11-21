import 'dart:io';

import 'package:flutter/material.dart';
import 'package:job_is_a_game_app/UI_User/home_user.dart';
import 'package:job_is_a_game_app/geral_screens/login_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Sair extends StatelessWidget {

  Sair(this.pageControler);
  final PageController pageControler;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(top: 10, left: 40, right: 40),
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  padding: EdgeInsets.all(15),
                  height: 120,
                  width: 120,
                  margin: EdgeInsets.all(15),
                  child: Icon(Icons.airline_seat_individual_suite,
                    color: Colors.indigo,
                    size: 95,
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Text("Descansar", style: TextStyle(
                  fontFamily: 'Helvetica', fontWeight: FontWeight.w500,
                  fontSize: 22, color: Colors.indigo
              ),textAlign: TextAlign.justify),
              SizedBox(height: 50,),
              Text("Lembre-se de retornar em breve para concluir ou aceitar novas missões. Deseja realmente sair da aplicação?", style: TextStyle(
                fontFamily: 'Helvetica', fontWeight: FontWeight.w500,
                fontSize: 16, color: Colors.black45,
              ), textAlign: TextAlign.justify,),
              SizedBox(height: 100,),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: InkWell(
                  child: BotaoCircular1(
                    fundo: Colors.white,
                    texto: Text("Sair",
                      style: TextStyle(
                          color: Colors.red),
                    ),
                    corTexto: Colors.red,
                    apertar: () => exit(0),
                  ),
                ),
              ),


              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: InkWell(
                  child: BotaoCircular1(
                    fundo: Colors.white,
                    texto: Text("Permanecer",
                      style: TextStyle(
                          color: Colors.indigo),
                    ),
                    corTexto: Colors.indigo,
                    apertar: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => HomeUser()));
                    },
                  ),
                ),
              ),

            ],
          ),
        ),
        onWillPop: (){});
  }
}
