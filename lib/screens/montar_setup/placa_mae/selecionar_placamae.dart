import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pcxd_app/model/pc/pc.dart';
import 'package:pcxd_app/model/pc/placamae.dart';
import 'package:pcxd_app/screens/montar_setup/placa_mae/placamae_build.dart';
import 'package:pcxd_app/screens/montar_setup/placa_mae/placamae_head.dart';
import 'package:pcxd_app/screens/montar_setup/widgets/scaffold_estrutura.dart';

class SelecionarPlacaMae extends StatefulWidget {
  SelecionarPlacaMae(this.pc, this.pageController,);
  PC pc;
  PageController pageController;
  Title tile;

  @override
  State<SelecionarPlacaMae> createState() => _SelecionarPlacaMaeState();
}

class _SelecionarPlacaMaeState extends State<SelecionarPlacaMae> {
  Query queryPlacamae;
  double opacity = 0;
  double buttonOpacity = 0;
  double buttonOpacityBackButton = 0;

  _adicionarListenerPlacaMae(){

    queryPlacamae = FirebaseFirestore.instance.collection('placamae')
    .where('Socket', isEqualTo: widget.pc.cpuObj.socket)
    .withConverter<Placamae>(fromFirestore: (snapshot, _)=> Placamae.fromDocumentSnapshot(snapshot),
    );

  }

  @override
  void initState() {
    super.initState();
    widget.pc.placamaeObj.marca = null;
    widget.pc.placamaeObj.modelo = null;
    widget.pc.placamaeObj.tipoMemoria = null;
    widget.pc.placamaeObj.socket = null;
    widget.pc.placamaeObj.imagem = null;
    widget.pc.placamaeObj.preco = null;
    widget.pc.placamaeObj.slotsRam = null;
    widget.pc.placamaeObj.nvmeSlots = null;
    widget.pc.placamaeObj.sata = null;
    widget.pc.placamaeObj.pcie16 = null;
    widget.pc.placamaeObj.plataforma = widget.pc.cpuObj.marca;

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
      title: 'Selecione sua Placa-Mãe',
      listener: _adicionarListenerPlacaMae(),
      query: queryPlacamae,
      head: AnimatedOpacity(
        duration: const Duration(seconds: 1),
        opacity: opacity,
        curve: Curves.ease,
        child: PlacaMaeHead(widget.pc.placamaeObj),
      ),
      itemBuilder: (context, snapshot, animation, index){
        final placaMae = snapshot.data();
        return PlacaMaeBuild(
          placaMae,
          (){
            setState(() {
              widget.pc.placamaeObj= placaMae;
            });
            Future.delayed(const Duration(milliseconds: 100)).then((value){
              setState(() {
                buttonOpacity = 1;
              });
            });
          },
          widget.pc.placamaeObj.modelo
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
          widget.pc.placamaeObj.marca == null ?
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
                      Text('PRÓXIMO'),
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