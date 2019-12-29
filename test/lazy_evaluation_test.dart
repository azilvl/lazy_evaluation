import 'package:test/test.dart';

import 'package:lazy_evaluation/lazy_evaluation.dart';

void main() {
  var tInt = 1;

  test(
    'if no one uses [Lazy.value], [Lazy.isValueCreated] should be false',
    () async {
      // arrange
      var lazyint = Lazy(() {
        return tInt;
      });
      // assert
      expect(lazyint.isValueCreated, isFalse);
    },
  );
  test(
    '[Lazy.value] should return value',
    () async {
      // arrange
      var lazyint = Lazy(() {
        return tInt;
      });
      // act
      var result = lazyint.value;
      // assert
      expect(result, tInt);
    },
  );

  test(
    'factory should only run once',
    () async {
      // arrange
      var number = tInt;
      var lazyint = Lazy(() {
        number++;
        return number;
      });
      // act
      // ignore: unused_local_variable
      var temp = lazyint.value;
      temp = lazyint.value;
      var result = lazyint.value;
      result = lazyint.value;

      // assert
      expect(result, tInt + 1);
    },
  );

  test(
    "multiple non-awaited asynchronous [Lazy.value] calls shouldn't cause multiple factory calls",
    () async {
      // arrange
      var number = tInt;
      var lazyint = Lazy(() {
        number++;
        return Future<int>(() => number);
      });
      // act

      // ignore: unawaited_futures
      lazyint.value;
      // ignore: unawaited_futures
      lazyint.value;
      // ignore: unawaited_futures
      lazyint.value;
      // ignore: unawaited_futures
      lazyint.value;

      // assert
      expect(number, tInt + 1);
    },
  );
}
