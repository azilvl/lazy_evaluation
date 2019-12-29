typedef LazyFactory<T> = T Function();

class Lazy<T> {
  bool get isValueCreated => _isValueCreated;
  T get value => _isValueCreated ? _value : _createValue();
  T call() => value;
  LazyFactory<T> _factory;
  T _value;
  bool _isValueCreated = false;

  Lazy(this._factory);

  T _createValue() {
    assert(_factory != null, "Lazy factory shouldn't be null");
    _value = _factory();
    _factory = null;
    _isValueCreated = true;
    return _value;
  }
}
