import 'package:flutter/material.dart';
import 'package:job_is_a_game_app/UI_User/home_user.dart';
import 'package:job_is_a_game_app/geral_screens/cadastro.dart';
import 'package:job_is_a_game_app/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

class Credenciais extends StatefulWidget {
  @override
  _CredenciaisState createState() => _CredenciaisState();
}

class _CredenciaisState extends State<Credenciais> {

  final _emailControle = TextEditingController();
  final _senhaControle = TextEditingController();
  final _scaffoldkey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor:  Colors.indigoAccent,
        title: Text("Informe suas Credenciais", style: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.bold, color: Colors.white),),
      ),

    body: ScopedModelDescendant<User>(
      builder: (context, child, model) {
        if (model.isLoading)
          return Center(child: CircularProgressIndicator(),);
        return SingleChildScrollView(
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.indigo.withOpacity(0.2), BlendMode.dstATop
                  ),
                  image: AssetImage('assets/img/login_logo.png'),
                  fit: BoxFit.cover
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: _emailControle,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      icon: Icon(Icons.assignment_ind),
                      hintText: "E-Mail",
                      labelText: "Digite seu E-Mail",
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: _senhaControle,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      icon: Icon(Icons.keyboard),
                      hintText: "Senha",
                      labelText: "Digite sua Senha",
                    ),
                    obscureText: true,
                  ),
                ),


                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  margin: EdgeInsets.only(left: 30, right: 30, top: 65),
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: OutlineButton(
                          color: Colors.white,
                          highlightedBorderColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          onPressed: () {
                            model.sigIn(
                                email: _emailControle.text,
                                pass: _senhaControle.text,
                                onSuccess: _onSuccess,
                                onFail: _onFail
                            );
//                          Navigator.push(context, MaterialPageRoute(
//                              builder: (context) => HomeUser()));
                          },

                          child: InkWell(
                            highlightColor: Colors.white,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(child: Text(
                                    "Logar", textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.indigo,
                                        fontWeight: FontWeight.bold),),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  margin: EdgeInsets.only(left: 30, right: 30, top: 5),
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: OutlineButton(
                          color: Colors.white,
                          highlightedBorderColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          onPressed: () {
                            Navigator.pop(context);
                          },

                          child: InkWell(
                            highlightColor: Colors.white,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(child: Text(
                                    "Voltar", textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.indigo,
                                        fontWeight: FontWeight.bold),),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 50, top: 20),
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      if(_emailControle.text.isEmpty){
                        _scaffoldkey.currentState.showSnackBar(SnackBar(
                          content: Text("Para recuperar sua senha, digite o e-mail cadastrado.",style: TextStyle(
                            color: Colors.red, fontFamily: 'Helvetica',
                          ),),
                          duration: Duration(seconds: 3),
                        ));
                      } else {
                        model.recoverPass(_emailControle.text);
                        _scaffoldkey.currentState.showSnackBar(SnackBar(
                          content: Text("Confira seu e-mail cadastrado",style: TextStyle(
                            color: Colors.red, fontFamily: 'Helvetica',
                          ),),
                          duration: Duration(seconds: 3),
                        ));
                      }
                    },
                    child: Text("Esqueci minha senha", style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 12,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.normal
                      ),),
                    ),
                  ),
                Divider(height: 40,),
                Divider(color: Colors.blueAccent, height: 35,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Cadastro()));
                  },
                  child: Center(
                    child: Text("NÃO POSSUI UMA CONTA?", style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 12,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                ),

              ],
            ),
          ),
        );
      }
      ),
    );
  }

  void _onSuccess(){
    _scaffoldkey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.white,
      content: Text("Bem vindo Guerreiro!",style: TextStyle(
        color: Colors.indigo, fontFamily: 'Helvetica',
      ),),
      duration: Duration(seconds: 1),
    ));
    Future.delayed(Duration(seconds: 1)).then((_){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => HomeUser()));
    });
  }

  void _onFail(){
    _scaffoldkey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text("Falha ao entrar. Tente novamente e verifique se seus dados informados estão corretos!",style: TextStyle(
        color: Colors.white, fontFamily: 'Helvetica',
      ),),
      duration: Duration(seconds: 3),
    ));
  }
}
