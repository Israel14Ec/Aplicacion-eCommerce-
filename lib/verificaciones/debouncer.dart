import 'dart:async';

class Debouncer {
  final Duration? delay;
  Timer? _timer;

  Debouncer({this.delay});

  void call(void Function() accion) {
    _timer?.cancel();
    _timer = Timer(delay!, accion);
  }

  /// Notifica si el delay esta funcionando
  bool get isCorriendo => _timer?.isActive ?? false;

  /// Cancela el delay actual
  void cancel() => _timer?.cancel();
}
