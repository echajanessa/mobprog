import 'dart:async';
import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  static const countdownDuration = Duration();
  Duration duration = Duration();
  Timer? timer;

  bool isCountdown = true;

  @override
  void initState() {
    super.initState();
    reset();
  }

  void reset() {
    if (isCountdown) {
      setState(() {
        duration = countdownDuration;
      });
    } else {
      setState(() => duration = Duration(seconds: 15));
    }
  }

  void addTime() {
    final addSeconds = isCountdown ? -1 : 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;

      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
      duration = Duration(seconds: seconds);
    });
  }

  void startTimer({bool resets = true}) {
    if (resets) {
      reset();
    }

    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }

    setState(() {
      timer?.cancel();
      duration = Duration(); // Set duration to zero when stopping the timer
    });
  }


  Future<void> selectTime() async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: duration.inHours,
        minute: duration.inMinutes.remainder(60),
      ),
    );

    if (selectedTime != null) {
      setState(() {
        duration = Duration(
          hours: selectedTime.hour,
          minutes: selectedTime.minute,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildTime(),
          const SizedBox(height: 80),
          buildButtons(),
          const SizedBox(height: 20),
          ButtonWidget(
            text: 'Select Time',
            color: Colors.black,
            backgroundColor: Colors.white,
            onClicked: () {
              selectTime();
            },
          ),
        ],
      ),
    ),
  );

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0;

    return isRunning || !isCompleted
        ? Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonWidget(
          text: isRunning ? 'STOP' : 'RESUME',
          onClicked: () {
            if (isRunning) {
              stopTimer(resets: false);
            } else {
              startTimer(resets: false);
            }
          },
        ),
        const SizedBox(width: 12),
        ButtonWidget(
          text: 'CANCEL',
          onClicked: () {
            stopTimer();
          },
        ),
      ],
    )
        : ButtonWidget(
      text: 'START',
      color: Colors.black,
      backgroundColor: Colors.white,
      onClicked: () {
        startTimer();
      },
    );
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimeCard(time: hours, header: 'Hours'),
        const SizedBox(width: 8),
        buildTimeCard(time: minutes, header: 'Minutes'),
        const SizedBox(width: 8),
        buildTimeCard(time: seconds, header: 'Seconds'),
      ],
    );
  }

  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              time,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 60,
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(header),
        ],
      );
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final Color color;
  final Color backgroundColor;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
    this.color = Colors.white,
    this.backgroundColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: backgroundColor,
    ),
    onPressed: onClicked,
    child: Text(
      text,
      style: TextStyle(color: color),
    ),
  );
}
