import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class TimerReel extends StatefulWidget {
  const TimerReel({Key? key}) : super(key: key);

  @override
  _TimerReelState createState() => _TimerReelState();
}

//class tampilan pop-up
class TimerOverDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Time is Over'),
      content: Text('The time has reached zero.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}

//class untuk memunculkan pop-up saat timer berakhir
class _TimerReelState extends State<TimerReel> {
  late Timer _timer;
  int _start = 30;
  var _isTimerOn = false;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            showTimerOverDialog();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  //fungsi pop-up
  void showTimerOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TimerOverDialog();
      },
    );
  }


  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
      backgroundColor: Colors.amber,

      body: Container(
        padding: const EdgeInsets.only(top: 40.0),
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox( //ukuran slider timer
              width: MediaQuery.of(context).size.width * 0.75,
              height: MediaQuery.of(context).size.width * 0.85,
              child: SleekCircularSlider(
                appearance: CircularSliderAppearance(
                  size: MediaQuery.of(context).size.width * 0.84,
                  customColors: CustomSliderColors(
                    trackColor: Color(0xFF1C2757),
                    progressBarColor: Colors.deepOrangeAccent,
                    dotColor: Colors.white,
                  ),
                  startAngle: 270,
                  angleRange: 360,
                  customWidths: CustomSliderWidths(
                    trackWidth: 36,
                    progressBarWidth: 22,
                    handlerSize: 7,
                  ),
                ),
                min: 0,
                max: 60,
                initialValue: _start.toDouble(),
                onChange: (double value) {
                  setState(() {
                    _start = value.round();
                  });
                },
                innerWidget: (percentage) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${_start.round()}',
                        style: const TextStyle(
                          fontSize: 100,
                          color: Color(0xFF1C2757),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        "seconds",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF1C2757),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: const Text(
                  "Drag to set the timer",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.deepOrangeAccent,
                  ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                if (_isTimerOn) {
                  _timer.cancel();
                  setState(() {
                    _isTimerOn = false;
                    _start = 30;
                  });
                } else {
                  _isTimerOn = true;
                  startTimer();
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.55,
                decoration: BoxDecoration(
                    color: _isTimerOn ? Colors.redAccent : Color(0xFF1C2757),
                    borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  _isTimerOn ? 'Cancel' : 'Start',
                  style: TextStyle(
                    fontSize: 24,
                    color: _isTimerOn ? Colors.white : Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
