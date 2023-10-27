import 'dart:io';

import 'package:beer_barrel/core/core.dart';
import 'package:beer_barrel/home/home.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../account/account_cubit_test.dart';

class MockDataRepository extends Mock implements DataRepository {}

void main() {
  group('HomeCubit', () {
    late HomeCubit homeCubit;
    late MockDataRepository dataRepository;

    setUp(() {
      dataRepository = MockDataRepository();
      homeCubit = HomeCubit(dataRepository);
    });

    test('initial state is InitialHomeState', () {
      expect(homeCubit.state, InitialHomeState());
    });

    test(
        'fetchBeerList() emits DataFetchedSuccessHomeState on successful fetch',
        () async {
      // Arrange
      final mockBeers = [
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

      when(() => dataRepository.fetchBeersList(1))
          .thenAnswer((_) async => mockBeers);

      // Act
      await homeCubit.fetchBeerList(MockBuildContext());

      // Assert
      expect(homeCubit.state, DataFetchedSuccessHomeState());
      expect(homeCubit.beers, mockBeers);
    });

    test(
        'fetchBeerList should emits ErrorHomeState with status code 900 on network error',
        () async {
      // Arrange
      when(() => dataRepository.fetchBeersList(1))
          .thenThrow(const SocketException('Network error'));

      // Act
      await homeCubit.fetchBeerList(MockBuildContext());

      expect(homeCubit.state, ErrorHomeState(900));
      expect(homeCubit.beers, isEmpty);
    });

    test('fetchBeerList should emits ErrorHomeState on generic error',
        () async {
      // Arrange
      when(() => dataRepository.fetchBeersList(1))
          .thenThrow(Exception('Generic error'));

      // Act
      await homeCubit.fetchBeerList(MockBuildContext());

      // Assert
      expect(homeCubit.state, isA<ErrorHomeState>());
      expect(homeCubit.beers, isEmpty);
    });

    test('resetPage should reset a pageNumber to 1', () async {
      // Act
      homeCubit.resetPage();
      // Assert
      expect(homeCubit.pageNumber, 1);
    });

    tearDown(() {
      homeCubit.close();
    });
  });
}
