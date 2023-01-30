import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_best_food/root/pages/root_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        const Duration(seconds: 5),
        () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const RootPage(),
                ),
              )
            });
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color.fromARGB(255, 121, 26, 255),
            Color.fromARGB(255, 227, 101, 255),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Align(
              alignment: FractionalOffset.center,
              child: Text(
                'LDZ',
                style: GoogleFonts.kanit(
                  fontSize: 130,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            Align(
              alignment: FractionalOffset.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'myBestFood',
                    style: GoogleFonts.kanit(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      textStyle: TextStyle(
                        shadows: [
                          Shadow(
                            offset: const Offset(1.0, 1.0),
                            blurRadius: 30.0,
                            color: const Color.fromARGB(255, 121, 26, 255)
                                .withOpacity(0.8),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: FractionalOffset.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(padding: EdgeInsets.only(bottom: 180)),
                  Text(
                    'Rank your best food',
                    style: GoogleFonts.kanit(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 30,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      color: Colors.white70,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 15),
                    ),
                    Text(
                      'Sprawdzam...',
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Colors.white70,
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
