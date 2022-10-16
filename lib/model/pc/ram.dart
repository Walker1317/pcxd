import 'package:cloud_firestore/cloud_firestore.dart';

class RAM{

  String _marca;
  String _modelo;
  int _capacidade;
  double _preco;
  String _tipo;
  int _velocidade;
  String _imagem;

  RAM();

  RAM.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    marca = documentSnapshot['Marca'];
    modelo = documentSnapshot['Modelo'];
    capacidade = documentSnapshot['Capacidade'];
    tipo = documentSnapshot['Tipo'];
    velocidade = documentSnapshot['Velocidade'];
    imagem = documentSnapshot['Imagem'];
    preco = documentSnapshot['Preco'];
  }

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "Marca" : marca,
      "Modelo" : modelo,
      "Capacidade" : capacidade,
      "Tipo" : tipo,
      "Velocidade" : velocidade,
      "Imagem" : imagem,
      "Preco" : preco,
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

  int get capacidade => _capacidade;

  set capacidade(int value) {
    _capacidade = value;
  }

  double get preco => _preco;

  set preco(double value) {
    _preco = value;
  }

  String get tipo => _tipo;

  set tipo(String value) {
    _tipo = value;
  }

  int get velocidade => _velocidade;

  set velocidade(int value) {
    _velocidade = value;
  }

  String get imagem => _imagem;

  set imagem(String value) {
    _imagem = value;
  }

}