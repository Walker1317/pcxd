import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:pcxd_app/model/pc/pc.dart';
import 'package:pcxd_app/scripts/pcs_hive_adaptor.dart';

class PcRepository extends ChangeNotifier{

  List<PC> _listaPC = [];
  LazyBox box;

  PcRepository(){
    _startRepository();
  }

  _startRepository() async{
    await _openBox();
    await _readPCs();
  }

  _openBox() async {
    Hive.registerAdapter(PcHiveAdapter());
    box = await Hive.openLazyBox<PC>('meus_pcs');
  }

  _readPCs() {
    box.keys.forEach((pc) async {
      PC pcObj = await box.get(pc);
      _listaPC.add(pcObj);
    });
  }

  saveAll(List<PC> pcs){
    pcs.forEach((pc) {
      if(! _listaPC.any((atual) => atual.cpu == pc.cpu)){
        _listaPC.add(pc);
        box.put(pc.cpu, pc);
      }
    });
  }

  remove(PC pc){
    _listaPC.remove(pc);
    box.delete(pc.cpu);
    notifyListeners()
;  }

}