class TraversalGuard {
  static int _depth = 0;

  static bool get active => _depth > 0;

  static void enter() => _depth++;

  static void exit() {
    if (_depth > 0) _depth--;
  }
}
