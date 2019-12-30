import 'package:test/test.dart';

import 'package:lazy_evaluation/lazy_evaluation.dart';

void main() {
  var tInt = 1;
  group('[Lazy<T>]', () {
    test(
      'if no one uses [Lazy.value], [Lazy.isValueCreated] should be false',
      () async {
        // arrange
        var lazyInt = Lazy(() {
          return tInt;
        });
        // assert
        expect(lazyInt.isValueCreated, isFalse);
      },
    );
    test(
      '[Lazy.value] and [lazy()] both should return a value',
      () async {
        // arrange
        var lazyInt = Lazy(() {
          return tInt;
        });
        // act
        var result1 = lazyInt.value;
        var result2 = lazyInt();
        // assert
        expect(result1, tInt);
        expect(result2, tInt);
      },
    );

    test(
      'factory should only run once',
      () async {
        // arrange
        var number = tInt;
        var lazyInt = Lazy(() {
          number++;
          return number;
        });
        // act
        // ignore: unused_local_variable
        var temp = lazyInt.value;
        temp = lazyInt.value;
        var result = lazyInt.value;
        result = lazyInt.value;

        // assert
        expect(result, tInt + 1);
      },
    );

    test(
      "multiple non-awaited asynchronous [Lazy.value] calls shouldn't cause multiple factory calls",
      () async {
        // arrange
        var number = tInt;
        var lazyInt = Lazy(() {
          number++;
          return Future<int>(() => number);
        });
        // act

        // ignore: unawaited_futures
        lazyInt.value;
        // ignore: unawaited_futures
        lazyInt.value;
        // ignore: unawaited_futures
        lazyInt.value;
        // ignore: unawaited_futures
        lazyInt.value;

        // assert
        expect(number, tInt + 1);
      },
    );
  });
  group('[MutableLazy<T>]', () {
    test(
      'should be able to change a referenced object in the factory and get updated value',
      () async {
        // arrange
        var number = tInt;
        var lazyInt = MutableLazy(() => number);
        // act
        var result1 = lazyInt.value;
        number = 5;
        lazyInt.notifyChange();
        var result2 = lazyInt.value;
        // assert
        expect(result1 + result2, 6);
      },
    );
  });
}
