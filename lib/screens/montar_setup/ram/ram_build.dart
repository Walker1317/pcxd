import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pcxd_app/model/pc/ram.dart';

class RamBuild extends StatefulWidget {
  RamBuild(this.ram, this.onTap, this.currentRam,);
  Function onTap;
  String currentRam;
  RAM ram;

  @override
  State<RamBuild> createState() => _RamBuildState();
}

class _RamBuildState extends State<RamBuild> {
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

    if(widget.currentRam == null){
      return Colors.transparent;
    } else if(widget.ram.modelo == widget.currentRam){
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
                padding: const EdgeInsets.all(15),
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  image: widget.ram.imagem != null ? DecorationImage(image: NetworkImage(widget.ram.imagem)) : null
                ),
                child: widget.ram.imagem != null ? Container() : SvgPicture.asset('assets/ram.svg', color: Colors.white),
              ),
              Text('${widget.ram.capacidade}GB', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
              Text(widget.ram.modelo, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),),
              Text(widget.ram.marca, style: const TextStyle(fontSize: 11,),),
              Text('R\$ ${widget.ram.preco}', style: const TextStyle(fontSize: 11,),),
            ],
          ),
        ),
      ),
    );
  }
}