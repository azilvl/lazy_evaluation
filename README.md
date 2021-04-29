# Lazy Evaluation
[![Build Status](https://travis-ci.com/azilvl/lazy_evaluation.svg?branch=master)](https://travis-ci.com/azilvl/lazy_evaluation)

A simple package to cache and lazily evaluate objects that have a costly initialization process.

### Usage

```dart
import 'package:lazy_evaluation/lazy_evaluation.dart';

main() {
  var myLazyString = Lazy<String>(() => 'this is lazily initialized');
  print(myLazyString.value); 
  print(myLazyString()); // you can use myLazyString() instead of myLazyString.value.
}
```
\
\
\
Note: With null-safety and the `late` keyword in dart now you basically have lazy initialization without needing this package like this:
```dart
main() {
  late var myLazyString = 'this is lazily initialized';
  print(myLazyString); 
}
```
It still makes sense to keep this up because it has some advantages over late lazies. for example with late you have to initialize the variable right where you're defining it or it wont be lazy. 

Also this package has `MutableLazy` which gives you the ability to reset the variable's state by using the `reset()` function. after a `reset()` call the function reruns and updates the lazy value.

```dart
var number = 1;
var mutableLazy = MutableLazy(() => number * 3);
print(mutableLazy.value); // 3
number = 2;
print(mutableLazy.value); // 3
mutableLazy.reset();
print(mutableLazy.value); // 6
```

This package tries to have as little overhead as it can, but using the `late` keyword instead whenever it does the job is still recommended.