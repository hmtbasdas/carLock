import 'package:carlock/pages/select_car_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  final String picture = "assets/carLock.svg";
  final String animation = "raw/car_animation.json";
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this);
    wait();
  }

  bool _isAnimate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            _isAnimate = !_isAnimate;
          });
        },
      ),*/
      body: Center(
        child: Column(
          children: [
            const Expanded(
              flex: 2,
              child: SizedBox.shrink(),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      picture,
                      height: 150,
                    ),
                    AnimatedContainer(
                      child: Lottie.asset(
                        animation,
                        height: 75
                      ),
                      onEnd: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SelectCarScreen()));
                      },
                      duration: const Duration(seconds: 3),
                      margin: EdgeInsets.only(left: _isAnimate ? MediaQuery.of(context).size.width + 100 : 0),
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

  wait() async {
    await Future.delayed(const Duration(seconds: 3)).whenComplete((){
      setState(() {
        _isAnimate = !_isAnimate;
      });
    });
  }
}

