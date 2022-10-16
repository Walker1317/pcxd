import 'package:flutter/material.dart';
import 'package:pcxd_app/model/pc/cpu.dart';

class BenchmarkSession extends StatefulWidget {
  BenchmarkSession(this.session ,this.cpu1, this.cpu2, this.model1, this.model2);
  num cpu1;
  num cpu2;
  String model1;
  String model2;
  String session;
  double sizeGeral = 0.0;

  @override
  State<BenchmarkSession> createState() => _BenchmarkSessionState();
}

class _BenchmarkSessionState extends State<BenchmarkSession> {

  double height1(num size){

    if(size > widget.cpu2){
      return MediaQuery.of(context).size.width;
    } else {

      num calc1 = widget.cpu1 * 100; 
      num size = calc1 / widget.cpu2;
      String sizeS = size.toStringAsFixed(0);
      num concrete = num.parse(sizeS);

      num calculating = MediaQuery.of(context).size.width * concrete;
      num calculating1 = calculating / 100;
      num result = calculating1 - 10;

      if(result < 140){
        result = 140.0;
      }

      return result;

    }

  }

  double height2(num size){

    if(size > widget.cpu1){
      return MediaQuery.of(context).size.width;
    } else {

      num calc1 = widget.cpu2 * 100; 
      num size = calc1 / widget.cpu1;
      String sizeS = size.toStringAsFixed(0);
      num concrete = num.parse(sizeS);

      num calculating = MediaQuery.of(context).size.width * concrete;
      num calculating1 = calculating / 100;
      num result = calculating1 - 10;

      if(result < 140){
        result = 140.0;
      }

      return result;

    }

  }

  @override
  Widget build(BuildContext context) {

    Widget animatedContainer(double width, String modelo, String benchmark){
      return AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: 50,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.orange,//Color.fromARGB(255, 127, 30, 255),
          borderRadius: BorderRadius.circular(5),
          /*boxShadow: const [
            BoxShadow(
              color: Colors.orange,//Color.fromARGB(255, 111, 0, 255),
              blurRadius: 20,
              spreadRadius: 0.05
            )
          ]*/
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: Text(modelo, style: const TextStyle(fontWeight: FontWeight.bold),)),
            Flexible(child: Text(benchmark, style: const TextStyle(fontWeight: FontWeight.bold),)),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.session),
          const SizedBox(height: 10,),
          animatedContainer(height1(widget.cpu1,), widget.model1, widget.cpu1.toString()),
          const SizedBox(height: 10,),
          animatedContainer(height2(widget.cpu2,), widget.model2, widget.cpu2.toString()),
        ],
      ),
    );
  }
}