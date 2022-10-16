import 'package:cloud_firestore/cloud_firestore.dart';

class PSU{

  String _marca;
  String _modelo;
  int _potencia;
  double _preco;
  String _imagem;

  PSU();

  PSU.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    try{
      marca = documentSnapshot['Marca'];
      modelo = documentSnapshot['Modelo'];
      potencia = documentSnapshot['Potencia'];
      preco = documentSnapshot['Preco'];
      imagem = documentSnapshot['Imagem'];
    } catch(e){
      print(e);
    }
  }

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "Marca" : marca,
      "Modelo" : modelo,
      "Potencia" : potencia,
      "Preco" : preco,
      "Imagem" : imagem,
    };

    return map;

  }

  String get marca => _marca;

  set marca(String value) {
    _marca = value;
  }

  String get modelo => _modelo;

  set modelo(String value) {
    _modelo = value;
  }

  int get potencia => _potencia;

  set potencia(int value) {
    _potencia = value;
  }

  double get preco => _preco;

  set preco(double value) {
    _preco = value;
  }

  String get imagem => _imagem;

  set imagem(String value) {
    _imagem = value;
  }

}