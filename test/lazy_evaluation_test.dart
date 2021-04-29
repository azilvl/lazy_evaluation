import 'package:lazy_evaluation/lazy_evaluation.dart';
import 'package:test/test.dart';

void main() {
  const tInt = 1;
  group('[Lazy<T>]', () {
    test(
      'if no one uses [Lazy.value], [Lazy.isValueCreated] should be false',
      () {
        // arrange
        final lazyInt = Lazy(() {
          return tInt;
        });
        // assert
        expect(lazyInt.isValueCreated, isFalse);
      },
    );
    test(
      '[Lazy.value] and [lazy()] both should return a value',
      () {
        // arrange
        final lazyInt = Lazy(() {
          return tInt;
        });
        // act
        final result1 = lazyInt.value;
        final result2 = lazyInt();
        // assert
        expect(result1, tInt);
        expect(result2, tInt);
      },
    );

    test(
      'factory should only run once',
      () {
        // arrange
        var number = tInt;
        final lazyInt = Lazy(() {
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
      () {
        // arrange
        var number = tInt;
        final lazyInt = Lazy(() {
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
    test(
      'two instances with the same value should be equal',
      () {
        // arrange
        final lazy1 = Lazy(() => tInt);
        final lazy2 = Lazy(() => tInt);
        // act
        lazy1.value;
        lazy2.value;
        // assert
        expect(lazy1, lazy2);
      },
    );
  });
  group('[MutableLazy<T>]', () {
    test(
      'should be able to change a referenced object in the factory and get updated value',
      () {
        // arrange
        var number = tInt;
        final lazyInt = MutableLazy(() => number);
        // act
        final result1 = lazyInt.value;
        number = 5;
        lazyInt.notifyChange();
        final result2 = lazyInt.value;
        // assert
        expect(result1 + result2, number + tInt);
      },
    );
    test(
      'two instances with the same value should be equal',
      () {
        var number = tInt - 1;
        // arrange
        final lazy1 = MutableLazy(() => tInt);
        final lazy2 = MutableLazy(() => number);
        // act
        lazy1.value;
        lazy2.value;
        number++;
        lazy2.notifyChange();
        lazy2.value;
        // assert
        expect(lazy1, lazy2);
      },
    );
  });
}
