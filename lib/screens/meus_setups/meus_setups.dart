import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ui/animated_firestore_grid.dart';
import 'package:flutter/material.dart';
import 'package:pcxd_app/model/pc/pc.dart';
import 'package:pcxd_app/screens/meus_setups/widgets/pc_build.dart';

class MeusSetups extends StatefulWidget {
  MeusSetups(this.userID);
  String userID;

  @override
  State<MeusSetups> createState() => _MeusSetupsState();
}

class _MeusSetupsState extends State<MeusSetups> {
  Query queryPc;
  double opacity = 0;

  _adicionarListenerPC(){

    queryPc = FirebaseFirestore.instance.collection('users')
    .doc(widget.userID)
    .collection('pc')
    .withConverter<PC>(fromFirestore: (snapshot, _)=> PC.fromDocumentSnapshot(snapshot),
    );

  }

  @override
  void initState() {
    super.initState();
    _adicionarListenerPC();
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
        title: const Text('Meus Setups'),
      ),
      body: AnimatedOpacity(
        opacity: opacity,
        duration: const Duration(seconds: 1),
        curve: Curves.ease,
        child: FirestoreAnimatedGrid<PC>(
          padding: const EdgeInsets.all(10),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          query: queryPc,
          itemBuilder: (context, snapshot, anim, builder){
      
            final pc = snapshot.data();
      
            return PCBuild(pc);
      
          },
          emptyChild: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.all_inbox_rounded, color: Colors.white30, size: 120,),
              SizedBox(height: 20,),
              Text(
                'Você não possui setups.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white30,
                fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}