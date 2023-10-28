import 'package:beer_barrel/core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

Uri _beersUrl() {
  return Uri.https(
    'api.punkapi.com',
    '/v2/beers',
    <String, String>{
      'per_page': "10",
    },
  );
}

void main() {
  group('PunkApiClient tests', () {
    late ApiClient apiClient;
    late MockHttpClient mockHttpClient;
    const responseString =
        '''[ { "id": 1, "name": "Beer 1", "tagline": "tagline", "first_brewed": "firstbrewed", "description": "description", "image_url": "imageurl", "abv": 1, "ibu": 10, "target_fg": 1011, "target_og": 1040, "ebc": 20, "srm": 30, "ph": 4.5, "attenuation_level": 45 }, { "id": 2, "name": "Beer 2", "tagline": "tagline", "first_brewed": "firstbrewed", "description": "description", "image_url": "imageurl", "abv": 1, "ibu": 10, "target_fg": 1011, "target_og": 1040, "ebc": 20, "srm": 30, "ph": 4.5, "attenuation_level": 45 }]''';
    setUp(() {
      mockHttpClient = MockHttpClient();
      apiClient = ApiClient(mockHttpClient);
    });
    setUpAll(() {
      registerFallbackValue(Uri());
    });
    test('fetchList should returns a list when successful', () async {
      final response = http.Response(responseString, 200);
      when(() => mockHttpClient.get(_beersUrl()))
          .thenAnswer((_) async => Future.value(response));

      final result = await apiClient.fetchList('/beers');

      expect(result, isA<List<dynamic>>());
      expect(result.length, equals(2));
    });

    test('fetchList throws a BBException when unsuccessful', () async {
      final response = http.Response('Error fetching data', 404);
      when(() => mockHttpClient.get(_beersUrl()))
          .thenAnswer((_) async => response);

      expect(() => apiClient.fetchList('/beers'), throwsA(isA<Exception>()));
    });
  });
}
