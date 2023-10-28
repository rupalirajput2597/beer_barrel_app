import 'package:beer_barrel/core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Map<String, dynamic> beerJson;
  late final Beer beer;

  setUpAll(() {
    beerJson = {
      "id": 1,
      "name": "Buzz",
      "tagline": "A Real Bitter Experience.",
      "first_brewed": "09/2007",
      "description":
          "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.",
      "image_url": "https://images.punkapi.com/v2/keg.png",
      "abv": 4.5,
      "ibu": 60,
      "target_fg": 1010,
      "target_og": 1044,
      "ebc": 20,
      "srm": 10,
      "ph": 4.4,
      "attenuation_level": 75
    };

    beer = Beer(
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
        attenuationLevel: 75);
  });
  group("validating Beer Model", () {
    test('fromJson() should return a valid Beer object', () {
      final Beer beer = Beer.fromJson(beerJson);

      expect(beer.id, 1);
      expect(beer.name, 'Buzz');
      expect(beer.tagline, 'A Real Bitter Experience.');
      expect(beer.firstBrewed, '09/2007');
      expect(beer.description,
          'A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.');
      expect(beer.imageUrl, 'https://images.punkapi.com/v2/keg.png');
      expect(beer.abv, 4.5);
      expect(beer.ibu, 60);
      expect(beer.targetFg, 1010);
      expect(beer.targetOg, 1044);
      expect(beer.ebc, 20);
      expect(beer.srm, 10);
      expect(beer.ph, 4.4);
      expect(beer.attenuationLevel, 75);
    });

    test('toJson() should return a valid JSON object', () {
      final json = beer.toJson();

      expect(json, {
        "id": 1,
        "name": "Buzz",
        "tagline": "A Real Bitter Experience.",
        "first_brewed": "09/2007",
        "description":
            "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.",
        "image_url": "https://images.punkapi.com/v2/keg.png",
        "abv": 4.5,
        "ibu": 60,
        "target_fg": 1010,
        "target_og": 1044,
        "ebc": 20,
        "srm": 10,
        "ph": 4.4,
        "attenuation_level": 75
      });
    });

    test("should return Beer Ingredients map", () {
      final Map<String, dynamic> ingredients = beer.getIngredientsMap();

      expect(ingredients, <String, dynamic>{
        "ABV": '4.5',
        "IBU": '60',
        "Target FG": '1010',
        "Target OG": '1044',
        "EBC": '20',
        "SRM": '10',
        "PH": '4.4',
        "ATTENTION LEVEL": '75',
      });
    });
  });
}
