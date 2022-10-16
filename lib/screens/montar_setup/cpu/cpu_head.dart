import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pcxd_app/model/pc/cpu.dart';

class CpuHead extends StatefulWidget {
  CpuHead(this.cpu);
  CPU cpu;

  @override
  State<CpuHead> createState() => _CpuHeadState();
}

class _CpuHeadState extends State<CpuHead> {

  String image(){

    if(widget.cpu.marca == 'Intel'){
      return 'images/intel_cpu.png';
    } else if(widget.cpu.marca == 'AMD'){
      return 'images/amd_cpu.png';
    }

  }

  Color color(){
    if(widget.cpu.marca == null){
      return Colors.white;
    } else if(widget.cpu.marca == 'Intel'){
      return Colors.blue;
    } else if(widget.cpu.marca == 'AMD'){
      return Colors.red;
    }
  }

  @override
  void initState() {
    super.initState();
    if(widget.cpu.marca == null){
      widget.cpu.socket = '';
      widget.cpu.cores = 0;
      widget.cpu.threads = 0;
      widget.cpu.clock = 0;
      widget.cpu.turboClock = 0;
      widget.cpu.energia = 0;
      widget.cpu.benchmark = 0;
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
                  image: widget.cpu.modelo != null ? DecorationImage(image: AssetImage(image()), fit: BoxFit.scaleDown, scale: 12): null,
                  border: Border.all(
                    color: color()
                  ),
                ),
                child: widget.cpu.marca != null?
                  Container():
                  SvgPicture.asset('assets/cpu.svg', color: Colors.white,),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.cpu.modelo ?? 'Modelo', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    Text('Socket: ${widget.cpu.socket}',),
                    Text('Clock: ${widget.cpu.clock} GHZ | Turbo: ${widget.cpu.turboClock} GHZ',),
                    Text('Cores: ${widget.cpu.cores} | Threads: ${widget.cpu.threads}',),
                    Text('Energia: ${widget.cpu.energia}W',),
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
              Text(widget.cpu.benchmark.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.amberAccent),),
            ],
          )
        ],
      ),
    );
  }
}