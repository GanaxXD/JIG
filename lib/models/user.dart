import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scoped_model/scoped_model.dart';

// SCOPEDMODEL - Extends Model para que essa classe possa ter seus estados do seu modelo
// compartilhados em toda a aplicação. Eu preciso dizer nas telas se elas serão afetadas ou não pelos models.
class User extends Model{

  //LOGIN
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();
  bool isLoading = false;

  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount userGoogle = null;

  //método que permite que outras telas acessem minhas informações sem precisar usar o ScoppedModelDescandent
  //Lembre: static é um método da classe e não do objeto
  static User of(BuildContext context)=> ScopedModel.of<User>(context);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

  /* FUNÇÃO CRIAR CONTA
  Coloquei todos como requisitos obrigatórios porque estava ficando
  dificil lembrar de todos os atributos solicitados na chamada
  do método. Usando a anotação @required, o flutter á auto-completa a chamada
  da fnção dando null em todos os atributos
   */
  void signUp({@required Map<String, dynamic> userData,
    @required String pass, @required VoidCallback onSucess,
    @required VoidCallback onFail}) async {
      isLoading = true;
      notifyListeners();

      /*
      Por retornar um futuro, eu uso o then
       */
      _auth.createUserWithEmailAndPassword(
          email: userData["email"], //PRECISA VER SE O FIREBASE DELE TEM ESSA COLEÇÃO CRIADA
          password: pass,
      ).then((user) async{
        firebaseUser = user;

        //SALVANDO DADOS DO USUÁRIO: o firebase já salvará o email
        await _saveUserData(userData);

        onSucess();
        isLoading = false;
        notifyListeners();
      }).catchError((e){
        onFail();
        isLoading = false;
        print(e.toString());
        notifyListeners();
      });
  }

  /*
  FUNÇÃO LOGA USUÁRIO
   */
  void sigIn({@required String email, @required pass,
    @required VoidCallback onSuccess, @required VoidCallback onFail}) async{
    isLoading = true;
    //Informando as páginas que usam o Model que houve alteração de estado
    notifyListeners();

    /*userGoogle = googleSignIn.currentUser;
    if(userGoogle == null)
      userGoogle = await googleSignIn.signInSilently();
    if(userGoogle == null)
      userGoogle = await googleSignIn.signIn();*/
    _auth.signInWithEmailAndPassword(email: email, password: pass).then(
      (user)async{
        firebaseUser = user;

        await _loadCurrentUser();

        onSuccess();
        isLoading = false;
        notifyListeners();

    }).catchError((e){
      onFail();
      isLoading = false;
      notifyListeners();
    });



  }

  /*
  Retorna o usuário logado para que eu possa usar
  o nome dele nas páginas :) Retorna tru se o firebaseuser != null.
   */
  bool isLoggedIn(){
    return firebaseUser != null;
  }

  /*
  Desloga.
   */
  void signOut() async {
    await _auth.signOut();
    userData = Map();
    firebaseUser = null;
    notifyListeners();
  }

  //Recuperar senha
  void recoverPass(String email){
    _auth.sendPasswordResetEmail(email: email);

  }

  Future<Null> _saveUserData(Map<String, dynamic> userD) async {
    this.userData = userD;
    //SETAR O ID DO USER PARA IDENTIFICAÇÃO DO DOCUMENTO
    await Firestore.instance.collection("usuarios").document(firebaseUser.uid).setData(userData);
  }

  /*
  Função para pegar os dados do
  usuário se ele estiver
  logado.
   */
  Future<Null> _loadCurrentUser() async{
    if(firebaseUser == null)
      firebaseUser = await _auth.currentUser();
    if(firebaseUser !=null)
      if(userData["nome"]==null){
        DocumentSnapshot docUser = await Firestore.instance.collection("usuarios").document(firebaseUser.uid).get();
        userData = docUser.data;
      }
    notifyListeners();
  }

  Future<Null> loadCurrentUser() async{
    if(firebaseUser == null)
      firebaseUser = await _auth.currentUser();
    if(firebaseUser !=null)
      if(userData["nome"]==null){
        DocumentSnapshot docUser = await Firestore.instance.collection("usuarios").document(firebaseUser.uid).get();
        userData = docUser.data;
      }
    notifyListeners();
  }


  void compraMissao(int xpTotaldoUsuario, User user, int xpCusto) async{
    /*userData["xp"] = Firestore.instance.collection("usuarios").document(idUserFirebase)
        .updateData({"xp" : xpTotaldoUsuario = xpTotaldoUsuario - xpCusto});*/
    Firestore.instance.collection("usuarios")
        .document(user.firebaseUser.uid)
        .updateData(
        {"xp": xpTotaldoUsuario - xpCusto});

    notifyListeners();
  }

}
