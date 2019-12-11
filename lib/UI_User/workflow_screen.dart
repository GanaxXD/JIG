import 'package:flutter/material.dart';
import 'package:job_is_a_game_app/widgets/custom_drawer.dart';

class Workflow extends StatefulWidget {
  @override
  _WorkflowState createState() => _WorkflowState();
}

class _WorkflowState extends State<Workflow> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  mostrarSnackBar(){
    final snackbar = SnackBar(
      content: Text("Este foi o workflow definido pelo seu contratador para ajudá-lo"
          "a cumprir essa missão."),
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
            title: Text("Workflow"),
            backgroundColor: Colors.indigo,
            key: scaffoldKey,
            actions: <Widget>[
              IconButton(icon: Icon(Icons.info),
                  onPressed: mostrarSnackBar
              ),
            ],
          ),
        ),
        onWillPop: (){});
  }
}

