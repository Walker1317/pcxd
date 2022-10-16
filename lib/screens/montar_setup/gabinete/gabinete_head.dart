import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pcxd_app/model/pc/gabinete.dart';

class GabineteHead extends StatefulWidget {
  GabineteHead(this.gabinete);
  Gabinete gabinete;

  @override
  State<GabineteHead> createState() => _GabineteHeadState();
}

class _GabineteHeadState extends State<GabineteHead> {
  Color color(){

    if(widget.gabinete.marca == ''){
      return Colors.white;
    } else{
      return const Color.fromARGB(255, 127, 30, 255);
    }

  }

  @override
  void initState() {
    super.initState();
    if(widget.gabinete.marca == null){
      widget.gabinete.marca = '';
      widget.gabinete.modelo = 'Modelo';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.gabinete.imagem == null ? Container():
        Align(
          alignment: Alignment.topRight,
          child: AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: 0.1,
            child: Image.network(
              widget.gabinete.imagem,
              fit: BoxFit.scaleDown,
              scale: 2,
            ),
          ),
        ),
        Container(
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
                      color: const Color.fromARGB(99, 12, 0, 29).withOpacity(0.8),
                      border: Border.all(
                        color: color()
                      ),
                      image: widget.gabinete.imagem != null ? DecorationImage(image: NetworkImage(widget.gabinete.imagem), fit: BoxFit.scaleDown, scale: 6) : null
                    ),
                    child:
                    widget.gabinete.imagem != null ? Container():
                      SvgPicture.asset('assets/pc.svg', color: color(),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.gabinete.modelo ?? 'Modelo', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                        Text('Marca: ${widget.gabinete.marca}',),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}