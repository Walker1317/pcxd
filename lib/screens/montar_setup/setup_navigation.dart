import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pcxd_app/model/pc/pc.dart';
import 'package:pcxd_app/model/pc/cpu.dart';
import 'package:pcxd_app/model/pc/gabinete.dart';
import 'package:pcxd_app/model/pc/gpu.dart';
import 'package:pcxd_app/model/pc/placamae.dart';
import 'package:pcxd_app/model/pc/psu.dart';
import 'package:pcxd_app/screens/montar_setup/cpu/selecionar_processador.dart';
import 'package:pcxd_app/screens/montar_setup/gabinete/selecionar_gabinete.dart';
import 'package:pcxd_app/screens/montar_setup/gpu/selecionar_gpu.dart';
import 'package:pcxd_app/screens/montar_setup/nvme/selecionar_nvme.dart';
import 'package:pcxd_app/screens/montar_setup/performance/montar_setup.dart';
import 'package:pcxd_app/screens/montar_setup/placa_mae/selecionar_placamae.dart';
import 'package:pcxd_app/screens/montar_setup/psu/selecionar_psu.dart';
import 'package:pcxd_app/screens/montar_setup/ram/selecionar_ram.dart';
import 'package:pcxd_app/screens/montar_setup/ssd/selecionar_ssd.dart';

class SetupNavigation extends StatefulWidget {
  const SetupNavigation({Key key}) : super(key: key);

  @override
  State<SetupNavigation> createState() => _SetupNavigationState();
}

class _SetupNavigationState extends State<SetupNavigation> {
  PC pc = PC();
  PageController pageController = PageController();
  bool saved = false;
  String title = '';

  @override
  void initState() {
    super.initState();
    pc.nome = '';
    pc.cpuObj = CPU();
    pc.placamaeObj = Placamae();
    pc.ramObj = [];
    pc.ssdObj = [];
    pc.nvmeObj = [];
    pc.gpuObj = GPU();
    pc.psuObj = PSU();
    pc.gabineteObj = Gabinete();
  }

  Future<bool> showConfirmationDialog(bool exit) {
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Deseja sair?', style: TextStyle(color: Colors.white),),
          content: const Text('Você ainda não finalizou a criação do pc.', style: TextStyle(color: Colors.white),),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(context, true);
                exit == true ? Navigator.pop(context, true) : null;
              },
              child: const Text('Sair',)
            ),
            TextButton(
              onPressed: (){
                Navigator.pop(context, false);
              },
              child: const Text('Ficar', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      }
    );
  }



  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {

        if(!saved){
          final confirmation = await showConfirmationDialog(false);
          return confirmation ?? false;
        }

        return true;

      },
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                MontarSetup(pc, pageController,),
                SelecionarProcessador(pc, pageController,),
                SelecionarPlacaMae(pc, pageController,),
                SelecionarRam(pc, pageController),
                SelecionarNvme(pc, pageController),
                SelecionarSSD(pc, pageController),
                SelecionarGPU(pc, pageController),
                SelecionarPSU(pc, pageController),
                SelecionarGabinete(pc, pageController),
              ],
            ),
            SafeArea(
              top: true,
              child: Padding(
                padding: const EdgeInsets.only(top: 3, left: 3),
                child: IconButton(
                  onPressed: ()async{
                    await showConfirmationDialog(true);
                  },
                  icon: const Icon(Icons.close_rounded, color: Colors.white,)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}