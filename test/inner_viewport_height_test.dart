import 'package:flutter_test/flutter_test.dart';
import 'package:pixiv_app/detail_page.dart';

void main() {
  group('innerViewportHeight', () {
    test('empty heights returns zero', () {
      expect(innerViewportHeight([], 0), 0);
    });

    test('single page always returns its height', () {
      expect(innerViewportHeight([300], 0), 300);
      expect(innerViewportHeight([300], 5), 300);
    });

    test('exact index returns that page height', () {
      expect(innerViewportHeight([300, 600], 1), 600);
    });

    test('midpoint lerps between neighbors', () {
      expect(innerViewportHeight([300, 600], 0.5), 450);
    });

    test('position clamps to first and last', () {
      expect(innerViewportHeight([300, 600], -2), 300);
      expect(innerViewportHeight([300, 600], 99), 600);
    });
  });
}
