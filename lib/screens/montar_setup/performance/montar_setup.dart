import 'package:flutter/material.dart';
import 'package:pcxd_app/model/pc/pc.dart';

class MontarSetup extends StatefulWidget {
  MontarSetup(this.pc, this.pageController,);
  PC pc;
  PageController pageController;

  @override
  State<MontarSetup> createState() => _MontarSetupState();
}

class _MontarSetupState extends State<MontarSetup> {
  double opacity = 0;
  double containerWidth = 90;
  Color containerColor = Colors.greenAccent[400];
  double textOpaticy = 1.0;
  bool transition = false;

  String tipo = 'Low-END';
  String descricao = 'Hardwares de entrada.\nRode seus jogos na qualidade Média/Alta em FHD(1080p 60FPS) por um ótimo custo-benefício.';

  _upEngine(){
    setState(() {
      if(containerWidth == 90){
        transition = true;
        containerWidth = 195;
        containerColor = Colors.yellow;
        textOpaticy = 0;
        Future.delayed(const Duration(milliseconds: 300)).then((value){
          setState(() {
            tipo = 'Mid-END';
            descricao = 'Hardwares de alta performance.\nRode seus jogos na qualidade ULTRA em FHD(1080p 60/120 FPS).\nPreços mais elevados.';
            textOpaticy = 1;
            transition = false;
          });
        });
      } else if(containerWidth == 195){
        transition = true;
        containerWidth = 290;
        containerColor = Colors.red;
        textOpaticy = 0;
        Future.delayed(const Duration(milliseconds: 300)).then((value){
          setState(() {
            tipo = 'High-END';
            textOpaticy = 1;
            transition = false;
            descricao = 'Hardwares mais potentes do mercado.\nRode seus jogos na qualidade ULTRA em UHD(4K 60FPS).\nPreços muito elevados.';
          });
        });
      }
    });
  }

  _downEngine(){
    setState(() {
      if(containerWidth == 195){
        transition = true;
        containerWidth = 90;
        containerColor = Colors.greenAccent[400];
        textOpaticy = 0;
        Future.delayed(const Duration(milliseconds: 300)).then((value){
          setState(() {
            tipo = 'Low-END';
            textOpaticy = 1;
            transition = false;
            descricao = 'Hardwares de entrada.\nRode seus jogos na qualidade Média/Alta em FHD(1080p 60FPS) por um ótimo custo-benefício.';
          });
        });
      } else if(containerWidth == 290){
        transition = true;
        containerWidth = 195;
        containerColor = Colors.yellow;
        textOpaticy = 0;
        Future.delayed(const Duration(milliseconds: 300)).then((value){
          setState(() {
            tipo = 'Mid-END';
            textOpaticy = 1;
            transition = false;
            descricao = 'Hardwares de alta performance.\nRode seus jogos na qualidade ULTRA em FHD(1080p 60/120 FPS).\nPreços mais elevados.';
          });
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300)).then((value){
      setState(() {
        opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MontarSetup'),
        centerTitle: true,
        leading: Container(),
      ),
      body: AnimatedOpacity(
        duration: const Duration(seconds: 1),
        opacity: opacity,
        curve: Curves.easeIn,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40,),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text('Primeiro escolha a performance que deseja.', style: TextStyle(fontSize: 40),),
                  ),
                  const SizedBox(height: 60,),
                  AnimatedOpacity(
                    opacity: textOpaticy,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                    child: Text(
                      tipo,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 207, 170, 255)
                      ),
                    ),
                  ),
                  const SizedBox(height: 60,),
                  Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: (){
                              if(transition != true){
                                _downEngine();
                              }
                            },
                            icon: const Icon(Icons.keyboard_arrow_left_rounded, color: Colors.white,)
                          ),
                          Container(
                            height: 1,
                            width: 90,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Container(
                            height: 1,
                            width: 90,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Container(
                            height: 1,
                            width: 90,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                          IconButton(
                            onPressed: (){
                              if(transition != true){
                                _upEngine();
                              }
                            },
                            icon: const Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white,)
                          ),
                        ],
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.ease,
                        height: 30,
                        width: containerWidth,
                        margin: const EdgeInsets.fromLTRB(60, 0, 0, 30),
                        decoration: BoxDecoration(
                          color: containerColor,
                          borderRadius: BorderRadius.circular(5)
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: AnimatedOpacity(
                      opacity: textOpaticy,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                      child: Text(
                        descricao,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 207, 170, 255),
                          fontSize: 12
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AnimatedOpacity(
        duration: const Duration(seconds: 1),
        opacity: opacity,
        curve: Curves.easeIn,
        child: SizedBox(
          height: 70,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: (){
                setState(() {
                  widget.pc.performance = tipo;
                  widget.pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
                });
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
    );
  }
}