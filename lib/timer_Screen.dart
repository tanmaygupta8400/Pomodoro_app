import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  String AppTitle;

   TimerScreen({Key? key,required this.AppTitle}) : super(key: key);

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> with TickerProviderStateMixin  {

  Timer? _timer;
  int _start = 1500;
  bool workTimer = true;

  String intToTimeLeft(int value) {
    int h, m, s;
    h = value ~/ 3600;
    m = ((value - h * 3600)) ~/ 60;
    s = value - (h * 3600) - (m * 60);
    String hourLeft =
    h.toString().length < 2 ? "0" + h.toString() : h.toString();
    String minuteLeft =
    m.toString().length < 2 ? "0" + m.toString() : m.toString();
    String secondsLeft =
    s.toString().length < 2 ? "0" + s.toString() : s.toString();
    String result = hourLeft == "00"
        ? minuteLeft + " : " + secondsLeft + ""
        : hourLeft + " : " + minuteLeft + " : " + secondsLeft + "";
    return result;
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0 ) {
          setState(() {
            workTimer = !workTimer;
            if(workTimer )
              {
                _start+=1500;
              }
            else{
              _start+=300;

            }



          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }



  @override
  void initState() {
    super.initState();
    startTimer();

  }
  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  onSystemBackButtonPressed(BuildContext context) {
    EndSession(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () => onSystemBackButtonPressed(context),
            ),
          ),
          title:  Text(widget.AppTitle.toString()+" Timer"),
        ),
        body: WillPopScope(
          onWillPop:()=> onSystemBackButtonPressed(context),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    workTimer
                        ?  Text("Work time ends in:")
                        : Text("Rest time ends in:"),
                    Text(intToTimeLeft(_start).toString(),
                      style: TextStyle(
                          fontSize: 60,
                        color: workTimer ? Colors.red : Colors.green,
                      ),)
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(8.0),
                child: Container(

                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    onPressed: () {
                      setState(() {
                        onSystemBackButtonPressed(context);
                      });

                    },
                    child: Text('End',style: TextStyle(fontFamily: 'Gilroy'),),
                  ),),
              )
            ],
          ),
        ),

    );
  }
}


Future EndSession(BuildContext context ) {
  return showDialog(context: context, builder: (context)=>
      AlertDialog(
          contentPadding: EdgeInsets.symmetric(vertical: 20),
          content: Container(
            width: MediaQuery.of(context).size.width*0.8,
            height:MediaQuery.of(context).size.height*0.2,
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      children: [
                        Text(' Confirm to End Session?',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),

                        // Text(messageBody),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.grey),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('NO',style: TextStyle(fontFamily: 'Gilroy'),),
                      ),
                      SizedBox(width: 10,),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.red),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text('Yes',style: TextStyle(fontFamily: 'Gilroy'),),
                      ),
                    ],
                  ),
                ),


              ],
            ),
          ))
  );
}
