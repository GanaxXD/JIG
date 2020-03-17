import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:job_is_a_game_app/UI_User/home_user.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CriarQuest extends StatefulWidget {

  final PageController pageController;
  String userId;
  CriarQuest(this.pageController, this.userId);

  @override
  _CriarQuestState createState() => _CriarQuestState(this.pageController, this.userId);
}

class _CriarQuestState extends State<CriarQuest> {

  final PageController pageController;
  String userId;
  _CriarQuestState(this.pageController, this.userId);


  final _formkey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  final _missao = TextEditingController();
  final _descricao = TextEditingController();
  final _dtInicio = TextEditingController();
  final _dtFim = TextEditingController();
  final _premio = TextEditingController();

  DateTime dtIn, dtFm;

  final int workfTrocaHardware=0;
  final int workfConexaoInternet=1;
  final int workfSolicitaEquip=2;
  final int workfConsertoHardware=3;
  int grupoRadioWorkflow;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: WillPopScope(
          onWillPop: (){},
          child: Form(
            key: _formkey,
            autovalidate: true,
            child:  ListView(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        autovalidate: true,
                        controller: _missao,
                        validator: (text){
                          if(text.isEmpty) return "Título da Missão inválido.";
                        },
                        decoration: InputDecoration(
                            icon: Icon(Icons.title),
                            hintText: "Digite um título para a missão",
                            labelText: "Título da Missão"
                        ),
                      ),
                      SizedBox(height: 5,),
                      /*Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.indigo,
                            width: 0.5
                          ),
                        ),
                        child:*/
                        TextFormField(
                              controller: _descricao,
                              textAlign: TextAlign.justify,
                              autocorrect: true,
                              style: TextStyle(color: Colors.black45, fontFamily: 'Helvetica'),
                              cursorColor: Colors.indigo,
                              keyboardType: TextInputType.text,
                              strutStyle: StrutStyle(
                                height: 2,
                                fontWeight: FontWeight.w400,
                                forceStrutHeight: true,
                              ),
                              onEditingComplete: (){
                                if(_descricao.text.length <=0){
                                  return Text("Descrição inválida.");
                                }
                              },

                              decoration: InputDecoration(
                                icon: Icon(Icons.assignment),
                                hintText: "Digite uma descrição para a missão (ao menos uma línha)",
                                labelText: "Descrição da Missão",
                              ),
                            ),
                        //),
                      SizedBox(height: 35,),

                      Wrap(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              IconButton(
                                color: Colors.black45,
                                splashColor: Colors.indigo,
                                icon: Icon(Icons.hourglass_full),
                                onPressed: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(2019, 1, 1),
                                      maxTime: DateTime(2099, 12, 31), onChanged: (date) {
                                        print('change $date');
                                      }, onConfirm: (date) {
                                        print('confirm $date');
                                        dtIn = date;
                                      }, currentTime: DateTime.now(), locale: LocaleType.pt);
                                },),
                              Text(
                                'Escolha uma data de lançamento da Missão',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Container(
                            alignment: Alignment.center,
                            child: dtIn == null? Text("Data não selecionada", style: TextStyle(color: Colors.grey)) :
                            Text("Data Selecionada: "+dtIn.toString(), textAlign: TextAlign.center, style: TextStyle(color: Colors.indigo),),
                          ),
                          Row(
                            children: <Widget>[
                              IconButton(
                                color: Colors.black45,
                                splashColor: Colors.indigo,
                                icon: Icon(Icons.hourglass_empty),
                                onPressed: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(2019, 1, 1),
                                      maxTime: DateTime(2099, 12, 31), onChanged: (date) {
                                        print('change $date');
                                      }, onConfirm: (date) {
                                        print('confirm $date');
                                        dtFm = date;
                                      }, currentTime: DateTime.now(), locale: LocaleType.pt);
                                },),
                              Text(
                                'Escolha um prazo de Entrega',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Container(
                            alignment: Alignment.center,
                            child: dtFm == null? Text("Data não selecionada", style: TextStyle(color: Colors.grey),) :
                            Text("Data Selecionada: "+dtFm.toString(), textAlign: TextAlign.center, style: TextStyle(color: Colors.indigo),),
                          ),
                        ],
                      ),

                      /*SizedBox(height: 35,),

                      TextFormField(
                        keyboardType: TextInputType.number,
                        autovalidate: true,
                        controller: _premio,
                        validator: (text){
                          if(text.isEmpty) return "Prêmio inválido.";
                        },
                        decoration: InputDecoration(
                            icon: Icon(Icons.attach_money),
                            hintText: "Digite o valor da recompensa para a missão em xp (Padrão: 1)",
                            labelText: "Prêmio em XP"
                        ),
                      ),*/

                      SizedBox(height: 35,),
                      Container(
                        alignment: Alignment.center,
                        child: Text("Selecione um dos tipos de workflow para a missão: ", style: TextStyle(color: Colors.indigo),),
                      ),

                      SizedBox(height: 5,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('Troca de Hardware ou Componente Defeituoso:', style: TextStyle(
                            fontSize: 16, fontFamily: 'Helvetica',
                            color: Colors.black45,
                          ),),
                          Radio(
                            activeColor: Colors.blue,
                            value: workfTrocaHardware,
                            groupValue: grupoRadioWorkflow,
                            onChanged: (int valor){
                              setState((){
                                grupoRadioWorkflow = valor;
                              });
                            },
                          ),

                          Text('Troca de Cabos de Conexão com a Internet:', style: TextStyle(
                            fontSize: 16, fontFamily: 'Helvetica',
                            color: Colors.black45,
                          ),),
                          Radio(
                            activeColor: Colors.blue,
                            value: workfConexaoInternet,
                            groupValue: grupoRadioWorkflow,
                            onChanged: (int valor){
                              setState((){
                                grupoRadioWorkflow = valor;
                              });
                            },
                          ),

                          Text('Solicitação à Fornecedores:', style: TextStyle(
                            fontSize: 16, fontFamily: 'Helvetica',
                            color: Colors.black45,
                          ),),
                          Radio(
                            activeColor: Colors.blue,
                            value: workfSolicitaEquip,
                            groupValue: grupoRadioWorkflow,
                            onChanged: (int valor){
                              setState((){
                                grupoRadioWorkflow = valor;
                              });
                            },
                          ),

                          Text('Conserto de Hardware Defeituoso:', style: TextStyle(
                            fontSize: 16, fontFamily: 'Helvetica',
                            color: Colors.black45,
                          ),),
                          Radio(
                            activeColor: Colors.blue,
                            value: workfConsertoHardware,
                            groupValue: grupoRadioWorkflow,
                            onChanged: (int valor){
                              setState((){
                                grupoRadioWorkflow = valor;
                              });
                            },
                          ),
                        ],
                      ),

