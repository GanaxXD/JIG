import 'package:flutter/material.dart';
import 'package:job_is_a_game_app/geral_screens/credentials_screen.dart';

class Login extends StatelessWidget {
  Color gradiente1 = Colors.deepPurple[700];
  Color gradiente2 = Colors.purple[500];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.deepPurple.withOpacity(0.1), BlendMode.dstATop),
                  image: AssetImage('assets/img/login_logo.png'),
                  fit: BoxFit.cover
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 220.0),
                  child: Center(
                    child: Image.asset(
                      'assets/img/icone_login_workflow.png', height: 60.0,
                      width: 60.0,),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("J.I.G.", softWrap: true, style: TextStyle(fontWeight: FontWeight.w500,
                          color: Colors.white, fontSize: 50,
                          fontFamily: 'Helvetica'),textAlign: TextAlign.center,),
                      SizedBox(height: 10,),
                      Text("JOB IS A GAME", softWrap: true, style: TextStyle(fontSize: 12.0,
                          color: Colors.white, fontWeight: FontWeight.w300 ,
                          fontFamily: 'Helvetica'),textAlign: TextAlign.center,),
                    ],
                  ),
                ),


                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  margin: EdgeInsets.only(left: 30, right: 30, top: 120),
                  alignment: Alignment.center,

                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: BotaoCircular1(
                          fundo: Colors.white,
                          texto: Text("Login",
                            style: TextStyle(
                                color: Colors.indigo),
                          ),
                          corTexto: Colors.white,
                          apertar: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => Credenciais()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}

class BotaoCircular1 extends StatelessWidget {

  final Color fundo;
  final Text texto;
  final Color corTexto;
  final Function apertar;

  BotaoCircular1({
    this.fundo,
    this.texto,
    this.corTexto,
    this.apertar
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              splashColor: this.fundo,
              color: this.fundo,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: texto,
                  ),
                ],
              ),
              onPressed: apertar,
            ),
          ),
        ],
      ),
    );
  }
}
