import 'package:cloud_firestore/cloud_firestore.dart';

class Gabinete{

  String _marca;
  String _modelo;
  String _imagem;
  double _preco;

  Gabinete();

  Gabinete.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    this.marca = documentSnapshot['Marca'];
    this.modelo = documentSnapshot['Modelo'];
    this.preco = documentSnapshot['Preco'];
    this.imagem = documentSnapshot['Imagem'];
  }

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "Marca" : this.marca,
      "Modelo" : this.modelo,
      "Preco" : this.preco,
      "Imagem" : this.imagem,
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

  double get preco => _preco;

  set preco(double value) {
    _preco = value;
  }

  String get imagem => _imagem;

  set imagem(String value) {
    _imagem = value;
  }

}