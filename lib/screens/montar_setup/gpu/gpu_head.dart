import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pcxd_app/model/pc/gpu.dart';

class GPUHead extends StatefulWidget {
  GPUHead(this.gpu);
  GPU gpu;

  @override
  State<GPUHead> createState() => _GPUHeadState();
}

class _GPUHeadState extends State<GPUHead> {
  
  String image(){

    if(widget.gpu.marca == 'NVidia'){
      return 'images/nvidia_gpu.png';
    } else if(widget.gpu.marca == 'AMD'){
      return 'images/amd_gpu.png';
    }

  }

  Color color(){
    if(widget.gpu.marca == null){
      return Colors.white;
    } else if(widget.gpu.marca == 'NVidia'){
      return Colors.greenAccent[400];
    } else if(widget.gpu.marca == 'AMD'){
      return Colors.red;
    }
  }

  @override
  void initState() {
    super.initState();
    if(widget.gpu.marca == null){
      widget.gpu.tipo = '';
      widget.gpu.interface = '';
      widget.gpu.coreClock = 0;
      widget.gpu.memoryClock = 0;
      widget.gpu.memory = 0;
      widget.gpu.energia = 0;
      widget.gpu.benchmark = 0;
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
                  image: widget.gpu.modelo != null ? DecorationImage(image: AssetImage(image()), fit: BoxFit.scaleDown, scale: 12): null,
                  border: Border.all(
                    color: color()
                  ),
                ),
                child: widget.gpu.marca != null?
                  Container():
                  SvgPicture.asset('assets/gpu.svg', color: Colors.white,),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.gpu.modelo ?? 'Modelo', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    Text('Clock: ${widget.gpu.coreClock} Mhz',),
                    Text('Memória: ${widget.gpu.memory}',),
                    Text('Clock de memória: ${widget.gpu.memoryClock} Mhz'),
                    Text('Energia: ${widget.gpu.energia}W',),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15,),
          const Text('Benchmark', style: TextStyle(fontSize: 12), textAlign: TextAlign.center,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.speed_rounded, color: Colors.amberAccent, size: 40,),
              const SizedBox(width: 10,),
              Text(widget.gpu.benchmark.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.amberAccent),),
            ],
          )
        ],
      ),
    );
  }
}