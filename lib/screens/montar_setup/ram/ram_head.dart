import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pcxd_app/model/pc/pc.dart';
import 'package:pcxd_app/model/pc/ram.dart';

class RamHead extends StatefulWidget {
  RamHead(this.listRam, this.pc, this.controlRam);
  PC pc;
  List<RAM> listRam;
  Widget controlRam;

  @override
  State<RamHead> createState() => _RamHeadState();
}

class _RamHeadState extends State<RamHead> {

  @override
  void initState() {
    super.initState();
    if(widget.listRam[0].modelo == null){

      widget.listRam[0];
      widget.listRam[0].capacidade = 0;
      widget.listRam[0].marca = 'Marca';
      widget.listRam[0].modelo = 'Modelo';
      widget.listRam[0].preco = 0;
      widget.listRam[0].tipo = 'DDR';
      widget.listRam[0].velocidade = 0;

    }
  }

  Color color(){

    if(widget.listRam[0].capacidade == 0){
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
                  image: widget.listRam[0].imagem != null ? DecorationImage(image: NetworkImage(widget.listRam[0].imagem), fit: BoxFit.scaleDown, scale: 6) : null
                ),
                child:
                widget.listRam[0].imagem != null ? Container():
                  SvgPicture.asset('assets/ram.svg', color: Colors.white,),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.listRam[0].modelo ?? 'Modelo', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    Text('Marca: ${widget.listRam[0].marca}',),
                    Text('Capacidade: ${widget.listRam[0].capacidade}GB',),
                    Text('Tipo: ${widget.listRam[0].tipo}',),
                    Text('Velocidade: ${widget.listRam[0].velocidade}Mhz',),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30,),
          widget.pc.ramObj[0].capacidade == 0 ?
          Container(): 
          widget.controlRam
        ],
      ),
    );
  }
}