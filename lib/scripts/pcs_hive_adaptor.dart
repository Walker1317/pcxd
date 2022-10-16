import 'package:hive/hive.dart';
import 'package:pcxd_app/model/pc/pc.dart';

class PcHiveAdapter extends TypeAdapter<PC> {

  @override
  final typeId = 0;

  @override
  PC read(BinaryReader reader){
    return PC();
  }

  @override
  void write(BinaryWriter writer, PC pc){
    writer.writeString(pc.cpu);
  }
}