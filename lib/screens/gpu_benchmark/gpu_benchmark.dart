import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ui/animated_firestore_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcxd_app/model/pc/cpu.dart';
import 'package:pcxd_app/model/pc/gpu.dart';

class GpuBenchmark extends StatefulWidget {
  const GpuBenchmark({Key key}) : super(key: key);

  @override
  State<GpuBenchmark> createState() => _GpuBenchmarkState();
}

class _GpuBenchmarkState extends State<GpuBenchmark> {
  Query query;

  _adicionarListenerGpu(){
    query = FirebaseFirestore.instance.collection('gpu')
    .orderBy('Benchmark', descending: true)
    .withConverter<GPU>(fromFirestore: (snapshot, _)=> GPU.fromDocumentSnapshot(snapshot),
    );

  }

  @override
  void initState() {
    super.initState();
    _adicionarListenerGpu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPU Benchmark'),
      ),
      body: FirestoreAnimatedList(
        query: query,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, snapshot, animation, index){
          final gpu = snapshot.data();
          return GpuBuildBenchmark(gpu);
        }
      ),
    );
  }
}

class GpuBuildBenchmark extends StatefulWidget {
  GpuBuildBenchmark(this.gpu);
  GPU gpu;

  @override
  State<GpuBuildBenchmark> createState() => _GpuBuildBenchmarkState();
}

class _GpuBuildBenchmarkState extends State<GpuBuildBenchmark> {
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
          Navigator.pushNamed(context, '/gpuScreen', arguments: widget.gpu);
        },
        title: Text(widget.gpu.modelo, style: GoogleFonts.abel(),),
        leading: Image.asset(widget.gpu.marca == 'AMD' ? 'images/amd_gpu.png' : "images/nvidia_gpu.png"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.speed_outlined, color: Colors.amberAccent,),
            const SizedBox(width: 5,),
            Text(widget.gpu.benchmark.toString(), style: const TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}