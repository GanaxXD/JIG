import 'package:flutter/material.dart';
import 'package:job_is_a_game_app/UI_User/finish_screen.dart';
import 'package:job_is_a_game_app/models/quets.dart';
import 'package:job_is_a_game_app/models/user.dart';


class FinishedTile extends StatelessWidget {

  final Quests quest;
  BuildContext context;
  User model;
  FinishedTile(this.context, this.quest, this.model);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>FinishedScreen(quest, model))
        );
      },
      child: Card(
        borderOnForeground: true,
        child: Padding(padding: EdgeInsets.only(right: 14.0,),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 15.0),
                color: Colors.green,
                width: 8,
                height: 60,
              ),
              //Imagem
              Container(
                padding: EdgeInsets.only(right: 15.0),
                //Criando o círculo no cantainer com medidas iguais pra não ficar achatado
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/img/trofeu.png'),
                    //fit: BoxFit.fill,
                  ),
                ),
              ),

              Padding(padding: EdgeInsets.only(left: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    quest.titulo.length>20 ? Text(quest.titulo.substring(0,20)+"...",
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: 'Helvetica'),
                    ) : Text (quest.titulo,
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: 'Helvetica'),
                    ),

                    quest.descricao.length>20 ?
                    Text("Missão: ${quest.descricao}".substring(0,40)+"...",
                        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, fontFamily: 'Helvetica')):
                    Text("Missão: ${quest.descricao}", style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, fontFamily: 'Helvetica'),),

                    Text("XP Recebido: ${quest.xp.toString()}",
                      style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.normal, fontFamily: 'Helvetica'),
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

}
