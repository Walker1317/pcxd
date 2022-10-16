import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ui/firestore_ui.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pcxd_app/model/pc/cpu.dart';
import 'package:pcxd_app/screens/comparar_cpu/benchmark_session/benchmark_session.dart';
import 'package:pcxd_app/screens/montar_setup/cpu/cpu_build.dart';
import 'package:pcxd_app/screens/montar_setup/widgets/empty_build.dart';
import 'package:pcxd_app/scripts/ads_services.dart';

class CompararCPU extends StatefulWidget {
  const CompararCPU({Key key}) : super(key: key);

  @override
  State<CompararCPU> createState() => _CompararCPUState();
}

class _CompararCPUState extends State<CompararCPU> {

  bool cpu1Bool = false;
  bool cpu2Bool = false;
  bool ads = true;
  CPU cpu1 = CPU();
  CPU cpu2 = CPU();
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

    Widget cpuSelect(int cpu, String modelo, String marca, Widget child){

      _addListenerCpu(){
        Query queryCpu = FirebaseFirestore.instance.collection('cpu')
        .orderBy('Benchmark', descending: true)
        .withConverter<CPU>(fromFirestore: (snapshot, _)=> CPU.fromDocumentSnapshot(snapshot),
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
                query: queryCpu,
                itemBuilder: (context, snapshot, animation, index){
                  final cpuS = snapshot.data();
                  return CpuBuild(
                    cpuS,
                    (){
                      Navigator.of(context).pop();
                      setState(() {
                        if(cpu == 1){
                          cpu1 = cpuS;
                        } else {
                          cpu2 = cpuS;
                          if(ads == true){
                            
                            AdsServices().showIntersitalAd().then((value){
                              setState(() {
                                cpu1Bool = true;
                                cpu2Bool = true;
                                opacity = 1;
                              });
                            });
                            ads = false;
                          } else {
                            setState(() {
                              cpu1Bool = true;
                              cpu2Bool = true;
                              opacity = 1;
                            });
                          }
                        }
                      });
                    },
                    cpu == 1 ? cpu1.modelo : cpu2.modelo,
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
        if(cpu == 1){
          if(cpu1.marca == 'Intel'){
            return Colors.blue;
          } else if(cpu1.marca == 'AMD'){
            return Colors.red;
          } else if(cpu1.marca == null){
            return const Color.fromARGB(255, 127, 30, 255);
          }
        } else {
          if(cpu2.marca == 'Intel'){
            return Colors.blue;
          } else if(cpu2.marca == 'AMD'){
            return Colors.red;
          } else if(cpu2.marca == null){
            return const Color.fromARGB(255, 127, 30, 255);
          }
        }
        
      }

      return GestureDetector(
        onTap: (){
          if(cpu == 2){
            if(cpu1.modelo != null){
              _addListenerCpu();
            }
          } else {
            _addListenerCpu();
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
      if(cpu1Bool && cpu2Bool == true){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
              child: Text('Epecificações', textAlign: TextAlign.left,),
            ),
            sessionCompareTitle(cpu1.modelo ?? "Modelo 1", cpu2.modelo ?? " Modelo 2"),
            sessionCompare('Socket', cpu1.socket ?? '', cpu2.socket ?? ''),
            sessionCompare('Clockspeed', cpu1.clock != null ?'${cpu1.clock} GHZ' : '', cpu2.clock != null ?'${cpu2.clock} GHZ' : ''),
            sessionCompare('Turbo Speed', cpu1.turboClock != null ?'${cpu1.turboClock} GHZ' : '', cpu2.turboClock != null ?'${cpu2.turboClock} GHZ' : ''),
            sessionCompare('Cores físicos', cpu1.cores != null ? cpu1.cores.toString() : "", cpu2.cores != null ? cpu2.cores.toString() : ""),
            sessionCompare('Threads', cpu1.threads != null ? cpu1.threads.toString() : '', cpu2.threads != null ? cpu2.threads.toString() : ''),
            sessionCompare('Energía', cpu1.energia != null ? '${cpu1.energia} W' : '', cpu2.energia != null ? '${cpu2.energia} W' : ''),
            sessionCompare('Preço', cpu1.preco != null ? 'R\$ ${cpu1.preco}' : '', cpu2.preco != null ? 'R\$ ${cpu2.preco}' : ''),
          ],
        );
      } else {
        return Container();
      }
    }

    Widget benchmark(){
      if(cpu1Bool && cpu2Bool == true){
        return BenchmarkSession('Benchmark' ,cpu1.benchmark, cpu2.benchmark, cpu1.modelo, cpu2.modelo);
      } else {
        return Container();
      }
    }

    Widget singleTreading(){
      if(cpu1Bool && cpu2Bool == true){
        return BenchmarkSession('Single Treading Rating' ,cpu1.singleThreadRating, cpu2.singleThreadRating, cpu1.modelo, cpu2.modelo);
      } else {
        return Container();
      }
    }

    Widget price(){
      if(cpu1Bool && cpu2Bool == true){
        return BenchmarkSession('Preço (R\$)' ,cpu1.preco, cpu2.preco, cpu1.modelo, cpu2.modelo);
      } else {
        return Container();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comparar CPU'),
        centerTitle: true,
      ),
      body: AnimatedOpacity(
        opacity: opacity,
        curve: Curves.ease,
        duration: const Duration(seconds: 1),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30,),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  cpuSelect(
                    1,
                    cpu1.modelo ?? 'Selecione o Processador 1',
                    cpu1.marca ?? '',
                    cpu1.marca != null ? Image.asset(cpu1.marca == 'Intel' ? 'images/intel_cpu.png' : 'images/amd_cpu.png',
                      fit: BoxFit.scaleDown, scale: 10,
                    )
                    : const Icon(Ionicons.hardware_chip_outline, color: Colors.white30, size: 70,)
                  ),
                  const SizedBox(width: 40,),
                  cpuSelect(
                    2,
                    cpu2.modelo ?? 'Selecione o Processador 2',
                    cpu2.marca ?? '',
                    cpu2.marca != null ? Image.asset(cpu2.marca == 'Intel' ? 'images/intel_cpu.png' : 'images/amd_cpu.png',
                      fit: BoxFit.scaleDown, scale: 10,
                    )
                    : const Icon(Ionicons.hardware_chip_outline, color: Colors.white30, size: 70,)
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