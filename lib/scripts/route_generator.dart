import 'package:flutter/material.dart';
import 'package:pcxd_app/screens/auth/signin_screen.dart';
import 'package:pcxd_app/screens/auth/signup_screen.dart';
import 'package:pcxd_app/screens/comparar_cpu/comparar_cpu.dart';
import 'package:pcxd_app/screens/comparar_gpu/comparar_gpu.dart';
import 'package:pcxd_app/screens/cpu_benchmark/cpu_benchmark.dart';
import 'package:pcxd_app/screens/cpu_screen/cpu_screen.dart';
import 'package:pcxd_app/screens/create/create_cpu/create_cpu.dart';
import 'package:pcxd_app/screens/create/create_gabinete/create_gabinete.dart';
import 'package:pcxd_app/screens/create/create_gpu/create_gpu.dart';
import 'package:pcxd_app/screens/create/create_placamae/create_placamae.dart';
import 'package:pcxd_app/screens/create/create_psu/create_psu.dart';
import 'package:pcxd_app/screens/create/create_ram/create_ram.dart';
import 'package:pcxd_app/screens/create/create_ssd/create_ssd.dart';
import 'package:pcxd_app/screens/gpu_benchmark/gpu_benchmark.dart';
import 'package:pcxd_app/screens/gpu_screen/gpu_screen.dart';
import 'package:pcxd_app/screens/meus_setups/meus_setups.dart';
import 'package:pcxd_app/screens/montar_setup/pc/pc_final.dart';
import 'package:pcxd_app/screens/montar_setup/setup_navigation.dart';
import 'package:pcxd_app/screens/monte_para_mim/monte_para_min.dart';
import 'package:pcxd_app/screens/pc_screen.dart/pc_screen.dart';
import 'package:pcxd_app/screens/perfil_screen/perfil_screen.dart';
import 'package:pcxd_app/splash_screen.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings){

    final args = settings.arguments;

    switch(settings.name){
      case '/' :
      return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/createCpu' :
      return MaterialPageRoute(builder: (_) => const CreateCpu());
      case '/createGpu' :
      return MaterialPageRoute(builder: (_) => const CreateGpu());
      case '/createPlacamae' :
      return MaterialPageRoute(builder: (_) => const CreatePlacaMae());
      case '/createRam' :
      return MaterialPageRoute(builder: (_) => const CreateRAM());
      case '/createSSD' :
      return MaterialPageRoute(builder: (_) => const CreateSSD());
      case '/createPSU' :
      return MaterialPageRoute(builder: (_) => const CreatePSU());
      case '/createGabinete' :
      return MaterialPageRoute(builder: (_) => const CreateGabinete());

      case '/montarSetup' :
      return MaterialPageRoute(builder: (_) => const SetupNavigation());
      case '/monteParaMim' :
      return MaterialPageRoute(builder: (_) => const MonteParaMim());

      case '/pcFinal' :
      return MaterialPageRoute(builder: (_) => PcFinal(args));
      case '/pcScreen' :
      return MaterialPageRoute(builder: (_) => PcScreen(args));

      case '/signin' :
      return MaterialPageRoute(builder: (_) => const SigninScreen());
      case '/signup' :
      return MaterialPageRoute(builder: (_) => const SignupScreen());

      case '/perfil' :
      return MaterialPageRoute(builder: (_) => PerfilScreen(args));
      case '/meusSetups' :
      return MaterialPageRoute(builder: (_) => MeusSetups(args));

      case '/compararCpu' :
      return MaterialPageRoute(builder: (_) => const CompararCPU());
      case '/compararGpu' :
      return MaterialPageRoute(builder: (_) => const CompararGPU());

      case '/cpuBenchmark' :
      return MaterialPageRoute(builder: (_) => const CpuBenchmark());
      case '/gpuBenchmark' :
      return MaterialPageRoute(builder: (_) => const GpuBenchmark());

      case '/cpuScreen' :
      return MaterialPageRoute(builder: (_) => CpuScreen(args));
      case '/gpuScreen' :
      return MaterialPageRoute(builder: (_) => GpuScreen(args));

      
      default:
        _erroRota();
    }

  }

  static Route<dynamic> _erroRota() {
    return MaterialPageRoute(builder: (_){
      return const Scaffold(
        body: Center(
          child: Text('Tela não encontrada'),
        ),
      );
    });
  }

}