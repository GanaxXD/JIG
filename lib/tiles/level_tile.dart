import 'package:cloud_firestore/cloud_firestore.dart';

class Level {

  int lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8, lv9, lv10, lv11, lv12, lv13, lv14, lv15,
  lv16, lv17, lv18, lv19, lv20, lv21, lv22, lv23, lv24, lv25, lv26, lv27;

  List<int> leveis;

  Level();
  Level.preenchido(this.lv1, this.lv2, this.lv3, this.lv4, this.lv5, this.lv6, this.lv7, this.lv8, this.lv9, this.lv10, this.lv11, this.lv12);

  Level.fromDocument(DocumentSnapshot snapshot){
    lv1 = snapshot.data["0"];
    lv2 = snapshot.data["1"];
    lv3 = snapshot.data["2"];
    lv4 = snapshot.data["3"];
    lv5 = snapshot.data["4"];
    lv6 = snapshot.data["5"];
    lv7 = snapshot.data["6"];
    lv8 = snapshot.data["7"];
    lv9 = snapshot.data["8"];
    lv10 = snapshot.data["9"];
    lv11 = snapshot.data["10"];
    lv12 = snapshot.data["11"];
    lv13 = snapshot.data["12"];
  }
}