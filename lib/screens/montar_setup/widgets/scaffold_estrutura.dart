import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ui/animated_firestore_grid.dart';
import 'package:flutter/material.dart';
import 'package:pcxd_app/screens/montar_setup/widgets/empty_build.dart';

class ScaffoldHardwareSelect extends StatefulWidget {
  ScaffoldHardwareSelect({this.title = 'Título', this.head,
  this.body, this.query, this.listener, this.itemBuilder, this.button,
  this.disabled = false, this.disabledText
  });
  String title;
  Widget head;
  Widget body;
  Query query;
  Function listener;
  Widget button;
  FirestoreAnimatedGridItemBuilder itemBuilder;
  bool disabled;
  String disabledText;

  @override
  State<ScaffoldHardwareSelect> createState() => _ScaffoldHardwareSelectState();
}

class _ScaffoldHardwareSelectState extends State<ScaffoldHardwareSelect> {
  double height = 0;
  Widget list = Container();
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    widget.listener;
    Future.delayed(const Duration(milliseconds: 300)).then((value){
      setState(() {
        height = 500;
        Future.delayed(const Duration(milliseconds: 800)).then((value){
          setState(() {
            loaded = true;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    var firestoreAnimatedGrid = FirestoreAnimatedGrid(
      physics: const BouncingScrollPhysics(),
      mainAxisSpacing: 6,
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 80),
      query: widget.query,
      itemBuilder: widget.itemBuilder,
      crossAxisSpacing: 6,
      crossAxisCount: 3,
      childAspectRatio: 0.7,
      defaultChild: Container(),
      emptyChild: EmptyBuild(),
    );

    Widget child (){

      if(widget.disabled == false){
        if(loaded == true){
          return firestoreAnimatedGrid;
        } else {
          return list;
        }
      } else {
        if(loaded == true){
          return EmptyBuild(title: widget.disabledText,);
        } else {
          return list;
        }
      }

    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 0, 46),
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        leading: Container(),
      ),
      body: Stack(
        children: [
          widget.head ?? Container(),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              height: height,
              duration: const Duration(seconds: 1),
              curve: Curves.ease,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 66, 53, 109),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
                ),
              ),
              child: child()
            ),
          ),
          Positioned(
            bottom: 0,
            child: widget.button
          ),
        ],
      ),
    );
  }
}