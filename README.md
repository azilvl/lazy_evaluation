## Usage

A simple usage example:

```dart
import 'package:lazy_evaluation/lazy_evaluation.dart';

main() {
  var myLazyString = Lazy<String>(() => 'this is lazily evaluated');
  print(myLazyString.value);
}
```