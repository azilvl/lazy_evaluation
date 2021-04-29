typedef InitFunction<T> = T Function();

/// Lazily creates `T` when needed.
class Lazy<T> {
  /// during the initialization, the [function]
  /// specified here gets used and creates the value.
  Lazy(InitFunction<T> function) : _factory = function;

  InitFunction<T> _factory;

  /// Returns true if the [value] has been created and cached.
  bool get isValueCreated => _isValueCreated;
  bool _isValueCreated = false;

  /// the lazily initialized value.
  T get value => _isValueCreated ? _value : _createValue();
  late T _value;

  /// Returns the lazily initialized [value].
  T call() => value;

  T _createValue() {
    _value = _factory();
    _factory = () => Never as T;
    _isValueCreated = true;
    return _value;
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) || (other is Lazy && other._value == _value);

  @override
  int get hashCode => _value.hashCode;
}

/// Lazily creates `T` when needed.
/// gets notified by a [notifyChange()] call that something
/// has been modified and it needs to re-create the value.
///
/// ```dart
/// var number = 1;
/// var mutableLazy = MutableLazy(() => number * 3);
/// print(mutableLazy.value); // 3
/// number = 2;
/// mutableLazy.notifyChange();
/// print(mutableLazy.value); // 6
/// ```
class MutableLazy<T> extends Lazy<T> {
  /// for each initialization, the [function] specified
  /// here gets used and creates the value.
  MutableLazy(InitFunction<T> function) : super(function);

  /// Notifies the Lazy object that something that was
  /// used in the init function has been changed and it needs to
  /// re-initialize next time it tries to get the [value].
  void notifyChange() {
    _isValueCreated = false;
  }

  @override
  T _createValue() {
    _value = _factory();
    _isValueCreated = true;
    return _value;
  }
}
