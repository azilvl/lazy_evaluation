typedef LazyFactory<T> = T Function();

/// Lazily returns `T` when needed.
class Lazy<T> {
  /// Returns true if the [value] has been created and cached.
  bool get isValueCreated => _isValueCreated;

  /// Returns the evaluated object.
  /// If the object hasn't been evaluated yet, it runs the factory and gets it,
  /// Else it returns the cached [value].
  T get value => _isValueCreated ? _value : _createValue();

  /// Returns the evaluated object.
  /// If the object hasn't been evaluated yet, it runs the factory and gets it,
  /// Else it returns the cached [value].
  T call() => value;

  /// Takes a function that returns `T`.
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

/// Lazily returns `T` when needed. 
/// gets notified by a [reEvaluate()] call that something has been modified and it needs to re-evaluate.
class MutableLazy<T> extends Lazy<T> {
  /// Takes a function that returns `T`.
  MutableLazy(LazyFactory<T> factory) : super(factory);

  //TODO: think of a better name for this.
  /// Notifies the [Lazy] object that something that was used in the factory has been changed and it needs to re-evaluate next time it tries to get the object.
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
