typedef LazyFactory<T> = T Function();

class Lazy<T> {
  /// Returns true if the [value] has been created and cached.
  bool get isValueCreated => _isValueCreated;

  /// Returns the evaluated value.
  /// If the value hasn't been evaluated yet, it runs the [_factory] and gets the value,
  /// Else it returns the cached value.
  T get value => _isValueCreated ? _value : _createValue();

  /// Returns the evaluated value.
  /// If the value hasn't been evaluated yet, it runs the [_factory] and gets the value,
  /// Else it returns the cached value.
  T call() => value;

  /// Takes a function ([_factory]) that returns [T].
  Lazy(this._factory);

  LazyFactory<T> _factory;
  T _value;
  bool _isValueCreated = false;

  T _createValue() {
    assert(_factory != null, "Lazy factory shouldn't be null");
    _value = _factory();
    _factory = null;
    _isValueCreated = true;
    return _value;
  }
}

class MutableLazy<T> extends Lazy<T> {
  MutableLazy(LazyFactory<T> factory) : super(factory);

  /// Notifies the Lazy object that something that was used in the [_factory] has been changed and it needs to re-evaluate next time it tries to get the object.
  //TODO: think of a better name for this.
  void reEvaluate() {
    _isValueCreated = false;
    _value = null;
  }

  @override
  T _createValue() {
    assert(_factory != null, "Lazy factory shouldn't be null");
    _value = _factory();
    _isValueCreated = true;
    return _value;
  }
}
