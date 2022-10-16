
import 'package:cloud_firestore/cloud_firestore.dart';

class GPU {
  GPU();

  //especificações
  String _marca;
  String _modelo;
  double _preco;
  String _tipo;
  String _interface;
  String _imagem;
  int _coreClock;
  int _memoryClock;
  int _memory;
  double _openGL;
  int _g2g;
  int _ano;
  int _energia;

  //benchmark
  int _benchmark;

  GPU.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    this.marca = documentSnapshot['Marca'];
    this.modelo = documentSnapshot['Modelo'];
    this.interface = documentSnapshot['Interface'];
    this.preco = documentSnapshot['Preco'];
    this.tipo = documentSnapshot['Tipo'];
    this.coreClock = documentSnapshot['CoreClock'];
    this.memoryClock = documentSnapshot['MemoryClock'];
    this.memory = documentSnapshot['Memory'];
    this.openGL = documentSnapshot['OpenGL'];
    this.ano = documentSnapshot['Ano'];
    this.energia = documentSnapshot['Energia'];
    this.benchmark = documentSnapshot['Benchmark'];
    this.g2g = documentSnapshot['G2G'];
    this.imagem = documentSnapshot['Imagem'];
  }

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "Marca" : this.marca,
      "Modelo" : this.modelo,
      "Interface" : this.interface,
      "Preco" : this.preco,
      "Tipo" : this.tipo,
      "CoreClock" : this.coreClock,
      "MemoryClock" : this.memoryClock,
      "Memory" : this.memory,
      "OpenGL" : this.openGL,
      "Ano" : this.ano,
      "Energia" : this.energia,
      "Benchmark" : this.benchmark,
      "G2G" : this.g2g,
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

  String get interface => _interface;

  set interface(String value) {
    _interface = value;
  }

  double get preco => _preco;

  set preco(double value) {
    _preco = value;
  }

  String get tipo => _tipo;

  set tipo(String value) {
    _tipo = value;
  }

  double get openGL => _openGL;

  set openGL(double value) {
    _openGL = value;
  }

  int get coreClock => _coreClock;

  set coreClock(int value) {
    _coreClock = value;
  }

  int get memoryClock => _memoryClock;

  set memoryClock(int value) {
    _memoryClock = value;
  }

  int get memory => _memory;

  set memory(int value) {
    _memory = value;
  }
  
  int get energia => _energia;

  set energia(int value) {
    _energia = value;
  }

  int get benchmark => _benchmark;

  set benchmark(int value) {
    _benchmark = value;
  }

  int get g2g => _g2g;

  set g2g(int value) {
    _g2g = value;
  }

  int get ano => _ano;

  set ano(int value) {
    _ano = value;
  }

  String get imagem => _imagem;

  set imagem(String value) {
    _imagem = value;
  }

}