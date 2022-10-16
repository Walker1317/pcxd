import 'package:flutter/material.dart';
import 'package:pcxd_app/model/pc/cpu.dart';

class CpuBuild extends StatefulWidget {
  CpuBuild(this.cpu, this.onTap, this.currentCpu);
  CPU cpu;
  Function onTap;
  String currentCpu;

  @override
  State<CpuBuild> createState() => _CpuBuildState();
}

class _CpuBuildState extends State<CpuBuild> {
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

    if(widget.currentCpu == 'null'){
      return Colors.transparent;
    } else if(widget.cpu.modelo == widget.currentCpu){
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
                  image: DecorationImage(image: AssetImage(widget.cpu.marca == 'Intel' ? 'images/intel_cpu.png' : 'images/amd_cpu.png'))
                ),
              ),
              const SizedBox(height: 5,),
              Text(widget.cpu.modelo, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),),
              Text('Bm: ${widget.cpu.benchmark}', style: const TextStyle(fontSize: 11,),),
              Text('R\$ ${widget.cpu.preco}', style: const TextStyle(fontSize: 11,),),
            ],
          ),
        ),
      ),
    );
  }
}