import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pcxd_app/model/ad.dart';

class AdCarousel extends StatefulWidget {
  const AdCarousel({ Key key }) : super(key: key);

  @override
  State<AdCarousel> createState() => _AdCarouselState();
}

class _AdCarouselState extends State<AdCarousel> {
  final _controller = StreamController<QuerySnapshot>.broadcast();
  int _current = 0;

  Future<Stream<QuerySnapshot>> _adicionarListenerAd() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    Stream<QuerySnapshot> stream = db.collection('ads')
    .orderBy('priority')
    .snapshots();
    

    stream.listen((dados) {
      _controller.add(dados);
    });

  }


  List<T> map<T>(List list, Function handler){

    List<T> result = [];
    for (var i = 0; i < list.length; i++){
      result.add(handler(i, list[i]));
    }
    return result;

  }


  @override
  void initState() {
    super.initState();
    _adicionarListenerAd();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _controller.stream,
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
            List<DocumentSnapshot> ads = querySnapshot.docs.toList();

            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  CarouselSlider.builder(
                    itemCount: querySnapshot.docs.length,
                    options: CarouselOptions(
                      height: 100.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      autoPlayAnimationDuration: const Duration(milliseconds: 400),
                      autoPlayInterval: const Duration(seconds: 3),
                      viewportFraction: 0.95,
                      enableInfiniteScroll: true,
                      initialPage: 0,
                      onPageChanged: (index, pageReason){

                        setState(() {
                          _current = index;
                        });

                      }
                    ),
                    itemBuilder: (_, indice, indice2){

                      List<DocumentSnapshot> ads = querySnapshot.docs.toList();
                      DocumentSnapshot documentSnapshot = ads[indice];
                      AD ad = AD.fromDocumentSnapshot(documentSnapshot);

                      return Container(
                        width: MediaQuery.of(context).size.width,
                        //margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 24, 0, 46),
                          borderRadius: BorderRadius.circular(10),
                          image: ad.image != null ? DecorationImage(
                            image: NetworkImage(ad.image),
                            fit: BoxFit.cover
                          ) : null
                        ),
                      );
                    },
                  ),
                  ads.length > 1 ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: map<Widget>(
                      querySnapshot.docs.toList(), (index, url){
                        return Container(
                          width: 10,
                          height: 10,
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == index ? const Color.fromARGB(255, 127, 30, 255) : Colors.white12,
                          ),
                        );
                      }
                    ),
                  ): const SizedBox(height: 10,),
                ],
              ),
            );
        } return Container();
      }
    );
  }
}