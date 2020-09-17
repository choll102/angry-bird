import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'bird_angry.dart';
import 'barriers.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  static double birdsY = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdsY;
  bool gameHasStarted = false;
  int hightscore = 0;
  int score = 0;

  static double barrierX1 = 1;
  double barrierX2 = barrierX1 + 1.5;


  void jum(){
   setState(() {
      time =0;
      initialHeight = birdsY;
   });
  }
  void _showDiglog(){
    showDialog(context: context,
      builder: (BuildContext context){
      return AlertDialog(
        backgroundColor: Colors.brown,
        title: Text('GAME OVER',style: TextStyle(color: Colors.white),),
        content: Text('Score: '+ score.toString(),style: TextStyle(color: Colors.white),),
        actions: [
          FlatButton(
            child: Text('Play Again',style: TextStyle(color: Colors.white),),
            onPressed: (){
              if(score > hightscore){
                hightscore = score;
              }
              // initState();
              setState(() {
                gameHasStarted = false;
              });
                 Navigator.pop(context);
            },
          ),
        ],
      );
      }
    );
  }
  void startGame(){
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 50), (timer){
      time += 0.04;
      height = -4.9 * pow(time, 2) + 2.8 * time;
      setState(() {
        birdsY = initialHeight - height;
      });
      setState(() {
        if(barrierX1 < -1.5){
          barrierX1 += 3;
        }else{
          barrierX1 -= 0.05;
        }
      });
      setState(() {
        if(barrierX2 < -1.5){
          barrierX2 += 3;
        }else{
          barrierX2 -= 0.05;
        }
      });
      if(birdsY > 1){
        timer.cancel();
        gameHasStarted = false;

      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(gameHasStarted == true){
          jum();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Stack(
                children: <Widget>[
                  AnimatedContainer(
                    alignment: Alignment(0,birdsY),
                    duration: Duration(microseconds: 0),
                    color: Colors.blue,
                    child: MyBird(
                    ),
                  ),
                  Container(
                    alignment: Alignment(0,-0.3),
                    child: gameHasStarted ? Text(' ') : Text('T A P  AND  T A P',style: TextStyle(fontSize: 20,color: Colors.white),),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierX1,1.0),
                    duration: Duration(milliseconds: 0),
                    child: MyBarriers(
                      size: 200.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierX1,-1.0),
                    duration: Duration(milliseconds: 0),
                    child: MyBarriers(
                      size: 150.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierX2,1.1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarriers(
                      size: 180.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierX2,-1.1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarriers(
                      size: 140.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('SCORE',style: TextStyle(color: Colors.white, fontSize: 15,),),
                        SizedBox(
                          width: 30,
                          height: 30,
                        ),
                        Text('$score',style: TextStyle(color: Colors.white, fontSize: 15,),),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('BEST',style: TextStyle(color: Colors.white, fontSize: 15,),),
                        SizedBox(
                          height: 30,
                          width: 30,
                        ),
                        Text('$hightscore',style: TextStyle(color: Colors.white, fontSize: 15,),),
                      ],
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
