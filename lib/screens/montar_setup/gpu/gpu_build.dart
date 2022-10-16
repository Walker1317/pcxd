import 'package:flutter/material.dart';
import 'package:pcxd_app/model/pc/gpu.dart';

class GPUBuild extends StatefulWidget {
  GPUBuild(this.gpu, this.onTap, this.currentGpu);
  GPU gpu;
  Function onTap;
  String currentGpu;

  @override
  State<GPUBuild> createState() => _GPUBuildState();
}

class _GPUBuildState extends State<GPUBuild> {
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

    if(widget.currentGpu == 'null'){
      return Colors.transparent;
    } else if(widget.gpu.modelo == widget.currentGpu){
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
          height: 400,
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
                margin: const EdgeInsets.only(top: 20),
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(widget.gpu.marca == 'NVidia' ? 'images/nvidia_gpu.png' : 'images/amd_gpu.png'))
                ),
              ),
              const SizedBox(height: 5,),
              Text(widget.gpu.modelo, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              Text('Bm: ${widget.gpu.benchmark}', style: const TextStyle(fontSize: 11,),),
              Text('R\$ ${widget.gpu.preco}', style: const TextStyle(fontSize: 11,),),
            ],
          ),
        ),
      ),
    );
  }
}