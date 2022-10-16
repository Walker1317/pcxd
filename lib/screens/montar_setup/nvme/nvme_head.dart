import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pcxd_app/model/pc/nvme.dart';
import 'package:pcxd_app/model/pc/pc.dart';

class NVMEHead extends StatefulWidget {
  NVMEHead(this.listNVME, this.pc, this.controlNVME);
  List<NVME> listNVME;
  PC pc;
  Widget controlNVME;

  @override
  State<NVMEHead> createState() => _NVMEHeadState();
}

class _NVMEHeadState extends State<NVMEHead> {
  
  @override
  void initState() {
    super.initState();
    if(widget.listNVME[0].modelo == null){

      widget.listNVME[0];
      widget.listNVME[0].capacidade = 0;
      widget.listNVME[0].marca = 'Marca';
      widget.listNVME[0].modelo = 'Modelo';
      widget.listNVME[0].preco = 0;

    }
  }

  Color color(){

    if(widget.listNVME[0].capacidade == 0){
      return Colors.white;
    } else{
      return const Color.fromARGB(255, 127, 30, 255);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              AnimatedContainer(
                padding: const EdgeInsets.all(30),
                duration: const Duration(seconds: 1),
                curve: Curves.ease,
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(99, 12, 0, 29).withOpacity(0.4),
                  border: Border.all(
                    color: color()
                  ),
                  image: widget.listNVME[0].imagem != null ? DecorationImage(image: NetworkImage(widget.listNVME[0].imagem), fit: BoxFit.scaleDown, scale: 6) : null
                ),
                child:
                widget.listNVME[0].imagem != null ? Container():
                  SvgPicture.asset('assets/ssd.svg', color: Colors.white,),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.listNVME[0].modelo ?? 'Modelo', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    Text('Marca: ${widget.listNVME[0].marca}',),
                    Text('Capacidade: ${widget.listNVME[0].capacidade}GB',),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30,),
          widget.pc.nvmeObj[0].capacidade == 0 ?
          Container(): 
          widget.controlNVME
        ],
      ),
    );
  }
}