import 'dart:async';

import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  //auto scroll-down pada laps history
  ScrollController _scrollController = ScrollController();

  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  String digitSeconds = "00";
  String digitMinutes = "00";
  String digitHours = "00";
  Timer? timer;
  bool started = false;
  List laps = [];

  //fungsi tombol pause
  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  //fungsi tombol reset
  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;

      digitSeconds = '00';
      digitMinutes = '00';
      digitHours = '00';

      started = false;

      //hapus laps history
      laps.clear();
    });
  }

  //fungsi untuk tombol laps
  void addLaps(){
    String lap = "$digitHours:$digitMinutes:$digitSeconds";
    setState(() {
      laps.add(lap);
    });

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  //fungsi untuk start
  void start() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localSeconds = seconds;
      int localMinutes = minutes;
      int localHours = hours;

      //fungsi untuk perpindahan dari detik ke menit dan menit ke jam
      localSeconds++;
      if (localSeconds >= 60) {
        localSeconds = 0;
        localMinutes++;

        if (localMinutes >= 60) {
          localMinutes = 0;
          localHours++;
        }
      }

      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        digitSeconds = (seconds >= 10) ?"$seconds":"0$seconds";
        digitMinutes = (minutes >= 10) ?"$minutes":"0$minutes";
        digitHours = (hours >= 10) ?"$hours":"0$hours";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2757),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 15.0,
              ),
              Center(
                child: Text("$digitHours:$digitMinutes:$digitSeconds",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 60.0,
                      fontWeight: FontWeight.w400
                    ),
                ),
              ),
              Container(
                height: 250.0,
                decoration: BoxDecoration(
                  color: Color(0xFF323F68),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                //list builder
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: laps.length,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Lap ${index+1}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            "${laps[index]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        (!started) ? start() : stop();
                      },
                      shape: const StadiumBorder(
                          side: BorderSide(color: Colors.blue)
                      ),
                      child: Text(
                        (!started)? "Start" : "Pause",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  IconButton(
                    color: Colors.red,
                    onPressed: () {
                      addLaps();
                    },
                    icon: Icon(Icons.flag),
                  ),
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        reset();
                      },
                      fillColor: Colors.blue,
                      shape: const StadiumBorder(),
                      child: Text("Reset",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
