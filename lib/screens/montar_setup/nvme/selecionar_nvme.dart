import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pcxd_app/model/pc/nvme.dart';
import 'package:pcxd_app/model/pc/pc.dart';
import 'package:pcxd_app/screens/montar_setup/nvme/nvme_build.dart';
import 'package:pcxd_app/screens/montar_setup/nvme/nvme_head.dart';
import 'package:pcxd_app/screens/montar_setup/widgets/scaffold_estrutura.dart';

class SelecionarNvme extends StatefulWidget {
  SelecionarNvme(this.pc, this.pageController);
  PC pc;
  PageController pageController;

  @override
  State<SelecionarNvme> createState() => _SelecionarNvmeState();
}

class _SelecionarNvmeState extends State<SelecionarNvme> {
  Query querynvme;
  double opacity = 0;
  double buttonOpacity = 0;
  int quantidade = 0;
  double buttonOpacityBackButton = 0;

  _adicionarListenernvme(){
    
    querynvme = FirebaseFirestore.instance.collection('nvme')
    .withConverter<NVME>(fromFirestore: (snapshot, _)=> NVME.fromDocumentSnapshot(snapshot),
    );

  }

  _increment(){
    if(widget.pc.nvmeObj.length < widget.pc.placamaeObj.nvmeSlots){
      setState(() {
        widget.pc.nvmeObj.add(widget.pc.nvmeObj[0]);
        quantidade = widget.pc.nvmeObj.length;
      });
      print(widget.pc.nvmeObj.length);
    }
  }

  _decrement(){
    if(widget.pc.nvmeObj.length > 1){
      setState(() {
        widget.pc.nvmeObj.removeLast();
        quantidade = widget.pc.nvmeObj.length;
      });
      print(widget.pc.nvmeObj.length);
    }
  }

  @override
  void initState() {
    super.initState();
    quantidade = 0;
    widget.pc.nvmeObj.clear();
    widget.pc.nvmeObj.add(NVME());
    Future.delayed(const Duration(milliseconds: 1300)).then((value){
      setState(() {
        opacity = 1;
        buttonOpacity = 1;
        buttonOpacityBackButton = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    var controlnvme =
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
        Text('$quantidade/${widget.pc.placamaeObj.nvmeSlots}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
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
      title: 'Selecione seus SSD\'s NVME',
      listener: _adicionarListenernvme(),
      disabled: widget.pc.placamaeObj.nvmeSlots == 0 ? true : false,
      disabledText: 'Sua placa-mãe não possui slots para NVME.',
      query: querynvme,
      head: AnimatedOpacity(
        duration: const Duration(seconds: 1),
        opacity: opacity,
        curve: Curves.ease,
        child: NVMEHead(widget.pc.nvmeObj, widget.pc, controlnvme),
      ),
      itemBuilder: (context, snapshot, animation, index){
        final nvme = snapshot.data();
        return NVMEBuild(
          nvme,
          (){
            if(widget.pc.nvmeObj[0].modelo !=  nvme.modelo){
              setState(() {
                quantidade = 1;
                widget.pc.nvmeObj.clear();
                widget.pc.nvmeObj.add(nvme);
              });
            }
            Future.delayed(const Duration(milliseconds: 100)).then((value){
              setState(() {
                buttonOpacity = 1;
              });
            });
          },
          widget.pc.nvmeObj[0].modelo,
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