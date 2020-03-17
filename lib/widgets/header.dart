import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Header extends StatefulWidget {

  int lvUsuario, xpUsuario, xpProximoLevel;
  Header(this.lvUsuario, this.xpUsuario, this.xpProximoLevel);

  @override
  _HeaderState createState() => _HeaderState(lvUsuario, xpUsuario, xpProximoLevel);
}

class _HeaderState extends State<Header> {

  int lvUsuario, xpUsuario, xpProximoLevel;
  _HeaderState(this.lvUsuario, this.xpUsuario, this.xpProximoLevel);

  Future<int> i;
  int Lv;

 /* @override
  void initState() {
    recuperaLv(lvUsuario);
  }*/


  void recuperaLv(int lv) async {

    DocumentSnapshot pl = await Firestore.instance.collection("lista_Leveis").document("listaLv").get().then((doc){
      i = doc.data[lv];
      Lv = doc.data[lv];
    });
    print("=================: "+ i.toString());
  }

  @override
  Widget build(BuildContext context){

    if(xpProximoLevel == null){
      recuperaLv(lvUsuario);
    }

    return Container(
      child: i == null ?
        CircularProgressIndicator():
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

          lvUsuario==null ?
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: Text("Carregando Dados",
              style: TextStyle(
                  fontFamily: 'helvetica',
                  fontSize: 16,
                  fontWeight: FontWeight
                      .normal),),):
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: Text("${lvUsuario.toString()}",
              style: TextStyle(
                  fontFamily: 'helvetica',
                  fontSize: 16,
                  fontWeight: FontWeight
                      .normal),),),



          Text("XP", style: TextStyle(
              fontFamily: 'helvetica',
              fontSize: 16,
              fontWeight: FontWeight.bold),),

          xpUsuario == null ?
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text("carregando Dados"),):
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text("${xpUsuario.toString()}"),),


          Padding(
            padding: EdgeInsets.only(left: 40),
            child: Text("Next Lv. "),),


          xpProximoLevel == null ?
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text("Carregando Dados"),
          )
              : Padding (
            padding: EdgeInsets.only(left: 10),
            child: Text("${i.toString()}",),
          ),

        ],
      ),
    );
  }
}
