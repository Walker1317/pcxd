import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pcxd_app/model/pc/ssd.dart';

class SsdBuild extends StatefulWidget {
  SsdBuild(this.ssd, this.onTap, this.currentSSD,);
  Function onTap;
  String currentSSD;
  SSD ssd;

  @override
  State<SsdBuild> createState() => _SsdBuildState();
}

class _SsdBuildState extends State<SsdBuild> {
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

    if(widget.currentSSD == null){
      return Colors.transparent;
    } else if(widget.ssd.modelo == widget.currentSSD){
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(15),
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  image: widget.ssd.imagem != null ? DecorationImage(image: NetworkImage(widget.ssd.imagem)) : null
                ),
                child: widget.ssd.imagem != null ? Container() : SvgPicture.asset('assets/ssd.svg', color: Colors.white),
              ),
              Text('${widget.ssd.capacidade}GB', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
              Text(widget.ssd.modelo, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
              Text('R\$ ${widget.ssd.preco}', style: const TextStyle(fontSize: 11,),),
            ],
          ),
        ),
      ),
    );
  }
}