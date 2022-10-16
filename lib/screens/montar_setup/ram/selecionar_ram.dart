import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pcxd_app/model/pc/pc.dart';
import 'package:pcxd_app/model/pc/ram.dart';
import 'package:pcxd_app/screens/montar_setup/ram/ram_build.dart';
import 'package:pcxd_app/screens/montar_setup/ram/ram_head.dart';
import 'package:pcxd_app/screens/montar_setup/widgets/scaffold_estrutura.dart';

class SelecionarRam extends StatefulWidget {
  SelecionarRam(this.pc, this.pageController);
  PC pc;
  PageController pageController;

  @override
  State<SelecionarRam> createState() => _SelecionarRamState();
}

class _SelecionarRamState extends State<SelecionarRam> {
  Query queryram;
  double opacity = 0;
  double buttonOpacity = 0;
  int quantidade = 0;
  double buttonOpacityBackButton = 0;

  _adicionarListenerRam(){

    queryram = FirebaseFirestore.instance.collection('ram')
    .where('Tipo', isEqualTo: widget.pc.placamaeObj.tipoMemoria)
    .withConverter<RAM>(fromFirestore: (snapshot, _)=> RAM.fromDocumentSnapshot(snapshot),
    );

  }

  @override
  void initState() {
    super.initState();
    quantidade = 0;
    widget.pc.ramObj.clear();
    widget.pc.ramObj.add(RAM());

    Future.delayed(const Duration(milliseconds: 1300)).then((value){
      setState(() {
        opacity = 1;
        buttonOpacityBackButton = 1;
      });
    });
  }

  _increment(){
    if(widget.pc.ramObj.length < widget.pc.placamaeObj.slotsRam){
      setState(() {
        widget.pc.ramObj.add(widget.pc.ramObj[0]);
        quantidade = widget.pc.ramObj.length;
      });
      print(widget.pc.ramObj.length);
    }
  }

  _decrement(){
    if(widget.pc.ramObj.length > 1){
      setState(() {
        widget.pc.ramObj.removeLast();
        quantidade = widget.pc.ramObj.length;
      });
      print(widget.pc.ramObj.length);
    }
  }

  @override
  Widget build(BuildContext context) {


    var controlRAM =
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: (){
            _decrement();
          },
          icon: const Icon(Icons.remove_rounded, color: Colors.white,)
        ),
        const SizedBox(width: 10,),
        Text('$quantidade/${widget.pc.placamaeObj.slotsRam}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        const SizedBox(width: 10,),
        IconButton(
          onPressed: (){
            _increment();
          },
          icon: const Icon(Icons.add_rounded, color: Colors.white,)
        ),
      ],
    );


    return ScaffoldHardwareSelect(
      title: 'Selecione suas Memórias RAM',
      listener: _adicionarListenerRam(),
      query: queryram,
      head: AnimatedOpacity(
        duration: const Duration(seconds: 1),
        opacity: opacity,
        curve: Curves.ease,
        child: RamHead(widget.pc.ramObj, widget.pc, controlRAM)
      ),
      itemBuilder: (context, snapshot, animation, index){
        final ram = snapshot.data();
        return RamBuild(
          ram,
          (){
            if(widget.pc.ramObj[0].modelo !=  ram.modelo){
              setState(() {
                quantidade = 1;
                widget.pc.ramObj.clear();
                widget.pc.ramObj.add(ram);
              });
            }
            Future.delayed(const Duration(milliseconds: 100)).then((value){
              setState(() {
                buttonOpacity = 1;
              });
            });
          },
          widget.pc.ramObj[0].modelo,
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
          widget.pc.ramObj == null ?
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