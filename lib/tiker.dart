class Ticker {
  static final Ticker _instance = Ticker._internal();

  factory Ticker() => _instance;

  Ticker._internal();

  Stream<int> tick() => Stream.periodic(const Duration(seconds: 1), (_) => _);
}
