import 'package:cloud_firestore/cloud_firestore.dart';

class SSD{

  String _marca;
  String _modelo;
  int _capacidade;
  double _preco;
  String _imagem;

  SSD();

  SSD.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    try{
      marca = documentSnapshot['Marca'];
      modelo = documentSnapshot['Modelo'];
      capacidade = documentSnapshot['Capacidade'];
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
      "Capacidade" : capacidade,
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

  String get imagem => _imagem;

  set imagem(String value) {
    _imagem = value;
  }

  int get capacidade => _capacidade;

  set capacidade(int value) {
    _capacidade = value;
  }

  double get preco => _preco;

  set preco(double value) {
    _preco = value;
  }

}