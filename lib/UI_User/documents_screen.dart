import 'package:flutter/material.dart';
import 'package:job_is_a_game_app/widgets/custom_drawer.dart';

class Documents extends StatefulWidget {
  @override
  _DocumentsState createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  mostrarSnackBar(){
    final snackbar = SnackBar(
      content: Text("Estes documentos são necessários de serem analisádos"
          "para a tomada de suas decisões."),
      duration: Duration(seconds: 5),
      backgroundColor: Colors.indigo,
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  final pageControler = PageController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          drawer: CustomDrawer(pageControler),
          appBar: AppBar(
            centerTitle: true,
            title: Text("Documentos"),
            backgroundColor: Colors.indigo,
            key: scaffoldKey,
            actions: <Widget>[
              IconButton(icon: Icon(Icons.info),
                  onPressed: mostrarSnackBar
              ),
            ],
          ),
        ),
        onWillPop: (){}
    );
  }
}
