import 'package:beer_barrel/core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late DataRepository dataRepository;
  late MockApiClient mockApiClient;
  late List<Beer> beerList;
  int page = 1;
  setUp(() {
    mockApiClient = MockApiClient();
    dataRepository = DataRepository(mockApiClient);
  });

  beerList = [
    Beer(
        id: 1,
        name: 'Buzz',
        tagline: 'A Real Bitter Experience.',
        firstBrewed: '09/2007',
        description:
            'A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.',
        imageUrl: 'https://images.punkapi.com/v2/keg.png',
        abv: 4.5,
        ibu: 60,
        targetFg: 1010,
        targetOg: 1044,
        ebc: 20,
        srm: 10,
        ph: 4.4,
        attenuationLevel: 75),
    Beer(
        id: 2,
        name: 'Buzz',
        tagline: 'A Real Bitter Experience.',
        firstBrewed: '09/2007',
        description:
            'A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.',
        imageUrl: 'https://images.punkapi.com/v2/keg.png',
        abv: 4.5,
        ibu: 60,
        targetFg: 1010,
        targetOg: 1044,
        ebc: 20,
        srm: 10,
        ph: 4.4,
        attenuationLevel: 75),
  ];
  test('fetchBeerList function should returns a list of beers', () async {
    //Arrange
    when(() => mockApiClient.fetchList(
          '/beers',
          queryParams: {'page': page.toString()},
        )).thenAnswer(
      (_) async => beerList.map((e) => e.toJson()).toList(),
    );
    //Act
    final List<Beer> result = await dataRepository.fetchBeersList(page);

    //Assert
    expect(result, beerList);
  });
}
