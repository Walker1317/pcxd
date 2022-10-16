import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pcxd_app/model/pc/cpu.dart';

class CpuScreen extends StatefulWidget {
  CpuScreen(this.cpu);
  CPU cpu;

  @override
  State<CpuScreen> createState() => _CpuScreenState();
}

class _CpuScreenState extends State<CpuScreen> {
  @override
  Widget build(BuildContext context) {

    Widget _numInfo(String title, String value, IconData icondata){
      return Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icondata, color: Colors.white, size: 40,),
            const SizedBox(width: 10,),
            Column(
              children: [
                Text(title, style: const TextStyle(),),
                Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.cpu.marca} ${widget.cpu.modelo}'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20,),
            const Icon(Icons.speed_outlined, color: Colors.white60, size: 60,),
            Text(
              widget.cpu.benchmark.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.amberAccent,
                fontSize: 42,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              'Single Thread Rating: ${widget.cpu.singleThreadRating}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30,),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Performance:', style: TextStyle(fontSize: 12),),
            ),
            const Divider(),
            const SizedBox(height: 20,),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 60,
              children: [
                _numInfo('ClockSpeed', '${widget.cpu.clock} GHZ', Icons.timelapse_outlined),
                _numInfo('Turbo ClockSpeed', '${widget.cpu.turboClock} GHZ', Icons.timelapse_outlined),
              ],
            ),
            const SizedBox(height: 40,),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 30,
              children: [
                _numInfo('Cores', '${widget.cpu.cores}', Ionicons.logo_react),
                _numInfo('Threads', '${widget.cpu.threads}', Ionicons.logo_react),
                _numInfo('Energia', '${widget.cpu.energia}W', Ionicons.flash_outline),
              ],
            ),
            const SizedBox(height: 40,),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Especificações:', style: TextStyle(fontSize: 12),),
            ),
            const Divider(),
            ListTile(
              leading: const Text('Marca:'),
              title: Text(widget.cpu.marca, style: GoogleFonts.abel(fontWeight: FontWeight.bold),),
            ),
            ListTile(
              leading: const Text('Modelo:'),
              title: Text(widget.cpu.modelo, style: GoogleFonts.abel(fontWeight: FontWeight.bold),),
            ),
            ListTile(
              leading: const Text('Socket:'),
              title: Text(widget.cpu.socket, style: GoogleFonts.abel(fontWeight: FontWeight.bold),),
            ),
            ListTile(
              leading: const Text('Performance:'),
              title: Text(widget.cpu.tipo, style: GoogleFonts.abel(fontWeight: FontWeight.bold),),
            ),
            ListTile(
              leading: const Text('Ano:'),
              title: Text(widget.cpu.ano.toString(), style: GoogleFonts.abel(fontWeight: FontWeight.bold),),
            ),
            ListTile(
              leading: const Text('Preço estimado:'),
              title: Text('R\$ ${widget.cpu.preco}', style: GoogleFonts.abel(fontWeight: FontWeight.bold),),
            ),
            const SizedBox(height: 40,),
          ],
        ),
      ),
    );
  }
}