import 'dart:async';
import 'package:aumetass1/gui/products_page.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _WelcomeState();
  }

}



class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin{

  late final AnimationController _controller;
  late final Animation<double> _animation;

  late TextAlign theAlignment;
  late String welcomeTitle;
  bool isLoading = true;



  late Timer _timer;
  int _start = 3;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);

    startTimer();

  }

  @override
  void dispose(){
    _timer.cancel();
    super.dispose();
  }



  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
            if(_start == 0){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductGridScreen()));
            }
            if(_start == 1){
              _controller.forward();
            }
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
           ),
            Center(
              child: FadeTransition(
                opacity:_animation ,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network("https://aumet.com/wp-content/uploads/2022/08/AumetLogo.png",
                      width: 250.0,
                    )
                ),
              ),
            ),

          ],
        )
    );
  }
}