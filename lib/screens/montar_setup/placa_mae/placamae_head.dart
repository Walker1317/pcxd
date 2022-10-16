import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pcxd_app/model/pc/placamae.dart';

class PlacaMaeHead extends StatefulWidget {
  PlacaMaeHead(this.placamae);
  Placamae placamae;

  @override
  State<PlacaMaeHead> createState() => _PlacaMaeHeadState();
}

class _PlacaMaeHeadState extends State<PlacaMaeHead> {

  Color color(){
    
    if(widget.placamae.plataforma == 'Intel'){
      return Colors.blue;
    } else if(widget.placamae.plataforma == 'AMD'){
      return Colors.red;
    } else {
      return Colors.white;
    }
  }

  @override
  void initState() {
    super.initState();
    if(widget.placamae.marca == null){
      widget.placamae.socket = '';
      widget.placamae.marca = '';
      widget.placamae.modelo = 'Modelo';
      widget.placamae.tipoMemoria = '';
      widget.placamae.slotsRam = 0;
      widget.placamae.sata = 0;
      widget.placamae.pcie16 = 0;
      widget.placamae.nvmeSlots = 0;
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
                  image: widget.placamae.imagem != null ? DecorationImage(image: NetworkImage(widget.placamae.imagem), fit: BoxFit.scaleDown, scale: 6) : null
                ),
                child:
                widget.placamae.imagem != null ? Container():
                  SvgPicture.asset('assets/placamae.svg', color: color(),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.placamae.modelo ?? 'Modelo', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    Text('Marca: ${widget.placamae.marca}',),
                    Text('Socket: ${widget.placamae.socket}',),
                    Text('Plataforma: ${widget.placamae.plataforma}',),
                    Text('Memória: ${widget.placamae.tipoMemoria}',),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30,),
          Wrap(
            spacing: 30,
            alignment: WrapAlignment.center,
            children: [
              PlacaMaeInfoSession('RAM', widget.placamae.slotsRam.toString()),
              PlacaMaeInfoSession('PCIe x16', widget.placamae.pcie16.toString()),
              PlacaMaeInfoSession('NVME', widget.placamae.nvmeSlots.toString()),
              PlacaMaeInfoSession('SATA', widget.placamae.sata.toString()),
            ],
          )
        ],
      ),
    );
  }
}

class PlacaMaeInfoSession extends StatelessWidget {
  PlacaMaeInfoSession(this.title, this.value);
  String title;
  String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.amberAccent,),),
        Text('x$value', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
      ],
    );
  }
}