class Curves {
  static Map<int, int> _standardCurveCache = Map<int, int>();

  static int standardCurve(int value) {
    if(_standardCurveCache.containsKey(value)) {
      return _standardCurveCache[value];
    } else {
      _standardCurveCache[value] = ((8.0 * value * value) / 171.0 + (91.0 * value) / 57.0 - (110.0 / 171.0)).round();
      return _standardCurveCache[value];
    }
  }
}