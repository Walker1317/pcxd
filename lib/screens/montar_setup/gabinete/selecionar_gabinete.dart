import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pcxd_app/model/pc/gabinete.dart';
import 'package:pcxd_app/model/pc/pc.dart';
import 'package:pcxd_app/screens/montar_setup/gabinete/gabinete_build.dart';
import 'package:pcxd_app/screens/montar_setup/gabinete/gabinete_head.dart';
import 'package:pcxd_app/screens/montar_setup/widgets/scaffold_estrutura.dart';
import 'package:pcxd_app/scripts/ads_services.dart';

class SelecionarGabinete extends StatefulWidget {
  SelecionarGabinete(this.pc, this.pageController);
  PC pc;
  PageController pageController;

  @override
  State<SelecionarGabinete> createState() => _SelecionarGabineteState();
}

class _SelecionarGabineteState extends State<SelecionarGabinete> {
  Query querygabinete;
  double opacity = 0;
  double buttonOpacity = 0;
  double buttonOpacityBackButton = 0;

  _adicionarListenergabinete(){

    querygabinete = FirebaseFirestore.instance.collection('gabinete')
    .withConverter<Gabinete>(fromFirestore: (snapshot, _)=> Gabinete.fromDocumentSnapshot(snapshot),
    );

  }

  @override
  void initState() {
    super.initState();
    widget.pc.gabineteObj.marca = null;
    widget.pc.gabineteObj.modelo = null;
    widget.pc.gabineteObj.preco = null;
    widget.pc.gabineteObj.imagem = null;

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
      title: 'Selecione seu Gabinete',
      listener: _adicionarListenergabinete(),
      query: querygabinete,
      head: AnimatedOpacity(
        duration: const Duration(seconds: 1),
        opacity: opacity,
        curve: Curves.ease,
        child: GabineteHead(widget.pc.gabineteObj),
      ),
      itemBuilder: (context, snapshot, animation, index){
        final gabinete = snapshot.data();
        return GabineteBuild(
          gabinete,
          (){
            setState(() {
              widget.pc.gabineteObj= gabinete;
            });
            Future.delayed(const Duration(milliseconds: 100)).then((value){
              setState(() {
                buttonOpacity = 1;
              });
            });
          },
          widget.pc.gabineteObj.modelo
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
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context){

                        return Center(
                          child: Card(
                            color: const Color.fromARGB(255, 24, 0, 46),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            child: const Padding(
                              padding: EdgeInsets.all(40),
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );

                      }
                    );

                    //original: ca-app-pub-1965282695850964/3613368762
                    //teste: ca-app-pub-3940256099942544/1033173712
                    //teste video: ca-app-pub-3940256099942544/8691691433

                    AdsServices().showIntersitalAd().then((value){
                      Future.delayed(const Duration(seconds: 1)).then((value){
                        Navigator.of(context).pop();
                        Navigator.pushReplacementNamed(context, '/pcFinal', arguments: widget.pc);
                      });
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Finalizar'),
                      Icon(Icons.keyboard_arrow_right_rounded)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}


/*
showDialog(
                  
*/