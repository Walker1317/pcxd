import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pcxd_app/model/pc/pc.dart';

class CarouselPc extends StatefulWidget {
  CarouselPc(this.controller);
  StreamController controller;

  @override
  State<CarouselPc> createState() => _CarouselPcState();
}

class _CarouselPcState extends State<CarouselPc> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.controller.stream,
      builder: (context, snapshot){
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Container();
            break;
          case ConnectionState.active:
          case ConnectionState.done:

            if(snapshot.hasError){
              return const Text('Erro ao carregar');
            }

            QuerySnapshot querySnapshot = snapshot.data;
            List<DocumentSnapshot> pcs = querySnapshot.docs.toList();

            if(querySnapshot.docs.isEmpty){
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: Text('Desculpe, não temos computadores com essas especificações.', textAlign: TextAlign.center,),
                )
              );
            }

            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  const SizedBox(height: 30,),
                  CarouselSlider.builder(
                    itemCount: querySnapshot.docs.length,
                    options: CarouselOptions(
                      height: 400,
                      autoPlay: false,
                      enlargeCenterPage: true,
                      autoPlayAnimationDuration: const Duration(milliseconds: 400),
                      autoPlayInterval: const Duration(seconds: 3),
                      viewportFraction: 0.7,
                      enableInfiniteScroll: true,
                      initialPage: 0,
                      onPageChanged: (index, pageReason){

                      }
                    ),
                    itemBuilder: (_, indice, indice2){

                      List<DocumentSnapshot> pcs = querySnapshot.docs.toList();
                      DocumentSnapshot documentSnapshot = pcs[indice];
                      PC pc = PC.fromDocumentSnapshot(documentSnapshot);

                      return PcCarouselBuild(pc);
                    },
                  ),
                ],
              ),
            );
        } return Container();
      }
    );
  }
}

class PcCarouselBuild extends StatefulWidget {
  PcCarouselBuild(this.pc);
  PC pc;

  @override
  State<PcCarouselBuild> createState() => _PcCarouselBuildState();
}

class _PcCarouselBuildState extends State<PcCarouselBuild> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/pcScreen', arguments: widget.pc);
      },
      child: Container(
        width: 500,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(50, 127, 30, 255),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Image.network(widget.pc.imagem, height: 200,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Text(widget.pc.nome, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                  Text('${widget.pc.cpu} | ${widget.pc.gpu}', style: const TextStyle(color: Colors.white30), textAlign: TextAlign.center,),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text('Benchmark', style: TextStyle(fontSize: 12), textAlign: TextAlign.center,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.speed_rounded, color: Colors.amberAccent, size: 30,),
                        const SizedBox(width: 10,),
                        Text(widget.pc.benchamrk.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.amberAccent),),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                  width: 50,
                  child: VerticalDivider(
                    color: Color.fromARGB(255, 207, 170, 255),
                  ),
                ),
                Column(
                  children: [
                    const Text('Preço estimado', style: TextStyle(fontSize: 12), textAlign: TextAlign.center,),
                    Text('R\$ ${widget.pc.preco.toStringAsFixed(1)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.greenAccent), textAlign: TextAlign.center,),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}