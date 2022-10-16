import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pcxd_app/model/pc/cpu.dart';
import 'package:pcxd_app/model/pc/pc.dart';
import 'package:pcxd_app/screens/montar_setup/cpu/cpu_build.dart';
import 'package:pcxd_app/screens/montar_setup/cpu/cpu_head.dart';
import 'package:pcxd_app/screens/montar_setup/widgets/scaffold_estrutura.dart';

class SelecionarProcessador extends StatefulWidget {
  SelecionarProcessador(this.pc, this.pageController,);
  PC pc;
  PageController pageController;
  Title tile;

  @override
  State<SelecionarProcessador> createState() => _SelecionarProcessadorState();
}

class _SelecionarProcessadorState extends State<SelecionarProcessador> {
  Query queryCpu;
  double opacity = 0;
  double buttonOpacity = 0;
  double buttonOpacityBackButton = 0;

  _adicionarListenerCPU(){

    queryCpu = FirebaseFirestore.instance.collection('cpu')
    .where('Tipo', isEqualTo: widget.pc.performance)
    .orderBy('Benchmark', descending: true)
    .withConverter<CPU>(fromFirestore: (snapshot, _)=> CPU.fromDocumentSnapshot(snapshot),
    );

  }

  @override
  void initState() {
    widget.pc.cpuObj.marca = null;
    widget.pc.cpuObj.modelo = null;
    widget.pc.cpuObj.socket = '';
    widget.pc.cpuObj.cores = 0;
    widget.pc.cpuObj.threads = 0;
    widget.pc.cpuObj.clock = 0;
    widget.pc.cpuObj.turboClock = 0;
    widget.pc.cpuObj.energia = 0;
    widget.pc.cpuObj.benchmark = 0;
    super.initState();
    Future.delayed(const Duration(milliseconds: 1300)).then((value){
      setState(() {
        opacity = 1;
        buttonOpacityBackButton = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldHardwareSelect(
      title: 'Selecione seu Processador',
      listener: _adicionarListenerCPU(),
      query: queryCpu,
      head: AnimatedOpacity(
        duration: const Duration(seconds: 1),
        opacity: opacity,
        curve: Curves.ease,
        child: CpuHead(widget.pc.cpuObj)
      ),
      itemBuilder: (context, snapshot, animation, index){
        final cpu = snapshot.data();
        return CpuBuild(
          cpu,
          (){
            setState(() {
              widget.pc.cpuObj = cpu;
              widget.pc.placamaeObj.plataforma = cpu.marca;
            });
            Future.delayed(const Duration(milliseconds: 100)).then((value){
              setState(() {
                buttonOpacity = 1;
              });
            });
          },
          widget.pc.cpuObj.modelo
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
          widget.pc.cpuObj.marca == null ?
          Container():
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
                    setState(() {
                      widget.pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
                    });
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
        ],
      ),
    );
  }
}