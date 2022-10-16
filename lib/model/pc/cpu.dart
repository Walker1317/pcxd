
import 'package:cloud_firestore/cloud_firestore.dart';

class CPU {
  CPU();

  //especificações
  String _marca;
  String _modelo;
  String _socket;
  double _preco;
  String _tipo;
  String _imagem;
  double _clock;
  double _turboClock;
  int _cores;
  int _threads;
  int _ano;
  int _energia;

  //benchmark
  int _benchmark;
  int _singleThreadRating;

  CPU.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    this.marca = documentSnapshot['Marca'];
    this.modelo = documentSnapshot['Modelo'];
    this.socket = documentSnapshot['Socket'];
    this.preco = documentSnapshot['Preco'];
    this.tipo = documentSnapshot['Tipo'];
    this.clock = documentSnapshot['Clock'];
    this.turboClock = documentSnapshot['TurboClock'];
    this.cores = documentSnapshot['Cores'];
    this.threads = documentSnapshot['Threads'];
    this.ano = documentSnapshot['Ano'];
    this.energia = documentSnapshot['Energia'];
    this.benchmark = documentSnapshot['Benchmark'];
    this.singleThreadRating = documentSnapshot['SingleThreadRating'];
    this.imagem = documentSnapshot['Imagem'];
  }

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "Marca" : this.marca,
      "Modelo" : this.modelo,
      "Socket" : this.socket,
      "Preco" : this.preco,
      "Tipo" : this.tipo,
      "Clock" : this.clock,
      "TurboClock" : this.turboClock,
      "Cores" : this.cores,
      "Threads" : this.threads,
      "Ano" : this.ano,
      "Energia" : this.energia,
      "Benchmark" : this.benchmark,
      "SingleThreadRating" : this.singleThreadRating,
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

  String get socket => _socket;

  set socket(String value) {
    _socket = value;
  }

  double get preco => _preco;

  set preco(double value) {
    _preco = value;
  }

  String get tipo => _tipo;

  set tipo(String value) {
    _tipo = value;
  }

  double get clock => _clock;

  set clock(double value) {
    _clock = value;
  }

  double get turboClock => _turboClock;

  set turboClock(double value) {
    _turboClock = value;
  }

  int get cores => _cores;

  set cores(int value) {
    _cores = value;
  }

  int get threads => _threads;

  set threads(int value) {
    _threads = value;
  }

  int get ano => _ano;

  set ano(int value) {
    _ano = value;
  }
  
  int get energia => _energia;

  set energia(int value) {
    _energia = value;
  }

  int get benchmark => _benchmark;

  set benchmark(int value) {
    _benchmark = value;
  }

  int get singleThreadRating => _singleThreadRating;

  set singleThreadRating(int value) {
    _singleThreadRating = value;
  }

  String get imagem => _imagem;

  set imagem(String value) {
    _imagem = value;
  }

}