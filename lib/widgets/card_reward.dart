import 'package:flutter/material.dart';
import 'package:job_is_a_game_app/models/user.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scoped_model/scoped_model.dart';

class CardReward extends StatelessWidget {

  String tituloRecompensa, descrRecompensa, regraUsoRecompensa,
      mensagemLvInsuficiente, idUserFirebase;
  int xpCusto, lvRequerido, lvUsuario, xpTotaldoUsuario;
  User user;

  CardReward({@required this.tituloRecompensa, @required this.descrRecompensa,
    @required this.regraUsoRecompensa, @required this.mensagemLvInsuficiente, @required this.idUserFirebase,
    @required this.xpCusto, @required this.lvRequerido, @required this.lvUsuario,
    @required this.xpTotaldoUsuario, //@required this.user
  });


  @override
  Widget build(BuildContext context) {

    return ScopedModelDescendant<User>(
        builder: (context, child, model)
    {
      return Card(
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
                      ),
                    ),
                  ),

                  Padding(padding: EdgeInsets.only(left: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(tituloRecompensa, style: TextStyle(
                            color: Colors.black45, fontSize: 20,
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,),

                        SizedBox(height: 20,),

                        Text(descrRecompensa, style: TextStyle(
                          color: Colors.black45, fontSize: 16,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.normal,),
                          softWrap: true,
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,),

                        SizedBox(height: 20,),

                        Text("Preço: $xpCusto de XP", style: TextStyle(
                          color: Colors.black45, fontSize: 16,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.normal,),
                          softWrap: true,
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,),

                        SizedBox(height: 30,),

                        Text("Regra: ", style: TextStyle(
                            color: Colors.black45, fontSize: 16,
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.bold),
                          textAlign: TextAlign.justify,),

                        SizedBox(height: 10,),

                        Text(regraUsoRecompensa, style: TextStyle(
                            color: Colors.black45, fontSize: 16,
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.normal),
                          textAlign: TextAlign.justify,),

                        SizedBox(height: 30,),

                        OutlineButton(
                            color: Colors.white,
                            highlightedBorderColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            child: InkWell(
                              highlightColor: Colors.white,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(child: Text(
                                      "Comprar Recompensa",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.indigo,
                                          fontWeight: FontWeight.bold),),),
                                  ],
                                ),
                              ),
                            ),
                            onPressed: () async {
                              if (lvUsuario < lvRequerido) {
                                Alert(
                                  context: context,
                                  title: "Level Insuficiente!",
                                  desc: "Infelizmente você não possui o level requerido pela "
                                      "recompensa para realizar a compra. Continue realizando "
                                      "suas missões para conseguir comprar esta "
                                      "recompensas.",
                                  image: Image.asset('assets/img/banimento.png',
                                    fit: BoxFit.fill,),
                                  buttons: [
                                    DialogButton(
                                      child: Text(
                                        "Fechar",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20,
                                            fontFamily: 'Helvetica'),
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                      color: Colors.indigo[400],
                                    ),
                                  ],
                                ).show();
                              } else if (xpTotaldoUsuario >= xpCusto) {
                                model.compraMissao(xpTotaldoUsuario, model, xpCusto);
                                model.userData["xp"] = model.userData["xp"] - xpCusto;

                                return Alert(
                                  context: context,
                                  title: "Recompensa clamada!",
                                  desc: "Parabéns pela recompensa clamada. Aproveite.",
                                  image: Image.asset(
                                    'assets/img/trofeu.png', fit: BoxFit.fill,),
                                  buttons: [
                                    DialogButton(
                                      child: Text(
                                        "Fechar",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20,
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
                                  image: Image.asset('assets/img/banimento.png',
                                    fit: BoxFit.fill,),
                                  buttons: [
                                    DialogButton(
                                      child: Text(
                                        "Fechar",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20,
                                            fontFamily: 'Helvetica'),
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                      color: Colors.indigo[400],
                                    ),
                                  ],
                                ).show();
                              }
                            }

                        ),

                      ],
                    ),

                  ),

                ],
              ),

            ],),
        ),

      );
    },
    );
  }
}
