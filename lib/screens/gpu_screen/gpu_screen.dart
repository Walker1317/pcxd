import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pcxd_app/model/pc/gpu.dart';

class GpuScreen extends StatefulWidget {
  GpuScreen(this.gpu);
  GPU gpu;

  @override
  State<GpuScreen> createState() => _GpuScreenState();
}

class _GpuScreenState extends State<GpuScreen> {
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
        title: Text('${widget.gpu.marca} ${widget.gpu.modelo}'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20,),
            const Icon(Icons.speed_outlined, color: Colors.white60, size: 60,),
            Text(
              widget.gpu.benchmark.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.amberAccent,
                fontSize: 42,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              'Average G2D Mark: ${widget.gpu.g2g}',
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
                _numInfo('CoreClock', '${widget.gpu.coreClock} MHZ', Icons.timelapse_outlined),
                _numInfo('Energia', '${widget.gpu.energia}W', Ionicons.flash_outline),
              ],
            ),
            const SizedBox(height: 40,),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 30,
              children: [
                _numInfo('Memória', '${widget.gpu.memory} MB', Ionicons.logo_react),
                _numInfo('Clock de Memória', '${widget.gpu.memoryClock} MHZ', Ionicons.logo_react),
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
              title: Text(widget.gpu.marca, style: GoogleFonts.abel(fontWeight: FontWeight.bold),),
            ),
            ListTile(
              leading: const Text('Modelo:'),
              title: Text(widget.gpu.modelo, style: GoogleFonts.abel(fontWeight: FontWeight.bold),),
            ),
            ListTile(
              leading: const Text('Interface:'),
              title: Text(widget.gpu.interface, style: GoogleFonts.abel(fontWeight: FontWeight.bold),),
            ),
            ListTile(
              leading: const Text('Performance:'),
              title: Text(widget.gpu.tipo, style: GoogleFonts.abel(fontWeight: FontWeight.bold),),
            ),
            ListTile(
              leading: const Text('Ano:'),
              title: Text(widget.gpu.ano.toString(), style: GoogleFonts.abel(fontWeight: FontWeight.bold),),
            ),
            ListTile(
              leading: const Text('Preço estimado:'),
              title: Text('R\$ ${widget.gpu.preco}', style: GoogleFonts.abel(fontWeight: FontWeight.bold),),
            ),
            const SizedBox(height: 40,),
          ],
        ),
      ),
    );
  }
}