                      SizedBox(height: 40,),

                      OutlineButton(
                        color: Colors.white,
                        highlightedBorderColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        // ignore: missing_return
                        onPressed: () async {
                          if(_formkey.currentState.validate()){
                            int id;
                            var idBanco = await Firestore.instance.collection("id_quest").document("idQuestFirebase").get().then((doc){
                              id = doc.data["idQuest"];
                            });

                            Firestore.instance.collection("quests").document(_missao.text).setData({
                              "titulo_quest": _missao.text,
                              "descricao_quest" : _descricao.text,
                              "id_quest" : id,
                              "concluida" : false,
                              "aceita" : false,
                              "dtInicio" : dtIn,
                              "dtFim" : dtFm,
                              "status" : 1,
                              "xp" : 1,//int.parse(_premio.text),
                              "workflow" : grupoRadioWorkflow,
                              "status_workflow" : 1,
                              "acoes_tomadas" : "Ações Tomadas: ",
                              "criada_por": userId,
                              "quantidade_de_participantes" : 0,
                              "participantes" : {

                              },
                              "data_criacao" : Timestamp.now(),
                            });
                            id +=1;
                            Firestore.instance.collection("id_quest").document("idQuestFirebase").updateData({"idQuest": id});


                            print("Cheguei aqui");

                            return Alert(
                              context: context,
                              title: "Missão Criada!",
                              desc: "A missão está disponível na tela \"Quests Disponíveis\".",
                              image: Image.asset('assets/img/icone_login_workflow.png'),
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "Fechar",
                                    style: TextStyle(color: Colors.white, fontSize: 20,
                                        fontFamily: 'Helvetica'),
                                  ),
                                  onPressed: () => Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => HomeUser())),
                                  color: Colors.indigo[400],
                                ),
                              ],
                            ).show();

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
                                  "Criar Missão", textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.indigo,
                                      fontWeight: FontWeight.bold),),),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20,),

                      OutlineButton(
                        color: Colors.white,
                        highlightedBorderColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        onPressed: () async {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => HomeUser()));
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
                                  "Voltar", textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.indigo,
                                      fontWeight: FontWeight.bold),),),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 40,),


                    ],
                  ),
                ],
            ),
          )
      ),);
  }
}

