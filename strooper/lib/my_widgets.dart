import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String message;
  final double width;
  VoidCallback? action;

  Button({
    Key? key,
    required this.message,
    required this.width,
    this.action
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox( 
      width: this.width,
      child: OutlinedButton(
        onPressed: this.action,
        child: Text(this.message)
      )
    );
  }
}

// Creating a custom progress bar without LinearProgressIndicator (only for tests)
class CustomProgressBar extends StatelessWidget {
  final double width;
  final int value;
  final int totalValue;

  CustomProgressBar({
    required this.width, 
    required this.value, 
    required this.totalValue
  });

  @override
  Widget build(BuildContext context) {
    double ratio = this.value / this.totalValue;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.timer),
        SizedBox(width: 5),
        Stack(
          children: <Widget>[
            Container(
              width: this.width,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5)
              )
            ),
            Material(
              borderRadius: BorderRadius.circular(5),
              elevation: 3,
              child: AnimatedContainer(
                height: 10,
                width: this.width * ratio,
                duration: Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  color: (ratio < 0.3) ? Colors.red : (ratio < 0.6) ? Colors.amber[400] : Colors.lightGreen,
                  borderRadius: BorderRadius.circular(5)
                )
              )
            )
          ]
        )
      ]
    );
  }
}

class TimerProgressBar extends StatefulWidget {
  final int durationSeconds;
  final double width;
  final VoidCallback? action;
  final bool repeat;
  final bool doNotStart;

  const TimerProgressBar({
    Key? key, 
    required this.durationSeconds, 
    required this.width,
    this.action = null,
    this.repeat = false,
    this.doNotStart = false
  }) : super(key: key);

  @override
  State<TimerProgressBar> createState() => TimerProgressBarState(
    duration: this.durationSeconds, 
    action: this.action,
    repeat: this.repeat,
    doNotStart: this.doNotStart
  );
}

class TimerProgressBarState extends State<TimerProgressBar> with TickerProviderStateMixin {
  late AnimationController controller;
  final int duration;
  final VoidCallback? action;
  final bool repeat;
  final bool doNotStart;

  TimerProgressBarState({
    required this.duration,
    this.action = null,
    this.repeat = false,
    this.doNotStart = false
  });

  @override
  void initState() {
    this.controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: this.duration)
    )..addListener(() {
      setState(() {});
    });
    /*
    this.controller.forward().whenComplete(() {
      this.action?.call();
    });
    */
    if(!this.doNotStart) {
      this.controller.forward();
      this.controller.addStatusListener((status) {
        if(status == AnimationStatus.completed) {
          this.action?.call();
          if(this.repeat) this.resetProgressBar();
        }
        else if(status == AnimationStatus.dismissed) this.controller.forward();
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.timer),
        SizedBox(width: 5),
        SizedBox( 
          height: 10.0,
          width: widget.width,
          child: LinearProgressIndicator(
            value: this.controller.value
          )
        )
      ]
    );
  }

  void resetProgressBar() {
    this.controller.reset();
  }

  int getCurrentValue() {
    int v = (this.controller.value * 100).toInt();
    return v;
  }
}