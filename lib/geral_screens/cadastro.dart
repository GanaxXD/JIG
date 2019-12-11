import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:job_is_a_game_app/UI_User/home_user.dart';
import 'package:job_is_a_game_app/models/user.dart';
import 'package:scoped_model/scoped_model.dart';


final googleSignIn = GoogleSignIn();
final auth = FirebaseAuth.instance;


class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  final _formkey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  final _nameControle = TextEditingController();
  final _sexoControle = TextEditingController();
  final _idadeControle = TextEditingController();
  final _tempoTrabalhoControle = TextEditingController();
  final _cargoControle = TextEditingController();
  final _emailControle = TextEditingController();
  final _senhaControle = TextEditingController();
  final _confirmaSenhaControle = TextEditingController();
  File _imagem = null;
  String imagemDoFirestore = "";
  final int sexoHomem=1;
  final int sexoMulher=0;
  int grupoRadioSexo;
  List<String> _profissoes = [
    'Analista de Documentação',
    'Analista de Projetos',
    'Analista de Sistemas',
    'Coordenador',
    'Chefe do Setor',
    'Gerente de Projetos',
    'Programador',
    'Suporte de Sistemas',
    //'Suporte Geral'
  ];
  String profissaoSelecionada;

  int idDoBanco;

  Future getImage() async{
    var imag = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imagem = imag;
      print("Imagem path: $_imagem");
    });
  }

  Future uploadPic(BuildContext context) async{
    String nomeArquivo = path.basename(_imagem.path);
    //Envio da imagem para o firestore
    StorageReference firebaseStorage = FirebaseStorage.instance.ref()
        .child(nomeArquivo.toString() + DateTime.now().millisecondsSinceEpoch.toString());
    StorageUploadTask uploadTask = firebaseStorage.putFile(_imagem);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    imagemDoFirestore = await firebaseStorage.getDownloadURL();
    print(imagemDoFirestore.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor:  Colors.indigo,
        title: Text("Crie sua conta",
          style: TextStyle(fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold, color: Colors.white,),
        ),
        centerTitle: true,
      ),

      body: ScopedModelDescendant<User>(
        builder: (context, child, model){
          if(model.isLoading)
            return Center(child: CircularProgressIndicator(),);
          return Form(
            key: _formkey,
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size.height,
              width: MediaQuery.of(context).size.width,
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
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(16),
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 85,
                      backgroundColor: Colors.indigo[200],
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: SizedBox(
                            height: 140,
                            width: 140,
                            child: _imagem == null? Image.asset('assets/img/imagem-login.png',
                              fit: BoxFit.contain,
                              color: Colors.black26,
                            ):
                            Image.file(_imagem, fit: BoxFit.fill,),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text("Insira uma foto", style: TextStyle(
                          fontFamily: 'Helvetica', fontSize: 18, fontWeight: FontWeight.w200,
                          color: Colors.black45,
                        ), textAlign: TextAlign.center,),
                      ),

                      Padding(padding: EdgeInsets.only(left: 10),
                        child: IconButton(icon: Icon(Icons.camera_alt, size: 30, color: Colors.black45,),
                            onPressed: (){
                              getImage();
                            }
                        ),
                      ),
                    ],
                  ),

                  Text("*É necessário inserir uma foto para o seu usuário.", style: TextStyle(
                    fontSize: 10, fontFamily: 'Helvetica', color: Colors.red, fontWeight: FontWeight.w400,
                  ), textAlign: TextAlign.center,),

                  SizedBox(height: 30,),
                  TextFormField(
                    controller: _nameControle,
                    decoration: InputDecoration(
                      hintText: "Nome: ",
                      icon: Icon(Icons.account_circle),
                    ),
                    keyboardType: TextInputType.text,
                  ),

                  Divider(height: 15,),

                  Center(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.insert_emoticon, color: Colors.black45,),
                            Text("Sexo: ", style: TextStyle(
                              fontSize: 16, fontFamily: 'Helvetica',
                              color: Colors.black45,
                            ),textAlign: TextAlign.center,),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Masculino', style: TextStyle(
                              fontSize: 16, fontFamily: 'Helvetica',
                              color: Colors.black45,
                            ),),
                            Radio(
                              activeColor: Colors.blue,
                              value: sexoHomem,
                              groupValue: grupoRadioSexo,
                              onChanged: (int valor){
                                setState((){
                                  grupoRadioSexo = valor;
                                });
                              },
                            ),
                            Text('Feminino', style: TextStyle(
                              fontSize: 16, fontFamily: 'Helvetica',
                              color: Colors.black45,
                            ),),
                            Radio(
                              activeColor: Colors.pink,
                              value: sexoMulher,
                              groupValue:  grupoRadioSexo,
                              onChanged: (int valor){
                                setState((){
                                  grupoRadioSexo = valor;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Divider(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 80,
                        child: TextFormField(
                          controller: _idadeControle,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: "Idade",
                            icon: Icon(Icons.av_timer),
                            //hintText: "Idade: ",
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Expanded(
                        //width: 100,
                        child: Padding(padding: EdgeInsets.only(left: 20),
                          child: TextFormField(
                            controller: _tempoTrabalhoControle,
                            maxLines: 1,
                            decoration: InputDecoration(
                                icon: Icon(Icons.access_time),
                              labelText: "Tempo de Trabalho (ano)",
                              hintText: "Digite a quantidade de anos que você ocupa o cargo."
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),

                    ],
                  ),

                  Divider(height: 15,),

                  TextFormField(
                    controller: _emailControle,
                    maxLines: 1,
                    decoration: InputDecoration(
                      //hintText: "Cargo: ",
                        labelText: "E-mail",
                      icon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text){
                      if(!text.contains("@") || text.isEmpty) return "E-mail Inválido";
                    },
                  ),
                  TextFormField(
                    autocorrect: false,
                    controller: _senhaControle,
                    maxLines: 1,
                    decoration: InputDecoration(
                        icon: Icon(Icons.vpn_key),
                        hintText: "Digite sua senha da conta da Google",
                        labelText: "Senha"
                    ),
                    obscureText: true,
                    validator: (text){
                      if(text.length<=3  || text.isEmpty) return "Senha Inválidoa";
                    },
                  ),
                  Divider(height: 15,),

                  Center(
                    child: DropdownButton(
                      icon: Icon(Icons.assignment_ind),
                      hint: Text('Informe sua profissão',), // Not necessary for Option 1
                      value: profissaoSelecionada,

                      onChanged: (newValue) {
                        setState(() {
                          profissaoSelecionada = newValue;
                        });
                      },
                      items: _profissoes.map((profissao) {
                        return DropdownMenuItem(
                          child: Text(profissao),
                          value: profissao,
                        );
                      }).toList(),
                    ),
                  ),
                  Divider(height: 60,),


                  OutlineButton(
                    color: Colors.white,
                    highlightedBorderColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    onPressed: () async {

                      var id = await Firestore.instance.collection("idUser").document("id").get().then((doc){
                        idDoBanco = doc.data["id"];
                      });
                      print("Aqui? ${id}");

                      if(_formkey.currentState.validate()){
                        /*//uploadPic(context);
                        String nomeArquivo = path.basename(_imagem.path);
                        //Envio da imagem para o firestore
                        StorageReference firebaseStorage = FirebaseStorage.instance.ref()
                            .child(nomeArquivo.toString() + DateTime.now().millisecondsSinceEpoch.toString());
                        StorageUploadTask uploadTask = firebaseStorage.putFile(_imagem);
                        StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

                        imagemDoFirestore = await firebaseStorage.getDownloadURL();
                        print(imagemDoFirestore.toString());*/

                        if (_imagem == null) return;
                        StorageUploadTask task = FirebaseStorage.instance.ref()
                            .child("Photo_Users").child("${idDoBanco}LogginPerfil"+
                        DateTime.now().millisecondsSinceEpoch.toString()).putFile(_imagem);
                        StorageTaskSnapshot taskSnapshot = await task.onComplete;
                        String url = await taskSnapshot.ref.getDownloadURL();

                        //uploadPic(context);

                        //https://stackoverflow.com/questions/50836339/flutter-firestore-how-to-display-an-image-from-firestore-in-flutter
                        //"photoUser" : url,


                        Map<String, dynamic> userData = {
                          "nome": _nameControle.text,
                          "sexo" : grupoRadioSexo == 1 ? "Homem" : "Mulher",
                          "idade": _idadeControle.text,
                          "tempoTrabalho": _tempoTrabalhoControle.text,
                          "cargo": profissaoSelecionada,//_cargoControle.text,
                          "email": _emailControle.text,
                          "xp": 0,
                          "level": int.fromEnvironment(_tempoTrabalhoControle.text, defaultValue: 0), //CORRIGIR. ELE ESTÁ INDO COMO UMA STRING
                          "photoUser": url.toString(),//url.toString(),
                          "id": idDoBanco.toString(),

                          //Se a senha for salva aqui, ela irá para o firestore em um campo string, quee será visível: uma péssima ideia.
                        };
                        print("Cheguei aqui");

                        idDoBanco = idDoBanco+1;
                        Firestore.instance.collection("idUser").document("id").updateData({"id": idDoBanco});
                        model.signUp(
                            userData: userData,
                            pass: _senhaControle.text,
                            onSucess: _onSuccess,
                            onFail: _onFail
                        );
                        print("Cheguei aqui 2");
                      }

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
                              "Criar Conta", textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.indigo,
                                  fontWeight: FontWeight.bold),),),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /*
  AULA 157:
  Coloco um snackbar para mostrar uma mensagem
  para indicar que o usuário logou.
   */
  void _onSuccess(){
    _scaffoldkey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.white,
      content: Text("Guerreiro alistado com sucesso!", style: TextStyle(
        color: Colors.indigo, fontFamily: 'Helvetica',
      ),),
      duration: Duration(seconds: 1),
    ));
    Future.delayed(Duration(milliseconds: 10)).then((_){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => HomeUser()));
    });
  }

  /*
  AULA 157:
  Função para sair.
   */
  void _onFail(){

    _scaffoldkey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text("Falha ao alistar o guerreiro. Tente novamente!",style: TextStyle(
        color: Colors.white, fontFamily: 'Helvetica',
      ),),
      duration: Duration(seconds: 3),
    ));
  }

}
