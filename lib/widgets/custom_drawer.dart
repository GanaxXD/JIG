import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:job_is_a_game_app/models/user.dart';
import 'package:job_is_a_game_app/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {

  //AULA 140: DIRECIONANDO A PÁGINA CONFORME ITEM PRESSIONADO E FECHANDO O MENU
  final PageController pageControler;
  CustomDrawer(this.pageControler);


  @override
  Widget build(BuildContext context) {
    //Adicionando um degradê
    Widget _buildDrawerColor() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.indigo,
            ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight
        ),
      ),
    );

    //AULA 138
    return Drawer(
      //Stak porque pretendo por um fundo no drawer
      child: Stack(
        children: <Widget>[
          _buildDrawerColor(),
          ListView(
            padding: EdgeInsets.only(left: 10.0, top: 20.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.fromLTRB(5, 20, 16, 8),
                height: 210.0,
                //Porque eu vou colocar um ícone. Usei esse pra posicionar as coisas
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        top: 10,
                        left: 0,
                        child: Container(
                          height: 50,
                          width: 50,
                          child: Image.asset('assets/img/espada_drawer.png', fit: BoxFit.cover,),
                        ),
                    ),
                    Positioned(
                      top: 20,
                      left: 70,
                      child: Text(
                        "Tenda do Guerreiro", style: TextStyle(
                        fontSize: 22, fontFamily: 'Helvetica', fontWeight: FontWeight.bold, color: Colors.white
                        ),
                      ),
                    ),
                    Positioned(
                      top: 100,
                      child: ScopedModelDescendant<User>(
                        builder: (context, child, model){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  /*
                                  AULA 129: IMAGEM da Conta.
                                  Precisa mudar essa url, pois é só pra testar.
                                   */
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: CircleAvatar(
                                      foregroundColor: Colors.blue,
                                      radius: 34,
                                      backgroundColor: Colors.blue,
                                      child: CircleAvatar(
                                        //AULA 126: Pegando a imagem da conta logada
                                        //NOTA: A IMAGEM NA MINHA CONTA DO IFMA TÁ NULA. PRECISO PUXAR UMA REFERÊNCIA PARA O STORAGE DO FIREBASE.
                                        backgroundImage: model.userData["photoUser"] == null ? AssetImage('assets/img/aceito.png'): NetworkImage(model.userData["photoUser"]),
                                        radius: 30,
                                        foregroundColor: Colors.indigo,
                                      ),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      "Bem-vindo ${!model.isLoggedIn() ? "jovem guerreiro!" : model.userData["nome"]}", style: TextStyle(
                                        fontSize: 16, fontFamily: 'Helvetica', color: Colors.white
                                    ),),
                                  ),
                                ],
                              ),

                              //Botão clicado na cor diferente dos demais
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Cidade Natal", pageControler, 0),
              DrawerTile(Icons.playlist_add_check, "Quests Aceitas/Concluídas", pageControler, 1),
              DrawerTile(Icons.announcement, "Clamar Recompensas", pageControler, 2),
              DrawerTile(Icons.airline_seat_individual_suite, "Descansar", pageControler, 3), //Descansar é sair
            ],
          ),
        ],
      ),
    );
  }
}
