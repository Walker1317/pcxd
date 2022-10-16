import 'package:flutter/material.dart';

class EmptyBuild extends StatefulWidget {
  EmptyBuild({this.title});
  String title;

  @override
  State<EmptyBuild> createState() => _EmptyBuildState();
}

class _EmptyBuildState extends State<EmptyBuild> {

  double opacity = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 10)).then((value){
      setState(() {
        opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(seconds: 1),
      opacity: opacity,
      curve: Curves.ease,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.all_inbox_rounded, color: Colors.white30, size: 120,),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Text(
              widget.title ?? 'Desculpe, mas ainda não temos esses componentes.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white30,
              fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}