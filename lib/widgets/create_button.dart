import 'package:flutter/material.dart';

class CreateButton extends StatelessWidget {
  CreateButton({this.title = 'Title', this.child, this.onPressed});
  String title;
  Widget child;
  Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  /*BoxShadow(
                    color: Color.fromARGB(150, 127, 30, 255),
                    blurRadius: 20,
                    offset: Offset.zero,
                  ),*/
                ],
              ),
            ),
            SizedBox(
              height: 100,
              width: 100,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(20, 111, 0, 255),//Color.fromARGB(99, 12, 0, 29).withOpacity(0.8),
                  onPrimary: const Color.fromARGB(255, 111, 0, 255),
                  elevation: 0,
                  shape: const CircleBorder(
                    side: BorderSide(
                      color: Color.fromARGB(255, 127, 30, 255),//Color.fromARGB(255, 24, 0, 46),
                      width: 1,
                    ),
                  ),
                ),
                child: child
              ),
            ),
          ],
        ),
        const SizedBox(height: 10,),
        SizedBox(
          width: 100,
          child: Text(title, textAlign: TextAlign.center,)
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}