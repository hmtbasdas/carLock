import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CarControllerScreen extends StatefulWidget {
  const CarControllerScreen({Key? key}) : super(key: key);

  @override
  State<CarControllerScreen> createState() => _CarControllerScreenState();
}

class _CarControllerScreenState extends State<CarControllerScreen> {

  bool _front = false;
  bool _back = false;
  bool _frontLeft = false;
  bool _backLeft = false;
  bool _frontRight = false;
  bool _backRight = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  const Expanded(
                    flex: 1,
                    child: SizedBox.shrink(),
                  ),
                  Expanded(
                    flex: 4,
                    child: Image.asset(
                      "assets/car.png",
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: SizedBox.shrink(),
                  ),
                ],
              ),
            ),

            //Front
            Positioned(
              child: InkWell(
                onTap: (){
                  setState(() {
                    final player = AudioCache();
                    player.play("car_lock_sound.wav");
                    _front = !_front;
                  });
                },
                child: AnimatedCrossFade(
                  firstChild: unlockedWidget(),
                  secondChild: lockedWidget(),
                  duration: const Duration(milliseconds: 500),
                  crossFadeState: _front ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                ),
              ),
              left: MediaQuery.of(context).size.width / 2 - 25,
              top: 20,
            ),

            //Back
            Positioned(
              child: InkWell(
                onTap: (){
                  setState(() {
                    final player = AudioCache();
                    player.play("car_lock_sound.wav");
                    _back = !_back;
                  });
                },
                child: AnimatedCrossFade(
                  firstChild: unlockedWidget(),
                  secondChild: lockedWidget(),
                  duration: const Duration(milliseconds: 500),
                  crossFadeState: _back ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                ),
              ),
              left: MediaQuery.of(context).size.width / 2 - 25,
              bottom: 20,
            ),

            //FrontLeft
            Positioned(
              child: InkWell(
                onTap: (){
                  setState(() {
                    final player = AudioCache();
                    player.play("car_lock_sound.wav");
                    _frontLeft = !_frontLeft;
                  });
                },
                child: AnimatedCrossFade(
                  firstChild: unlockedWidget(),
                  secondChild: lockedWidget(),
                  duration: const Duration(milliseconds: 500),
                  crossFadeState: _frontLeft ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                ),
              ),
              left: 20,
              top: MediaQuery.of(context).size.height / 2 - 75,
            ),

            //FrontRight
            Positioned(
              child: InkWell(
                onTap: (){
                  setState(() {
                    final player = AudioCache();
                    player.play("car_lock_sound.wav");
                    _frontRight = !_frontRight;
                  });
                },
                child: AnimatedCrossFade(
                  firstChild: unlockedWidget(),
                  secondChild: lockedWidget(),
                  duration: const Duration(milliseconds: 500),
                  crossFadeState: _frontRight ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                ),
              ),
              left: 20,
              top: MediaQuery.of(context).size.height / 2 + 25,
            ),

            //BackLeft
            Positioned(
              child: InkWell(
                onTap: (){
                  setState(() {
                    final player = AudioCache();
                    player.play("car_lock_sound.wav");
                    _backLeft = !_backLeft;
                  });
                },
                child: AnimatedCrossFade(
                  firstChild: unlockedWidget(),
                  secondChild: lockedWidget(),
                  duration: const Duration(milliseconds: 500),
                  crossFadeState: _backLeft ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                ),
              ),
              right: 20,
              top: MediaQuery.of(context).size.height / 2 - 75,
            ),

            //BackRight
            Positioned(
              child: InkWell(
                onTap: (){
                  setState(() {
                    final player = AudioCache();
                    player.play("car_lock_sound.wav");
                    _backRight = !_backRight;
                  });
                },
                child: AnimatedCrossFade(
                  firstChild: unlockedWidget(),
                  secondChild: lockedWidget(),
                  duration: const Duration(milliseconds: 500),
                  crossFadeState: _backRight ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                ),
              ),
              right: 20,
              top: MediaQuery.of(context).size.height / 2 + 25,
            ),
          ],
        ),
      )
    );
  }

  Widget unlockedWidget(){
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: const Color(0xEE7ED957),
        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height),
      ),
      alignment: Alignment.center,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height),
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          "assets/unlocked.svg",
          height: 20,
        ),
      ),
    );
  }

  Widget lockedWidget() {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height),
      ),
      alignment: Alignment.center,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height),
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          "assets/locked.svg",
          height: 20,
        ),
      ),
    );
  }
}
