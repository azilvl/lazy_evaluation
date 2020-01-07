# Lazy Evaluation
A simple package to cache and lazily evaluate objects that have a costly initialization process. 

### Usage

```dart
import 'package:lazy_evaluation/lazy_evaluation.dart';

main() {
  var myLazyString = Lazy<String>(() => 'this is lazily initialized');
  print(myLazyString.value); // alternatively, you can use myLazyString() instead of myLazyString.value
}
```