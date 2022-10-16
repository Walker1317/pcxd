import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pcxd_app/model/pc/psu.dart';

class PSUHead extends StatefulWidget {
  PSUHead(this.psu, this.energiaRecomendada);
  PSU psu;
  int energiaRecomendada;

  @override
  State<PSUHead> createState() => _PSUHeadState();
}

class _PSUHeadState extends State<PSUHead> {
  Color color(){

    if(widget.psu.potencia == 0){
      return Colors.white;
    } else{
      return const Color.fromARGB(255, 127, 30, 255);
    }

  }

  @override
  void initState() {
    super.initState();
    if(widget.psu.marca == null){
      widget.psu.potencia= 0;
      widget.psu.marca = '';
      widget.psu.modelo = 'Modelo';
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
                  image: widget.psu.imagem != null ? DecorationImage(image: NetworkImage(widget.psu.imagem), fit: BoxFit.scaleDown, scale: 6) : null
                ),
                child:
                widget.psu.imagem != null ? Container():
                  SvgPicture.asset('assets/psu.svg', color: color(),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.psu.modelo ?? 'Modelo', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    Text('Marca: ${widget.psu.marca}',),
                    Text('Potencia: ${widget.psu.potencia}W',),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          const Text('Potencia recomendada / Potencia atual', textAlign: TextAlign.center, style: TextStyle(color: Color.fromARGB(255, 207, 170, 255), fontSize: 10),),
          const SizedBox(height: 5,),
          Text('${widget.energiaRecomendada}W / ${widget.psu.potencia}W', textAlign: TextAlign.center, style: const TextStyle(color: Colors.amberAccent, fontSize: 26),),
        ],
      ),
    );
  }
}