# Lazy Evaluation
[![Build Status](https://travis-ci.com/azilvl/lazy_evaluation.svg?branch=master)](https://travis-ci.com/azilvl/lazy_evaluation)

A simple package to cache and lazily evaluate objects that have a costly initialization process.

### Usage

```dart
import 'package:lazy_evaluation/lazy_evaluation.dart';

main() {
  var myLazyString = Lazy<String>(() => 'this is lazily initialized');
  print(myLazyString.value); // alternatively, you can use myLazyString() instead of myLazyString.value
}
```
