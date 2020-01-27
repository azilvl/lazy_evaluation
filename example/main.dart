import 'dart:math' as math;
import 'package:lazy_evaluation/lazy_evaluation.dart';

class Circle {
  Circle(this.radius) {
    _circumference = Lazy(() => math.pi * radius * 2);
    _area = Lazy(() async {
      // simulating something heavy and asynchronous
      await Future.delayed(const Duration(seconds: 2));
      return math.pi * math.pow(radius, 2);
    });
  }
  final double radius;

  Lazy<Future<double>> _area;
  Lazy<double> _circumference;
  Future<double> get area => _area.value;
  double get circumference => _circumference.value;
}

Future<void> main() async {
  final circle = Circle(4);
  print(circle.circumference);
  print(await circle.area); // prints area with a 2 seconds delay
  print(await circle.area); // prints area immediately
}
