import 'package:flutter/material.dart';

//AULA 139
class DrawerTile extends StatelessWidget {

  final IconData icone;
  final String titulo;
  //AULA 140 - TROCANDO PÁGINA PELO DRAWER
  final PageController pageControler;
  final int page;

  DrawerTile(this.icone, this.titulo, this.pageControler, this.page);

  @override
  Widget build(BuildContext context) {
    //Usei porque dá um efeito visual quando clico nele
    return Material(
      color: Colors.transparent,
      child: InkWell(
        //Navigator ficará aqui
        //AULA 140
        onTap: (){
          Navigator.of(context).pop();
          pageControler.jumpToPage(page);
        },

        child: Container(
          height: 40,
          child: Row(
            children: <Widget>[
              Icon(
                icone,
                size: 25,
                      //pageControler.page estava rettornando um double, e
                      // page é um inteiro. Pra evitar problemas, coloquei o .round()
                color: pageControler.page.round() == page ?
                       Colors.white : Colors.indigo,
              ),
              //Espaço entre o ícone e o texto
              SizedBox(width: 25,),
              Text(titulo,
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 15.0,
                  color:  pageControler.page.round() == page ?
                  Colors.white : Colors.lightBlue[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
