extension FutureX on Future {
  /// Load multi request in same time:
  /// [params]:
  /// [numRequest]: num of request in same time;
  static Future<List> separateRequest(
    Iterable<Future> futures, {
    int numRequest = 2,
  }) async {
    final List results = [];
    final iterator = futures.iterator;

    while (iterator.moveNext()) {
      final _iterator = [iterator.current];
      for (int i = 0; i < 1; i++) {
        if (iterator.moveNext()) {
          _iterator.add(iterator.current);
        }
      }
      await Future.wait(_iterator).then(results.addAll);
    }
    return results;
  }
}
