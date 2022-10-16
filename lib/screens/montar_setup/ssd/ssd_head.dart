import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pcxd_app/model/pc/pc.dart';
import 'package:pcxd_app/model/pc/ssd.dart';

class SSDHead extends StatefulWidget {
  SSDHead(this.listSSD, this.pc, this.controlSSD);
  List<SSD> listSSD;
  PC pc;
  Widget controlSSD;

  @override
  State<SSDHead> createState() => _SSDHeadState();
}

class _SSDHeadState extends State<SSDHead> {
  
  @override
  void initState() {
    super.initState();
    if(widget.listSSD[0].modelo == null){

      widget.listSSD[0];
      widget.listSSD[0].capacidade = 0;
      widget.listSSD[0].marca = 'Marca';
      widget.listSSD[0].modelo = 'Modelo';
      widget.listSSD[0].preco = 0;

    }
  }

  Color color(){

    if(widget.listSSD[0].capacidade == 0){
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
                  image: widget.listSSD[0].imagem != null ? DecorationImage(image: NetworkImage(widget.listSSD[0].imagem), fit: BoxFit.scaleDown, scale: 6) : null
                ),
                child:
                widget.listSSD[0].imagem != null ? Container():
                  SvgPicture.asset('assets/ssd.svg', color: Colors.white,),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.listSSD[0].modelo ?? 'Modelo', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    Text('Marca: ${widget.listSSD[0].marca}',),
                    Text('Capacidade: ${widget.listSSD[0].capacidade}GB',),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30,),
          widget.pc.ssdObj[0].capacidade == 0 ?
          Container(): 
          widget.controlSSD
        ],
      ),
    );
  }
}