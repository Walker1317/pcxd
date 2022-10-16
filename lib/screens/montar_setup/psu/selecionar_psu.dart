import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pcxd_app/model/pc/pc.dart';
import 'package:pcxd_app/model/pc/psu.dart';
import 'package:pcxd_app/screens/montar_setup/psu/psu_build.dart';
import 'package:pcxd_app/screens/montar_setup/psu/psu_head.dart';
import 'package:pcxd_app/screens/montar_setup/widgets/scaffold_estrutura.dart';

class SelecionarPSU extends StatefulWidget {
  SelecionarPSU(this.pc, this.pageController);
  PC pc;
  PageController pageController;

  @override
  State<SelecionarPSU> createState() => _SelecionarPSUState();
}

class _SelecionarPSUState extends State<SelecionarPSU> {
  Query querypsu;
  double opacity = 0;
  double buttonOpacity = 0;
  int energia = 0;
  double buttonOpacityBackButton = 0;

  _adicionarListenerpsu(){
    energia = widget.pc.cpuObj.energia + widget.pc.gpuObj.energia;
    energia = energia+100;

    if(widget.pc.ssdObj.length > 3){
      energia+100;
    }

    print('Potencia necessária: $energia');

    querypsu = FirebaseFirestore.instance.collection('psu')
    .where('Potencia', isGreaterThanOrEqualTo: energia)
    .withConverter<PSU>(fromFirestore: (snapshot, _)=> PSU.fromDocumentSnapshot(snapshot),
    );

  }

  @override
  void initState() {
    super.initState();
    widget.pc.psuObj.marca = null;
    widget.pc.psuObj.modelo = null;
    widget.pc.psuObj.potencia = null;
    widget.pc.psuObj.preco = null;
    widget.pc.psuObj.imagem = null;

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
      title: 'Selecione sua Fonte de Alimentação',
      listener: _adicionarListenerpsu(),
      query: querypsu,
      head: AnimatedOpacity(
        duration: const Duration(seconds: 1),
        opacity: opacity,
        curve: Curves.ease,
        child: PSUHead(widget.pc.psuObj, energia),
      ),
      itemBuilder: (context, snapshot, animation, index){
        final psu = snapshot.data();
        return PSUBuild(
          psu,
          (){
            setState(() {
              widget.pc.psuObj= psu;
            });
            Future.delayed(const Duration(milliseconds: 100)).then((value){
              setState(() {
                buttonOpacity = 1;
              });
            });
          },
          widget.pc.psuObj.modelo
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
          widget.pc.psuObj.marca == null?
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