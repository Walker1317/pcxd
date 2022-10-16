import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcxd_app/model/pc/pc.dart';
import 'package:shimmer/shimmer.dart';

class HardwareList extends StatelessWidget {
  HardwareList(this.pc);
  PC pc;

  @override
  Widget build(BuildContext context) {

    var loadingBuild = Shimmer.fromColors(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,0,10,0),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
          ),
        ),
      ),
      baseColor: const Color.fromARGB(100, 127, 30, 255),
      highlightColor: const Color.fromARGB(100, 95, 21, 192),
    );

    return Column(
      children: [
        pc.cpuObj == null ? loadingBuild:
        ListTile(
          onTap: (){
            Navigator.pushNamed(context, '/cpuScreen', arguments: pc.cpuObj);
          },
          leading: Image.asset(pc.cpuObj.marca == 'Intel' ? 'images/intel_cpu.png' : 'images/amd_cpu.png',),
          title: Text('Processador', style: GoogleFonts.abel(color: Colors.white, fontSize: 12),),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${pc.cpuObj.modelo} | Cores: ${pc.cpuObj.cores} | Threads: ${pc.cpuObj.threads}', style: GoogleFonts.abel(color: Colors.white, fontWeight: FontWeight.bold),),
              Text('Clock: ${pc.cpuObj.clock} | Turbo Clock: ${pc.cpuObj.turboClock}', style: GoogleFonts.abel(color: Colors.white, fontWeight: FontWeight.bold),),
              Text('Preço: R\$ ${pc.cpuObj.preco}', style: GoogleFonts.abel(color: Colors.greenAccent, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        const SizedBox(height: 20,),
        pc.placamaeObj == null ? loadingBuild:
        ListTile(
          onTap: (){},
          leading: pc.placamaeObj.imagem != null ? Image.network(pc.placamaeObj.imagem) : SvgPicture.asset('assets/placamae.svg', color: Colors.white,),
          title: Text('Placa Mãe', style: GoogleFonts.abel(color: Colors.white, fontSize: 12),),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${pc.placamaeObj.modelo} | ${pc.placamaeObj.marca}', style: GoogleFonts.abel(color: Colors.white, fontWeight: FontWeight.bold),),
              Text('Socket: ${pc.placamaeObj.socket} | Memória: ${pc.placamaeObj.tipoMemoria}', style: GoogleFonts.abel(color: Colors.white, fontWeight: FontWeight.bold),),
              Text('Preço: R\$ ${pc.placamaeObj.preco}', style: GoogleFonts.abel(color: Colors.greenAccent, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        const SizedBox(height: 20,),
        pc.ramObj == null ? Container():
        ListTile(
          onTap: (){},
          leading: pc.ramObj[0].imagem != null ? Image.network(pc.ramObj[0].imagem) : SvgPicture.asset('assets/ram.svg', color: Colors.white,),
          title: Text('Memória RAM', style: GoogleFonts.abel(color: Colors.white, fontSize: 12),),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${pc.ramObj[0].marca} | ${pc.ramObj[0].modelo} | Velocidade: ${pc.ramObj[0].velocidade}Mhz', style: GoogleFonts.abel(color: Colors.white, fontWeight: FontWeight.bold),),
              Text('Capacidade: ${pc.ramObj[0].capacidade}GB | Tipo: ${pc.ramObj[0].tipo}', style: GoogleFonts.abel(color: Colors.white, fontWeight: FontWeight.bold),),
              Text('Preço: R\$ ${pc.ramObj[0].preco}', style: GoogleFonts.abel(color: Colors.greenAccent, fontWeight: FontWeight.bold),),
            ],
          ),
          trailing: Text('x${pc.ramQuantidade}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
        ),
        pc.nvmeObj == null ? Container():
        pc.nvmeObj[0].modelo == null ?
        Container():
        pc.nvmeObj[0].modelo == 'Modelo' ? Container():
        Column(
          children: [
            const SizedBox(height: 20,),
            ListTile(
              onTap: (){},
              leading: pc.nvmeObj[0].imagem != null ? Image.network(pc.nvmeObj[0].imagem) : SvgPicture.asset('assets/ssd.svg', color: Colors.white,),
              title: Text('SSD NVME', style: GoogleFonts.abel(color: Colors.white, fontSize: 12),),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${pc.nvmeObj[0].modelo} | ${pc.nvmeObj[0].marca}', style: GoogleFonts.abel(color: Colors.white, fontWeight: FontWeight.bold),),
                  Text('Capacidade: ${pc.nvmeObj[0].capacidade}GB', style: GoogleFonts.abel(color: Colors.white, fontWeight: FontWeight.bold),),
                  Text('Preço: R\$ ${pc.nvmeObj[0].preco}', style: GoogleFonts.abel(color: Colors.greenAccent, fontWeight: FontWeight.bold),),
                ],
              ),
              trailing: Text('x${pc.nvmeQuantidade}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
            ),
          ],
        ),
        pc.ssdObj == null ? Container():
        pc.ssdObj[0].capacidade == null ?
        const SizedBox(height: 10,):
        Column(
          children: [
            const SizedBox(height: 20,),
            ListTile(
              onTap: (){},
              leading: pc.ssdObj[0].imagem != null ? Image.network(pc.ssdObj[0].imagem) : SvgPicture.asset('assets/ssd.svg', color: Colors.white,),
              title: Text('SSD SATA', style: GoogleFonts.abel(color: Colors.white, fontSize: 12),),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${pc.ssdObj[0].modelo} | ${pc.ssdObj[0].marca}', style: GoogleFonts.abel(color: Colors.white, fontWeight: FontWeight.bold),),
                  Text('Capacidade: ${pc.ssdObj[0].capacidade}GB', style: GoogleFonts.abel(color: Colors.white, fontWeight: FontWeight.bold),),
                  Text('Preço: R\$ ${pc.ssdObj[0].preco}', style: GoogleFonts.abel(color: Colors.greenAccent, fontWeight: FontWeight.bold),),
                ],
              ),
              trailing: Text('x${pc.ssdQuantidade}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
            ),
          ],
        ),
        pc.gabineteObj == null ? loadingBuild:
        pc.gpuObj == null ? Container():
        ListTile(
          onTap: (){
            Navigator.pushNamed(context, '/gpuScreen', arguments: pc.gpuObj);
          },
          leading: Image.asset(pc.gpuObj.marca == 'AMD' ? 'images/amd_gpu.png' : 'images/nvidia_gpu.png',),
          title: Text('Placa de Vídeo', style: GoogleFonts.abel(color: Colors.white, fontSize: 12),),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${pc.gpuObj.modelo} | Memória:  ${pc.gpuObj.memory}GB', style: GoogleFonts.abel(color: Colors.white, fontWeight: FontWeight.bold),),
              Text('Clock: ${pc.gpuObj.coreClock}Mhz | Memory Clock: ${pc.gpuObj.memoryClock}Mhz', style: GoogleFonts.abel(color: Colors.white, fontWeight: FontWeight.bold),),
              Text('Preço: R\$ ${pc.gpuObj.preco}', style: GoogleFonts.abel(color: Colors.greenAccent, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        const SizedBox(height: 20,),
        pc.psuObj == null ? loadingBuild:
        ListTile(
          onTap: (){},
          leading: pc.psuObj.imagem != null ? Image.network(pc.psuObj.imagem) : SvgPicture.asset('assets/psu.svg', color: Colors.white, height: 37,),
          title: Text('Fonte de alimentação', style: GoogleFonts.abel(color: Colors.white, fontSize: 12),),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${pc.psuObj.modelo} | ${pc.psuObj.marca}', style: GoogleFonts.abel(color: Colors.white, fontWeight: FontWeight.bold),),
              Text('Potência: ${pc.psuObj.potencia}W', style: GoogleFonts.abel(color: Colors.white, fontWeight: FontWeight.bold),),
              Text('Preço: R\$ ${pc.psuObj.preco}', style: GoogleFonts.abel(color: Colors.greenAccent, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        const SizedBox(height: 20,),
        pc.gabineteObj == null ? loadingBuild:
        ListTile(
          onTap: (){},
          leading: pc.gabineteObj.imagem != null ? Image.network(pc.gabineteObj.imagem) : SvgPicture.asset('assets/pc.svg', color: Colors.white, height: 37,),
          title: Text('Gabinete', style: GoogleFonts.abel(color: Colors.white, fontSize: 12),),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${pc.gabineteObj.modelo} | ${pc.gabineteObj.marca}', style: GoogleFonts.abel(color: Colors.white, fontWeight: FontWeight.bold),),
              Text('Preço: R\$ ${pc.gabineteObj.preco}', style: GoogleFonts.abel(color: Colors.greenAccent, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ],
    );
  }
}