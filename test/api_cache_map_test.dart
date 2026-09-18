import 'package:flutter_test/flutter_test.dart';
import 'package:pixiv_app/api_cache.dart';

void main() {
  test('deepStringKeys re-keys nested maps like a Hive round-trip', () {
    // Shape of a Hive-read payload: Map<dynamic, dynamic> all the way down,
    // including maps nested inside lists. The `as` casts below are the
    // regression assertion: before the fix, nested levels stayed
    // Map<dynamic, dynamic> and dart_mappable's generated decoders threw
    // MapperException on them (see illust:149479444 log).
    final hiveShaped = <dynamic, dynamic>{
      'error': false,
      'body': <dynamic, dynamic>{
        'illust_details': <dynamic, dynamic>{'id': '1'},
        'pages': [
          <dynamic, dynamic>{
            'urls': <dynamic, dynamic>{'original': 'https://x'},
          },
        ],
      },
    };
    final out = deepStringKeys(hiveShaped) as Map<String, dynamic>;
    final body = out['body'] as Map<String, dynamic>;
    expect((body['illust_details'] as Map<String, dynamic>)['id'], '1');
    final page = (body['pages'] as List).first as Map<String, dynamic>;
    expect((page['urls'] as Map<String, dynamic>)['original'], 'https://x');
    expect(out['error'], isFalse);
  });
}
