import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActionButton extends StatelessWidget {
  ActionButton({this.height = 185, this.width = 185, this.shape, this.child, this.title = 'title', this.onPressed});
  double height;
  double width;
  OutlinedBorder shape;
  Widget child;
  String title;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              /*BoxShadow(
                color: Color.fromARGB(255, 127, 30, 255),
                blurRadius: 5,
                offset: Offset.zero,
              ),*/
            ],
          ),
        ),
        SizedBox(
          height: height,
          width: width,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              primary: const Color.fromARGB(20, 111, 0, 255),//Color.fromARGB(99, 12, 0, 29).withOpacity(0.8),
              onPrimary: const Color.fromARGB(255, 111, 0, 255),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(
                  color: Color.fromARGB(255, 127, 30, 255),//Color.fromARGB(255, 24, 0, 46),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60,
                  width: 60,
                  child: child ?? Container()
                ),
                const SizedBox(height: 20,),
                Text(
                  title,
                  style: GoogleFonts.abel(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}