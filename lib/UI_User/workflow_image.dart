import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class WorkflowImage extends StatefulWidget {

  String idWorkflow;
  WorkflowImage(this.idWorkflow);

  @override
  _WorkflowImageState createState() => _WorkflowImageState(this.idWorkflow);
}

class _WorkflowImageState extends State<WorkflowImage> {

  String idWorkflow;
  _WorkflowImageState(this.idWorkflow);
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  
  void mostrarSnackBar(){
    final snackbar = SnackBar(
      content: Text("Este foi o workflow definido pelo seu contratador para ajudá-lo"
          "a cumprir essa missão."),
      duration: Duration(seconds: 5),
      backgroundColor: Colors.indigo,
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Imagem do Workflow", style: TextStyle(
          fontFamily: 'Helvetica',
        ),),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.info),
              onPressed: (){
                mostrarSnackBar();
              }
          ),
        ],
      ),
      body: PhotoView(
        imageProvider: AssetImage(idWorkflow, ),
        minScale: PhotoViewComputedScale.contained * 0.9,
        maxScale: PhotoViewComputedScale.contained * 2.5,
        enableRotation: false,
        backgroundDecoration: BoxDecoration(
          color: Colors.grey[400]
        ),
      ),
    );
  }
}
