import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {

  String _id;
  String _username;
  String _password;
  String _email;
  String _date;
  bool _adm;
  bool _vip;

  Usuario();

  Usuario.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    this.id = documentSnapshot['Id'];
    this.username = documentSnapshot['Username'];
    this.email = documentSnapshot['Email'];
    this.adm = documentSnapshot['Adm'];
    this.vip = documentSnapshot['Vip'];
    try{
      this.date = documentSnapshot['Date'];
    } catch(e){
      _uploadDate();
    }
  }

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "Id" : this.id,
      "Username" : this.username,
      "Email" : this.email,
      "Adm" : this.adm,
      "Vip" : this.vip,
      "Date" : this.date,
    };

    return map;

  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  bool get adm => _adm;

  set adm(bool value) {
    _adm = value;
  }

  bool get vip => _vip;

  set vip(bool value) {
    _vip = value;
  }


  _uploadDate(){
    String dateS = DateTime.now().toString();
    FirebaseFirestore.instance.collection('users').doc(this.id).update({
      "Date" : dateS,
    }).then((value){
      print("data de criação upada");
      this.date = dateS;
    }).catchError((e){
      print("erro ao upar data de criação");
    });
  }


}