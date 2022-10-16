import 'package:cloud_firestore/cloud_firestore.dart';

class Placamae{

  String _imagem;
  String _marca;
  String _modelo;
  String _plataforma;
  String _tipoMemoria;
  String _socket;
  double _preco;
  int _slotsRam;
  int _nvmeSlots;
  int _sata;
  int _pcie16;

  Placamae();

  Placamae.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    marca = documentSnapshot['Marca'];
    modelo = documentSnapshot['Modelo'];
    socket = documentSnapshot['Socket'];
    preco = documentSnapshot['Preco'];
    imagem= documentSnapshot['Imagem'];
    tipoMemoria = documentSnapshot['TipoMemoria'];
    plataforma = documentSnapshot['Plataforma'];
    slotsRam = documentSnapshot['SlotsRAM'];
    nvmeSlots = documentSnapshot['NvmeSlots'];
    sata = documentSnapshot['Sata'];
    pcie16 = documentSnapshot['Pcie16'];
  }

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "Marca" : marca,
      "Modelo" : modelo,
      "Socket" : socket,
      "Preco" : preco,
      "Imagem" : imagem,
      "TipoMemoria" : tipoMemoria,
      "Plataforma" : plataforma,
      "SlotsRAM" : slotsRam,
      "NvmeSlots" : nvmeSlots,
      "Sata" : sata,
      "Pcie16" : pcie16,
    };

    return map;

  }

  String get imagem => _imagem;

  set imagem(String value) {
    _imagem = value;
  }
  
  String get plataforma => _plataforma;

  set plataforma(String value) {
    _plataforma = value;
  }

  String get tipoMemoria => _tipoMemoria;

  set tipoMemoria(String value) {
    _tipoMemoria = value;
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

  int get slotsRam => _slotsRam;

  set slotsRam(int value) {
    _slotsRam = value;
  }

  int get nvmeSlots => _nvmeSlots;

  set nvmeSlots(int value) {
    _nvmeSlots = value;
  }

  int get sata => _sata;

  set sata(int value) {
    _sata = value;
  }

  int get pcie16 => _pcie16;

  set pcie16(int value) {
    _pcie16 = value;
  }

}