import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pcxd_app/model/pc/psu.dart';

class PSUBuild extends StatefulWidget {
  PSUBuild(this.psu, this.onTap, this.currentpsu);
  PSU psu;
  Function onTap;
  String currentpsu;

  @override
  State<PSUBuild> createState() => _PSUBuildState();
}

class _PSUBuildState extends State<PSUBuild> {
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

    if(widget.currentpsu == 'null'){
      return Colors.transparent;
    } else if(widget.psu.modelo == widget.currentpsu){
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
                  image: widget.psu.imagem != null ? DecorationImage(image: NetworkImage(widget.psu.imagem)) : null
                ),
                child: widget.psu.imagem != null ? Container() : SvgPicture.asset('assets/psu.svg', color: Colors.white),
              ),
              const SizedBox(height: 5,),
              Text('${widget.psu.potencia}W', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),),
              Text(widget.psu.modelo, style: const TextStyle(fontSize: 10,),),
              Text('R\$ ${widget.psu.preco}', style: const TextStyle(fontSize: 11,),),
            ],
          ),
        ),
      ),
    );
  }
}