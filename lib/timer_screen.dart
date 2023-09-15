import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TimerScreen(),
    );
  }
}

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;
  int _totalSeconds = 0;
  int _endTime = DateTime.now().millisecondsSinceEpoch + 0; // Initial value, will be updated later

  void _startTimer() {
    // Calculate the total time in seconds
    _totalSeconds = (_hours * 3600) + (_minutes * 60) + _seconds;

    // Calculate the end time in milliseconds since epoch
    _endTime = DateTime.now().millisecondsSinceEpoch + (_totalSeconds * 1000);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Hours Picker
                Text('HH: '),
                DropdownButton<int>(
                  value: _hours,
                  items: List.generate(24, (index) => index)
                      .map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString().padLeft(2, '0')),
                    );
                  })
                      .toList(),
                  onChanged: (int? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _hours = newValue;
                      });
                    }
                  },
                ),

                // Minutes Picker
                Text('MM: '),
                DropdownButton<int>(
                  value: _minutes,
                  items: List.generate(60, (index) => index)
                      .map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString().padLeft(2, '0')),
                    );
                  })
                      .toList(),
                  onChanged: (int? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _minutes = newValue;
                      });
                    }
                  },

                ),


                // Seconds Picker
                Text('SS: '),
                DropdownButton<int>(
                  value: _seconds,
                  items: List.generate(60, (index) => index)
                      .map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString().padLeft(2, '0')),
                    );
                  })
                      .toList(),
                  onChanged: (int? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _seconds = newValue;
                      });
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _startTimer,
              child: Text('Start Timer'),
            ),
            SizedBox(height: 20.0),
            CountdownTimer(
              endTime: _endTime,
              widgetBuilder: (BuildContext context, CurrentRemainingTime? time) {
                if (time == null) {
                  return Text('Timer has ended');
                }
                return Text(
                  '${time.hours}:${time.min}:${time.sec}',
                  style: TextStyle(fontSize: 48),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

}
