import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pcxd_app/model/pc/pc.dart';
import 'package:pcxd_app/model/pc/ssd.dart';
import 'package:pcxd_app/screens/montar_setup/widgets/scaffold_estrutura.dart';
import 'package:pcxd_app/screens/montar_setup/ssd/ssd_build.dart';
import 'package:pcxd_app/screens/montar_setup/ssd/ssd_head.dart';

class SelecionarSSD extends StatefulWidget {
  SelecionarSSD(this.pc, this.pageController);
  PC pc;
  PageController pageController;

  @override
  State<SelecionarSSD> createState() => _SelecionarSSDState();
}

class _SelecionarSSDState extends State<SelecionarSSD> {
  Query queryssd;
  double opacity = 0;
  double buttonOpacity = 0;
  int quantidade = 0;
  bool next = false;
  double buttonOpacityBackButton = 0;

  _adicionarListenerssd(){

    queryssd = FirebaseFirestore.instance.collection('ssd')
    .withConverter<SSD>(fromFirestore: (snapshot, _)=> SSD.fromDocumentSnapshot(snapshot),
    );

  }

  _increment(){
    if(widget.pc.ssdObj.length < widget.pc.placamaeObj.sata){
      setState(() {
        widget.pc.ssdObj.add(widget.pc.ssdObj[0]);
        quantidade = widget.pc.ssdObj.length;
      });
      print(widget.pc.ssdObj.length);
    }
  }

  _decrement(){
    if(widget.pc.ssdObj.length > 1){
      setState(() {
        widget.pc.ssdObj.removeLast();
        quantidade = widget.pc.ssdObj.length;
      });
      print(widget.pc.ssdObj.length);
    }
  }

  identificarSSD(){
    if(widget.pc.nvmeObj[0].capacidade != 0){
      setState(() {
        next = true;
        print(next);
        Future.delayed(const Duration(milliseconds: 100)).then((value){
          setState(() {
            buttonOpacity = 1;
          });
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    quantidade = 0;
    widget.pc.ssdObj.clear();
    widget.pc.ssdObj.add(SSD());
    Future.delayed(const Duration(milliseconds: 1300)).then((value){
      setState(() {
        opacity = 1;
        buttonOpacityBackButton = 1;
        identificarSSD();
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    var controlSSD =
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
        Text('$quantidade/${widget.pc.placamaeObj.sata}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
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
      title: 'Selecione seus SSD\'s SATA',
      listener: _adicionarListenerssd(),
      query: queryssd,
      head: AnimatedOpacity(
        duration: const Duration(seconds: 1),
        opacity: opacity,
        curve: Curves.ease,
        child: SSDHead(widget.pc.ssdObj, widget.pc, controlSSD),
      ),
      itemBuilder: (context, snapshot, animation, index){
        final ssd = snapshot.data();
        return SsdBuild(
          ssd,
          (){
            if(widget.pc.ssdObj[0].modelo !=  ssd.modelo){
              setState(() {
                quantidade = 1;
                next = true;
                widget.pc.ssdObj.clear();
                widget.pc.ssdObj.add(ssd);
              });
            }
            Future.delayed(const Duration(milliseconds: 100)).then((value){
              setState(() {
                buttonOpacity = 1;
              });
            });
          },
          widget.pc.ssdObj[0].modelo,
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
          next == false?
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