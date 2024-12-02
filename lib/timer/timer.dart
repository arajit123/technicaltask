import 'dart:async';

class TimerController {
  Timer? _timer;
  int _seconds = 0;
  int get seconds => _seconds;

  void startTimer(int duration) {
    _seconds = duration;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        _seconds--;
      } else {
        _timer?.cancel();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }
}
