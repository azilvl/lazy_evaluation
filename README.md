## Usage

```dart
import 'package:lazy_evaluation/lazy_evaluation.dart';

main() {
  var myLazyString = Lazy<String>(() => 'this is lazily evaluated');
  print(myLazyString.value); // you can also use myLastString() instead of myLastString.value
}
```