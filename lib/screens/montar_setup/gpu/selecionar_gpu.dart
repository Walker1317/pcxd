import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pcxd_app/model/pc/gpu.dart';
import 'package:pcxd_app/model/pc/pc.dart';
import 'package:pcxd_app/screens/montar_setup/gpu/gpu_build.dart';
import 'package:pcxd_app/screens/montar_setup/gpu/gpu_head.dart';
import 'package:pcxd_app/screens/montar_setup/widgets/scaffold_estrutura.dart';

class SelecionarGPU extends StatefulWidget {
  SelecionarGPU(this.pc, this.pageController);
  PC pc;
  PageController pageController;

  @override
  State<SelecionarGPU> createState() => _SelecionarGPUState();
}

class _SelecionarGPUState extends State<SelecionarGPU> {
  Query querygpu;
  double opacity = 0;
  double buttonOpacity = 0;
  double buttonOpacityBackButton = 0;

  _adicionarListenergpu(){

    querygpu = FirebaseFirestore.instance.collection('gpu')
    .where('Tipo', isEqualTo: widget.pc.performance)
    .withConverter<GPU>(fromFirestore: (snapshot, _)=> GPU.fromDocumentSnapshot(snapshot),
    );

  }

  @override
  void initState() {
    widget.pc.gpuObj.marca = null;
    widget.pc.gpuObj.modelo = null;
    widget.pc.gpuObj.interface = '';
    widget.pc.gpuObj.coreClock = 0;
    widget.pc.gpuObj.memoryClock = 0;
    widget.pc.gpuObj.memory = 0;
    widget.pc.gpuObj.energia = 0;
    widget.pc.gpuObj.benchmark = 0;
    widget.pc.gpuObj.preco = 0;
    super.initState();
    Future.delayed(const Duration(milliseconds: 1300)).then((value){
      setState(() {
        opacity = 1;
        buttonOpacityBackButton = 1;
        buttonOpacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldHardwareSelect(
      title: 'Selecione sua Placa de Vídeo',
      listener: _adicionarListenergpu(),
      query: querygpu,
      head: AnimatedOpacity(
        duration: const Duration(seconds: 1),
        opacity: opacity,
        curve: Curves.ease,
        child: GPUHead(widget.pc.gpuObj)
      ),
      itemBuilder: (context, snapshot, animation, index){
        final gpu = snapshot.data();
        return GPUBuild(
          gpu,
          (){
            setState(() {
              widget.pc.gpuObj = gpu;
              widget.pc.placamaeObj.plataforma = gpu.marca;
            });
            Future.delayed(const Duration(milliseconds: 100)).then((value){
              setState(() {
                buttonOpacity = 1;
              });
            });
          },
          widget.pc.gpuObj.modelo
        );
      },
      button: Row(
        children: [
          AnimatedOpacity(
            opacity: buttonOpacityBackButton,
            duration: const Duration(milliseconds: 300),
            child: SizedBox(
              height: 70,
              width: 70,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder()
                  ),
                  onPressed: (){
                    widget.pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
                  },
                  child: const Icon(Icons.keyboard_arrow_left_rounded)
                ),
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: buttonOpacity,
            duration: const Duration(milliseconds: 300),
            child: SizedBox(
              height: 70,
              width: 330,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: (){
                    widget.pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Próximo'),
                      Icon(Icons.keyboard_arrow_right_rounded)
                    ],
                  )
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}