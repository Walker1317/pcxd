import 'package:flutter/material.dart';
import 'package:pcxd_app/screens/home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key key }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacity = 1;

  @override
  void initState() {
    super.initState();
    setState(() {
      opacity = 1.0;
    });
    Future.delayed(const Duration(seconds: 1)).then((value){
      setState(() {
        opacity = 0;
      });
      Future.delayed(const Duration(seconds: 1)).then((value){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const HomeScreen()), (route) => false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 24, 0, 46),
        /*gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 13, 9, 27),
            Color.fromARGB(255, 66, 53, 109),
            Color.fromARGB(255, 51, 36, 97),
          ]
        ),*/
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Center(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: opacity,
                curve: Curves.easeIn,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          /*BoxShadow(
                            color: Color.fromARGB(255, 127, 30, 255),
                            blurRadius: 100,
                            offset: Offset.zero,
                          ),*/
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}