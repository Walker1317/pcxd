import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcxd_app/model/pc/pc.dart';

class PCBuild extends StatelessWidget {
  PCBuild(this.pc);
  PC pc;

  @override
  Widget build(BuildContext context) {

    Color performanceColor(){

      switch (pc.performance) {
        case 'Low-END':
          return Colors.greenAccent[400];
          break;
        case 'Mid-END':
          return Colors.yellow;
          break;
        case 'High-END':
          return Colors.red[400];
          break;
        default:
      }

    }

    return ElevatedButton(
      onPressed: (){
        Navigator.pushNamed(context, '/pcScreen', arguments: pc);
      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.all(0),
        primary: const Color.fromARGB(20, 111, 0, 255),
        onPrimary: const Color.fromARGB(255, 99, 71, 189),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(
            color: Color.fromARGB(255, 127, 30, 255),//Color.fromARGB(255, 24, 0, 46),
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                //color: Colors.black38,
                borderRadius: BorderRadius.circular(20),
                image: pc.imagem != null ? DecorationImage(image: NetworkImage(pc.imagem)) : null,
              ),
              child: pc.imagem != null ? Container() : SvgPicture.asset('assets/pc2.svg', color: Colors.white, height: 20,),
            ),
            const SizedBox(height: 5,),
            Text(pc.nome, style: GoogleFonts.abel(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.speed_rounded, color: Colors.amberAccent, size: 20,),
                const SizedBox(width: 5,),
                Text(pc.benchamrk.toString(), style: GoogleFonts.abel(color: Colors.amberAccent, fontWeight: FontWeight.bold, fontSize: 15),),
                const SizedBox(width: 5,),
                Text(' R\$ ${pc.preco.toStringAsFixed(0)}', style: GoogleFonts.abel(color: Colors.greenAccent[700], fontWeight: FontWeight.bold, fontSize: 15),),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.keyboard_arrow_up, color: performanceColor(), size: 20,),
                const SizedBox(width: 5,),
                Text(pc.performance, style: GoogleFonts.abel(color: performanceColor(), fontWeight: FontWeight.bold, fontSize: 14),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}