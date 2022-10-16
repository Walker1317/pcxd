import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pcxd_app/model/pc/placamae.dart';

class PlacaMaeBuild extends StatefulWidget {
  PlacaMaeBuild(this.placamae, this.onTap, this.currentPlacamae);
  Placamae placamae;
  Function onTap;
  String currentPlacamae;

  @override
  State<PlacaMaeBuild> createState() => _PlacaMaeBuildState();
}

class _PlacaMaeBuildState extends State<PlacaMaeBuild> {
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

    if(widget.currentPlacamae == 'null'){
      return Colors.transparent;
    } else if(widget.placamae.modelo == widget.currentPlacamae){
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
                  image: widget.placamae.imagem != null ? DecorationImage(image: NetworkImage(widget.placamae.imagem)) : null
                ),
                child: widget.placamae.imagem != null ? Container() : SvgPicture.asset('assets/placamae.svg', color: Colors.white),
              ),
              const SizedBox(height: 5,),
              Text(widget.placamae.modelo, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),),
              Text(widget.placamae.marca, style: const TextStyle(fontSize: 11,),),
              Text('R\$ ${widget.placamae.preco}', style: const TextStyle(fontSize: 11,),),
            ],
          ),
        ),
      ),
    );
  }
}