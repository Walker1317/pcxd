import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ui/animated_firestore_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcxd_app/model/pc/cpu.dart';

class CpuBenchmark extends StatefulWidget {
  const CpuBenchmark({Key key}) : super(key: key);

  @override
  State<CpuBenchmark> createState() => _CpuBenchmarkState();
}

class _CpuBenchmarkState extends State<CpuBenchmark> {
  Query query;

  _adicionarListenerCpu(){
    query = FirebaseFirestore.instance.collection('cpu')
    .orderBy('Benchmark', descending: true)
    .withConverter<CPU>(fromFirestore: (snapshot, _)=> CPU.fromDocumentSnapshot(snapshot),
    );

  }

  @override
  void initState() {
    super.initState();
    _adicionarListenerCpu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CPU Benchmark'),
      ),
      body: FirestoreAnimatedList(
        query: query,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, snapshot, animation, index){
          final cpu = snapshot.data();
          return CpuBuildBenchmark(cpu);
        }
      ),
    );
  }
}

class CpuBuildBenchmark extends StatefulWidget {
  CpuBuildBenchmark(this.cpu);
  CPU cpu;

  @override
  State<CpuBuildBenchmark> createState() => _CpuBuildBenchmarkState();
}

class _CpuBuildBenchmarkState extends State<CpuBuildBenchmark> {
  double opacity = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 50)).then((value){
      setState(() {
        opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(seconds: 1),
      curve: Curves.ease,
      child: ListTile(
        onTap: (){
          Navigator.pushNamed(context, '/cpuScreen', arguments: widget.cpu);
        },
        title: Text(widget.cpu.modelo, style: GoogleFonts.abel(),),
        leading: Image.asset(widget.cpu.marca == 'AMD' ? 'images/amd_cpu.png' : "images/intel_cpu.png"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.speed_outlined, color: Colors.amberAccent,),
            const SizedBox(width: 5,),
            Text(widget.cpu.benchmark.toString(), style: const TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}