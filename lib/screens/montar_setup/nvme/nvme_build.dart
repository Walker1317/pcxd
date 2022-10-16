import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pcxd_app/model/pc/nvme.dart';

class NVMEBuild extends StatefulWidget {
  NVMEBuild(this.nvme, this.onTap, this.currentnvme,);
  Function onTap;
  String currentnvme;
  NVME nvme;

  @override
  State<NVMEBuild> createState() => _NVMEBuildState();
}

class _NVMEBuildState extends State<NVMEBuild> {
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

    if(widget.currentnvme == null){
      return Colors.transparent;
    } else if(widget.nvme.modelo == widget.currentnvme){
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
                  image: widget.nvme.imagem != null ? DecorationImage(image: NetworkImage(widget.nvme.imagem)) : null
                ),
                child: widget.nvme.imagem != null ? Container() : SvgPicture.asset('assets/ssd.svg', color: Colors.white),
              ),
              Text('${widget.nvme.capacidade}GB', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
              Text(widget.nvme.modelo, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
              Text('R\$ ${widget.nvme.preco}', style: const TextStyle(fontSize: 11,),),
            ],
          ),
        ),
      ),
    );
  }
}