import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pcxd_app/model/pc/gabinete.dart';

class GabineteBuild extends StatefulWidget {
  GabineteBuild(this.gabinete, this.onTap, this.currentgabinete);
  Gabinete gabinete;
  Function onTap;
  String currentgabinete;

  @override
  State<GabineteBuild> createState() => _GabineteBuildState();
}

class _GabineteBuildState extends State<GabineteBuild> {
  double buildOpacity = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100)).then((value){
      setState(() {
        buildOpacity = 1;
      });
    });
  }

  Color borderColor(){

    if(widget.currentgabinete == 'null'){
      return Colors.transparent;
    } else if(widget.gabinete.modelo == widget.currentgabinete){
      return const Color.fromARGB(255, 127, 30, 255);
    } else {
      return Colors.transparent;
    }

  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: buildOpacity,
      duration: const Duration(seconds: 1),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(99, 12, 0, 29).withOpacity(0.4),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: borderColor(),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: widget.gabinete.imagem != null ? DecorationImage(image: NetworkImage(widget.gabinete.imagem)) : null
                ),
                child: widget.gabinete.imagem != null ? Container() : SvgPicture.asset('assets/pc.svg', color: Colors.white),
              ),
              const SizedBox(height: 5,),
              Text(widget.gabinete.modelo, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),),
              Text(widget.gabinete.marca, style: const TextStyle(fontSize: 11,),),
              Text('R\$ ${widget.gabinete.preco}', style: const TextStyle(fontSize: 11,),),
            ],
          ),
        ),
      ),
    );
  }
}