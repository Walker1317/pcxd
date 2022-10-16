import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pcxd_app/model/pc/cpu.dart';
import 'package:pcxd_app/model/pc/gabinete.dart';
import 'package:pcxd_app/model/pc/gpu.dart';
import 'package:pcxd_app/model/pc/nvme.dart';
import 'package:pcxd_app/model/pc/placamae.dart';
import 'package:pcxd_app/model/pc/psu.dart';
import 'package:pcxd_app/model/pc/ram.dart';
import 'package:pcxd_app/model/pc/ssd.dart';

class PC{

  String _id;
  String _cpu;
  String _placamae;
  String _performance;
  String _ram;
  int _ramArmazenamento;
  int _ramQuantidade;
  String _nvme;
  int _nvmeArmazenamento;
  int _nvmeQuantidade;
  String _ssd;
  int _ssdArmazenamento;
  int _ssdQuantidade;
  String _gpu;
  String _psu;
  String _gabinete;
  String _imagem;
  String _nome;
  int _benchamrk;
  double _preco;
  String _criador;
  String _cpuMarca;
  String _gpuMarca;

  CPU _cpuObj;
  Placamae _placamaeObj;
  List<RAM> _ramObj;
  List<SSD> _ssdObj;
  List<NVME> _nvmeObj;
  GPU _gpuObj;
  PSU _psuObj;
  Gabinete _gabineteObj;

  PC();

  PC.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    id = documentSnapshot['Id'];
    nome = documentSnapshot['Nome'];
    cpuMarca = documentSnapshot['CpuMarca'];
    gpuMarca = documentSnapshot['GpuMarca'];
    cpu = documentSnapshot['CPU'];
    placamae = documentSnapshot['PlacaMae'];
    ramArmazenamento = documentSnapshot['RAMArmazenamento'];
    ssdArmazenamento = documentSnapshot['SSDArmazenamento'];
    gpu = documentSnapshot['GPU'];
    psu = documentSnapshot['PSU'];
    gabinete = documentSnapshot['Gabinete'];
    imagem = documentSnapshot['Imagem'];
    performance = documentSnapshot['Performance'];
    benchamrk= documentSnapshot['Benchmark'];
    ram= documentSnapshot['RAM'];
    ramQuantidade= documentSnapshot['RAMQuantidade'];
    ssd= documentSnapshot['SSD'];
    ssdQuantidade= documentSnapshot['SSDQuantidade'];
    nvme= documentSnapshot['NVME'];
    nvmeQuantidade= documentSnapshot['NVMEQuantidade'];
    nvmeArmazenamento= documentSnapshot['NVMEArmazenamento'];
    criador= documentSnapshot['Criador'];
    preco= documentSnapshot['Preco'];
  }

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "Id" : id,
      "CpuMarca" : cpuMarca,
      "GpuMarca" : gpuMarca,
      "Nome" : nome,
      "CPU" : cpu,
      "PlacaMae" : placamae,
      "RAMArmazenamento" : ramArmazenamento,
      "SSDArmazenamento" : ssdArmazenamento,
      "GPU" : gpu,
      "PSU" : psu,
      "Gabinete" : gabinete,
      "Imagem" : imagem,
      "Performance" : performance,
      "Benchmark" : benchamrk,
      "RAM" : ram,
      "RAMQuantidade" : ramQuantidade,
      "SSD" : ssd,
      "SSDQuantidade" : ssdQuantidade,
      "NVME" : nvme,
      "NVMEQuantidade" : nvmeQuantidade,
      "NVMEArmazenamento" : nvmeArmazenamento,
      "Criador" : criador,
      "Preco" : preco,
    };

    return map;

  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get gpuMarca => _gpuMarca;

  set gpuMarca(String value) {
    _gpuMarca = value;
  }

  String get cpuMarca => _cpuMarca;

  set cpuMarca(String value) {
    _cpuMarca = value;
  }

  String get imagem => _imagem;

  set imagem(String value) {
    _imagem = value;
  }

  String get cpu => _cpu;

  set cpu(String value) {
    _cpu = value;
  }

  String get ram => _ram;

  set ram(String value) {
    _ram = value;
  }

  int get ramQuantidade => _ramQuantidade;

  set ramQuantidade(int value) {
    _ramQuantidade = value;
  }

  String get nvme => _nvme;

  set nvme(String value) {
    _nvme = value;
  }

  int get nvmeArmazenamento => _nvmeArmazenamento;

  set nvmeArmazenamento(int value) {
    _nvmeArmazenamento = value;
  }

  int get nvmeQuantidade => _nvmeQuantidade;

  set nvmeQuantidade(int value) {
    _nvmeQuantidade = value;
  }

  String get ssd => _ssd;

  set ssd(String value) {
    _ssd = value;
  }

  int get ssdQuantidade => _ssdQuantidade;

  set ssdQuantidade(int value) {
    _ssdQuantidade = value;
  }

  double get preco => _preco;

  set preco(double value) {
    _preco = value;
  }

  int get benchamrk => _benchamrk;

  set benchamrk(int value) {
    _benchamrk = value;
  }

  String get placamae => _placamae;

  set placamae(String value) {
    _placamae = value;
  }

  int get ramArmazenamento => _ramArmazenamento;

  set ramArmazenamento(int value) {
    _ramArmazenamento = value;
  }

  int get ssdArmazenamento => _ssdArmazenamento;

  set ssdArmazenamento(int value) {
    _ssdArmazenamento = value;
  }

  String get gpu => _gpu;

  set gpu(String value) {
    _gpu = value;
  }

  String get psu => _psu;

  set psu(String value) {
    _psu = value;
  }

  String get criador => _criador;

  set criador(String value) {
    _criador = value;
  }

  String get gabinete => _gabinete;

  set gabinete(String value) {
    _gabinete = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get performance => _performance;

  set performance(String value) {
    _performance = value;
  }

  CPU get cpuObj => _cpuObj;

  set cpuObj(CPU value) {
    _cpuObj = value;
  }

  Placamae get placamaeObj => _placamaeObj;

  set placamaeObj(Placamae value) {
    _placamaeObj = value;
  }

  List<RAM> get ramObj => _ramObj;

  set ramObj(List<RAM> value) {
    _ramObj = value;
  }

  List<SSD> get ssdObj => _ssdObj;

  set ssdObj(List<SSD> value) {
    _ssdObj = value;
  }

  List<NVME> get nvmeObj => _nvmeObj;

  set nvmeObj(List<NVME> value) {
    _nvmeObj = value;
  }

  GPU get gpuObj => _gpuObj;

  set gpuObj(GPU value) {
    _gpuObj = value;
  }

  PSU get psuObj => _psuObj;

  set psuObj(PSU value) {
    _psuObj = value;
  }

  Gabinete get gabineteObj => _gabineteObj;

  set gabineteObj(Gabinete value) {
    _gabineteObj = value;
  }

}