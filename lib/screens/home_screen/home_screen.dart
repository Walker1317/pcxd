import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pcxd_app/screens/home_screen/widgets/ad_carousel.dart';
import 'package:pcxd_app/scripts/app_settings.dart';
import 'package:pcxd_app/widgets/action_button.dart';
import 'package:pcxd_app/widgets/create_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double opacity = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0)).then((value){
      setState(() {
        opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 24, 0, 46),
      ),
      child: AnimatedOpacity(
        duration: const Duration(seconds: 1),
        opacity: opacity,
        curve: Curves.easeIn,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Bem vindo ao PCXD!',),
            actions: [
              IconButton(
                onPressed: () {
                  User user = FirebaseAuth.instance.currentUser;

                  if(user != null){
                    Navigator.pushNamed(context, '/perfil');
                  } else {
                    Navigator.pushNamed(context, '/signin');
                  }
                },
                icon: const Icon(Ionicons.person_circle_outline)
              )
            ],
          ),
          body: Stack(
            children: [
              AnimatedOpacity(
                opacity: 0.02,
                duration: const Duration(seconds: 1),
                child: Image.asset('images/pcxd_logo.png', height: 1100, width: 1100,),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const AdCarousel(),
                    const Divider(),
                    const SizedBox(height: 10,),
                    Row(
                      children: const [
                        SizedBox(width: 15,),
                        Icon(Ionicons.build_outline, color: Colors.white, size: 16,),
                        SizedBox(width: 10,),
                        Text('Montagem'),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Wrap(
                      spacing: 20,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: [
                        CreateButton(
                          onPressed: (){
                            Navigator.pushNamed(context, '/montarSetup');
                          },
                          title: 'Montar Setup',
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: SvgPicture.asset('assets/pc2.svg', color: Colors.white,)
                          ),
                        ),
                        CreateButton(
                          onPressed: (){
                            Navigator.pushNamed(context, '/monteParaMim');
                          },
                          title: 'Monte para mim',
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: SvgPicture.asset('assets/pc_man.svg', color: Colors.white,)
                          ),
                        ),
                        CreateButton(
                          onPressed: (){

                            User userA = FirebaseAuth.instance.currentUser;
                            if(userA != null){

                              Navigator.pushNamed(context, '/meusSetups', arguments: userA.uid);

                            } else {
                              Navigator.pushNamed(context, '/signin');
                            }
                            
                          },
                          title: 'Meus setups',
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: SvgPicture.asset('assets/pc1.svg', color: Colors.white,)
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 10,),
                    Row(
                      children: const [
                        SizedBox(width: 15,),
                        Icon(Ionicons.grid_outline, color: Colors.white, size: 16,),
                        SizedBox(width: 10,),
                        Text('Widgets'),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: [
                        ActionButton(
                          onPressed: (){
                            Navigator.of(context).pushNamed('/compararCpu');
                          },
                          title: 'Comparar CPU\'s',
                          child: SvgPicture.asset('assets/cpu.svg', color: Colors.white,),
                        ),
                        ActionButton(
                          onPressed: (){
                            Navigator.of(context).pushNamed('/compararGpu');
                          },
                          title: 'Comparar GPU\'s',
                          child: SvgPicture.asset('assets/gpu.svg', color: Colors.white,),
                        ),
                        ActionButton(
                          onPressed: (){
                            Navigator.pushNamed(context, '/cpuBenchmark');
                          },
                          title: 'CPU Benchmarks',
                          child: const Icon(Iconsax.chart_1, color: Colors.white, size: 50,),
                        ),
                        ActionButton(
                          onPressed: (){
                            Navigator.pushNamed(context, '/gpuBenchmark');
                          },
                          title: 'GPU Benchmarks',
                          child: const Icon(Iconsax.chart_2, color: Colors.white, size: 50,),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'PCXD™ (por Interestelar Studios®) | Beta ${AppSettings().version}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white54,)
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}