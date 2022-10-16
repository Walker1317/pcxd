import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pcxd_app/screens/monte_para_mim/widgets/carousel_pc.dart';
import 'package:pcxd_app/scripts/ads_services.dart';

class MonteParaMim extends StatefulWidget {
  const MonteParaMim({Key key}) : super(key: key);

  @override
  State<MonteParaMim> createState() => _MonteParaMimState();
}

class _MonteParaMimState extends State<MonteParaMim> {

  double priceMin = 500;
  double opacity = 0;
  double opacityCarousel = 0;
  double priceMax = 20000;
  final _controller = StreamController<QuerySnapshot>.broadcast();
  bool searched = false;
  bool ad = true;

  Future<Stream<QuerySnapshot>> _adicionarListenerPc() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    Stream<QuerySnapshot> stream = db.collection('pc')
    .where('Preco', isLessThanOrEqualTo: priceMax, isGreaterThanOrEqualTo: priceMin)
    .snapshots();

    stream.listen((dados) {
      _controller.add(dados);
    });

  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500)).then((value){
      setState(() {
        opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Montar Setup'),
        centerTitle: true,
      ),
      body: AnimatedOpacity(
        opacity: opacity,
        duration: const Duration(seconds: 1),
        curve: Curves.ease,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text('Selecione o preço mínimo e o máximo que deseja', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), textAlign: TextAlign.center,),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('R\$ ${priceMin.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.right,),
              ),
              Slider(
                value: priceMin,
                onChanged: (newPrice){
                  setState(() {
                    priceMin = newPrice;
                    if(newPrice >= priceMax){
                      priceMin = priceMax;
                    }
                  });
                },
                min: 500,
                max: 20000,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('R\$ ${priceMax.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.right,),
              ),
              Slider(
                value: priceMax,
                onChanged: (newPrice){
                  setState(() {
                    priceMax = newPrice;
                    if(newPrice <= priceMin){
                      priceMax = priceMin;
                    }
                  });
                },
                min: 500,
                max: 20000,
              ),
              const SizedBox(height: 10,),
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: (){
                    if(ad == true){
                      AdsServices().showIntersitalAd().then((value){
                        ad = false;
                      }).catchError((e){});
                    }
                    setState(() {
                      _adicionarListenerPc();
                      searched = true;
                    });
                    Future.delayed(const Duration(milliseconds: 500)).then((value){
                      setState(() {
                        opacityCarousel = 1;
                      });
                    });
                  },
                  child: const Text('Montar Setups'),
                ),
              ),
              searched == true?
              AnimatedOpacity(
                opacity: opacityCarousel,
                duration: const Duration(seconds: 1),
                child: CarouselPc(_controller)
              ):
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}