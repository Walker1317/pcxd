import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ui/firestore_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pcxd_app/model/pc/gpu.dart';
import 'package:pcxd_app/screens/comparar_cpu/benchmark_session/benchmark_session.dart';
import 'package:pcxd_app/screens/montar_setup/gpu/gpu_build.dart';
import 'package:pcxd_app/screens/montar_setup/widgets/empty_build.dart';
import 'package:pcxd_app/scripts/ads_services.dart';

class CompararGPU extends StatefulWidget {
  const CompararGPU({Key key}) : super(key: key);

  @override
  State<CompararGPU> createState() => _CompararGPUState();
}

class _CompararGPUState extends State<CompararGPU> {
  bool gpu1Bool = false;
  bool gpu2Bool = false;
  bool ads = true;
  GPU gpu1 = GPU();
  GPU gpu2 = GPU();
  double opacity = 0.0;

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

    Widget gpuSelect(int gpu, String modelo, String marca, Widget child){

      _addListenergpu(){
        Query querygpu = FirebaseFirestore.instance.collection('gpu')
        .orderBy('Benchmark', descending: true)
        .withConverter<GPU>(fromFirestore: (snapshot, _)=> GPU.fromDocumentSnapshot(snapshot),
        );

        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context){
            return Container(
              height: 500,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 24, 0, 46),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
              ),
              child: FirestoreAnimatedGrid(
                physics: const BouncingScrollPhysics(),
                mainAxisSpacing: 6,
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 80),
                query: querygpu,
                itemBuilder: (context, snapshot, animation, index){
                  final gpuS = snapshot.data();
                  return GPUBuild(
                    gpuS,
                    (){
                      Navigator.of(context).pop();
                      setState(() {
                        if(gpu == 1){
                          gpu1 = gpuS;
                        } else {
                          gpu2 = gpuS;
                          if(ads == true){
                            
                            AdsServices().showIntersitalAd().then((value){
                              setState(() {
                                gpu1Bool = true;
                                gpu2Bool = true;
                                opacity = 1;
                              });
                            });
                            ads = false;
                          } else {
                            setState(() {
                              gpu1Bool = true;
                              gpu2Bool = true;
                              opacity = 1;
                            });
                          }
                        }
                      });
                    },
                    gpu == 1 ? gpu1.modelo : gpu2.modelo,
                  );
                },
                crossAxisSpacing: 6,
                crossAxisCount: 3,
                childAspectRatio: 0.7,
                defaultChild: Container(),
                emptyChild: EmptyBuild(),
              ),
            );
          }
        );
      }

      Color color(){
        if(gpu == 1){
          if(gpu1.marca == 'NVidia'){
            return Colors.greenAccent[700];
          } else if(gpu1.marca == 'AMD'){
            return Colors.red;
          } else if(gpu1.marca == null){
            return const Color.fromARGB(255, 127, 30, 255);
          }
        } else {
          if(gpu2.marca == 'NVidia'){
            return Colors.greenAccent[700];
          } else if(gpu2.marca == 'AMD'){
            return Colors.red;
          } else if(gpu2.marca == null){
            return const Color.fromARGB(255, 127, 30, 255);
          }
        }
        
      }

      return GestureDetector(
        onTap: (){
          if(gpu == 2){
            if(gpu1.modelo != null){
              _addListenergpu();
            }
          } else {
            _addListenergpu();
          }
        },
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                color: Colors.black12,
                shape: BoxShape.circle,
                border: Border.all(
                  color: color()
                ),
              ),
              child: child,
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: 140,
              child: Column(
                children: [
                  Text(
                    modelo,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    marca,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white38
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget sessionCompareTitle(String result1, String result2){

      Widget session(String content,{bool color = true}){
        return Container(
          alignment: Alignment.center,
          height: 60,
          width: MediaQuery.of(context).size.width/3,
          decoration: BoxDecoration(
            border: Border.all(
              color: color == false ? Colors.transparent : const Color.fromARGB(255, 127, 30, 255),
            ),
          ),
          child: Text(content, style: const TextStyle(fontWeight: FontWeight.bold),),
        );
      }

      return Wrap(
        children: [
          session('', color: true),
          session(result1),
          session(result2),
        ],
      );
    }

    Widget sessionCompare(String title, String result1, String result2){

      Widget session(String content, {bool bold = false}){
        return Container(
          alignment: Alignment.center,
          height: 60,
          width: MediaQuery.of(context).size.width/3,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 127, 30, 255),
            ),
          ),
          child: Text(content, style: TextStyle(fontWeight: bold == true ? FontWeight.bold : FontWeight.normal),),
        );
      }

      return Wrap(
        children: [
          session(title, bold: true),
          session(result1),
          session(result2),
        ],
      );
    }

    Widget dataCompare(){
      if(gpu1Bool && gpu2Bool == true){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
              child: Text('Epecificações', textAlign: TextAlign.left,),
            ),
            sessionCompareTitle(gpu1.modelo ?? "Modelo 1", gpu2.modelo ?? " Modelo 2"),
            sessionCompare('Interface', gpu1.interface ?? '', gpu2.interface ?? ''),
            sessionCompare('Clockspeed', gpu1.coreClock != null ?'${gpu1.coreClock} Mhz' : '', gpu2.coreClock != null ?'${gpu2.coreClock} Mhz' : ''),
            sessionCompare('Memory Clock', gpu1.memoryClock != null ?'${gpu1.memoryClock} Mhz' : '', gpu2.memoryClock != null ?'${gpu2.memoryClock} Mhz' : ''),
            sessionCompare('Memória', gpu1.memory != null ? '${gpu1.memory} MB' : "", gpu2.memory != null ? '${gpu2.memory} MB' : ""),
            sessionCompare('OpenGL', gpu1.openGL != null ? gpu1.openGL.toString() : '', gpu2.openGL != null ? gpu2.openGL.toString() : ''),
            sessionCompare('Energía', gpu1.energia != null ? '${gpu1.energia} W' : '', gpu2.energia != null ? '${gpu2.energia} W' : ''),
            sessionCompare('Preço', gpu1.preco != null ? 'R\$ ${gpu1.preco}' : '', gpu2.preco != null ? 'R\$ ${gpu2.preco}' : ''),
          ],
        );
      } else {
        return Container();
      }
    }

    Widget benchmark(){
      if(gpu1Bool && gpu2Bool == true){
        return BenchmarkSession('Benchmark' ,gpu1.benchmark, gpu2.benchmark, gpu1.modelo, gpu2.modelo);
      } else {
        return Container();
      }
    }

    Widget singleTreading(){
      if(gpu1Bool && gpu2Bool == true){
        return BenchmarkSession('Single Treading Rating' ,gpu1.g2g, gpu2.g2g, gpu1.modelo, gpu2.modelo);
      } else {
        return Container();
      }
    }

    Widget price(){
      if(gpu1Bool && gpu2Bool == true){
        return BenchmarkSession('Preço (R\$)' ,gpu1.preco, gpu2.preco, gpu1.modelo, gpu2.modelo);
      } else {
        return Container();
      }
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comparar Placas de Vídeo'),
        centerTitle: true,
      ),
      body: AnimatedOpacity(
        duration: const Duration(seconds: 1),
        opacity: opacity,
        curve: Curves.ease,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30,),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  gpuSelect(
                    1,
                    gpu1.modelo ?? 'Selecione a Placa de Vídeo 1',
                    gpu1.marca ?? '',
                    gpu1.marca != null ? Image.asset(gpu1.marca == 'NVidia' ? 'images/nvidia_gpu.png' : 'images/amd_gpu.png',
                      fit: BoxFit.scaleDown, scale: 10,
                    )
                    : Padding(
                      padding: const EdgeInsets.all(30),
                      child: SvgPicture.asset('assets/gpu.svg', color: Colors.white30,),
                    ),
                  ),
                  const SizedBox(width: 40,),
                  gpuSelect(
                    2,
                    gpu2.modelo ?? 'Selecione a Placa de Vídeo 2',
                    gpu2.marca ?? '',
                    gpu2.marca != null ? Image.asset(gpu2.marca == 'NVidia' ? 'images/nvidia_gpu.png' : 'images/amd_gpu.png',
                      fit: BoxFit.scaleDown, scale: 10,
                    )
                    : Padding(
                      padding: const EdgeInsets.all(30),
                      child: SvgPicture.asset('assets/gpu.svg', color: Colors.white30,),
                    ),
                  ),
                ],
              ),
              AnimatedOpacity(
                duration: const Duration(seconds: 1),
                curve: Curves.ease,
                opacity: opacity,
                child: Column(
                  children: [
                    const SizedBox(height: 50,),
                    benchmark(),
                    const SizedBox(height: 20,),
                    singleTreading(),
                    const SizedBox(height: 20,),
                    price(),
                    const SizedBox(height: 20,),
                    dataCompare(),
                    const SizedBox(height: 60,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}