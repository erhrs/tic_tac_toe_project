import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tic_tac_toe_project/utils/custom_widgets.dart';
import 'package:tic_tac_toe_project/utils/extensions.dart';
import 'package:tic_tac_toe_project/views/tic_tac_toe_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              50.height,
              Center(
                  child: Text(
                'Welcome!',
                style: customTextStyle(fontSize: 40, color: Colors.blue),
              )),
              SizedBox(
                height: 100,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Let's Play",
                      style: customTextStyle(fontSize: 43),
                    ),
                    SizedBox(
                      width: 80,
                      child: DefaultTextStyle(
                        style: customTextStyle(fontSize: 40, color: Colors.blue),
                        child: AnimatedTextKit(
                          isRepeatingAnimation: true,
                          animatedTexts: [
                            RotateAnimatedText('TIC'),
                            RotateAnimatedText('TAC'),
                            RotateAnimatedText('TOE'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              20.height,
              Lottie.asset(
                'assets/animations/Animation - 1728706057670.json',
                width: 200,
                height: 200,
                fit: BoxFit.fill,
                repeat: true,
              ),
              50.height,
              customButton(title: 'Play', onPressed: () => Get.to(const TicTacToeScreen(), ),lightBool: false)
            ],
          ),
        ),
      ),
    );
  }
}
