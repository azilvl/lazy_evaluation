import 'package:lazy_evaluation/lazy_evaluation.dart';
import 'dart:math' as math;

class Circle {
  final double radius;

  Future<double> get area => _area.value;
  double get circumference => _circumference.value;

  Lazy<Future<double>> _area;
  Lazy<double> _circumference;

  Circle(this.radius) {
    _circumference = Lazy(() => math.pi * radius * 2);
    _area = Lazy(() async {
      // simulating something heavy and asynchronous
      await Future.delayed(Duration(seconds: 2));
      return math.pi * math.pow(radius, 2);
    });
  }
}

void main() async {
  var circle = Circle(4);
  print(circle.circumference);
  print(await circle.area); // prints area with a 2 seconds delay
  print(await circle.area); // prints area simultaneously
}
