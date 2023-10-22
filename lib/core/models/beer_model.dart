import '../core.dart';

class Beer {
  int? id;
  String? name;
  String? tagline;
  String? firstBrewed;
  String? description;
  String? imageUrl;
  num? abv;
  num? ibu;
  num? targetFg;
  num? targetOg;
  num? ebc;
  num? srm;
  num? ph;
  num? attenuationLevel;
  Volume? volume;
  Volume? boilVolume;
  Method? method;
  BeerIngredients? ingredients;
  List<String>? foodPairing;
  String? brewersTips;
  String? contributedBy;

  Beer(
      {this.id,
      this.name,
      this.tagline,
      this.firstBrewed,
      this.description,
      this.imageUrl,
      this.abv,
      this.ibu,
      this.targetFg,
      this.targetOg,
      this.ebc,
      this.srm,
      this.ph,
      this.attenuationLevel,
      this.volume,
      this.boilVolume,
      this.method,
      this.ingredients,
      this.foodPairing,
      this.brewersTips,
      this.contributedBy});

  Beer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tagline = json['tagline'];
    firstBrewed = json['first_brewed'];
    description = json['description'];
    imageUrl = json['image_url'];

    abv = json['abv'];
    ibu = json['ibu'];

    targetFg = json['target_fg'];
    targetOg = json['target_og'];
    ebc = json['ebc'];
    srm = json['srm'];

    ph = json['ph'];

    attenuationLevel = json['attenuation_level'];
    volume = json['volume'] != null ? Volume.fromJson(json['volume']) : null;

    boilVolume = json['boil_volume'] != null
        ? Volume.fromJson(json['boil_volume'])
        : null;
    method = json['method'] != null ? Method.fromJson(json['method']) : null;
    ingredients = json['ingredients'] != null
        ? BeerIngredients.fromJson(json['ingredients'])
        : null;

    foodPairing = json['food_pairing'].cast<String>();
    brewersTips = json['brewers_tips'];
    contributedBy = json['contributed_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['tagline'] = tagline;
    data['first_brewed'] = firstBrewed;
    data['description'] = description;
    data['image_url'] = imageUrl;
    data['abv'] = abv;
    data['ibu'] = ibu;
    data['target_fg'] = targetFg;
    data['target_og'] = targetOg;
    data['ebc'] = ebc;
    data['srm'] = srm;
    data['ph'] = ph;
    data['attenuation_level'] = attenuationLevel;
    if (volume != null) {
      data['volume'] = volume!.toJson();
    }
    if (boilVolume != null) {
      data['boil_volume'] = boilVolume!.toJson();
    }
    if (method != null) {
      data['method'] = method!.toJson();
    }
    if (ingredients != null) {
      data['ingredients'] = ingredients!.toJson();
    }
    data['food_pairing'] = foodPairing;
    data['brewers_tips'] = brewersTips;
    data['contributed_by'] = contributedBy;
    return data;
  }

  Map<String, String?> getIngredientsMap() {
    Map<String, String?> ingredientContent = {
      "ABV": "${abv}",
      "IBU": "${ibu}",
      "Target FG": "${targetFg}",
      "Target OG": "${targetOg}",
      "EBC": "${ebc}",
      "SRM": "${srm}",
      "PH": "${ph}",
      "ATTENTION LEVEL": "${attenuationLevel}",
    };
    return ingredientContent;
    //      Map<String, String?> ingredientContent = {
    //   "ABV": "${beer?.abv}",
    //   "IBU": "${beer?.ibu}",
    //   "Target FG": "${beer?.targetFg}",
    //   "Target OG": "${beer?.targetOg}",
    //   "EBC": "${beer?.ebc}",
    //   "SRM": "${beer?.srm}",
    //   "PH": "${beer?.ph}",
    //   "ATTENTION LEVEL": "${beer?.attenuationLevel}",
    //
    // };
  }
}

class Volume {
  num? value;
  String? unit;

  Volume({this.value, this.unit});

  Volume.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['unit'] = unit;
    return data;
  }
}

class Method {
  List<MashTemp>? mashTemp;
  Fermentation? fermentation;
  dynamic twist;

  Method({this.mashTemp, this.fermentation, this.twist});

  Method.fromJson(Map<String, dynamic> json) {
    if (json['mash_temp'] != null) {
      mashTemp = <MashTemp>[];
      json['mash_temp'].forEach((v) {
        mashTemp!.add(MashTemp.fromJson(v));
      });
    }
    fermentation = json['fermentation'] != null
        ? Fermentation.fromJson(json['fermentation'])
        : null;
    twist = json['twist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (mashTemp != null) {
      data['mash_temp'] = mashTemp!.map((v) => v.toJson()).toList();
    }
    if (fermentation != null) {
      data['fermentation'] = fermentation!.toJson();
    }
    data['twist'] = twist;
    return data;
  }
}

class MashTemp {
  Volume? temp;
  int? duration;

  MashTemp({this.temp, this.duration});

  MashTemp.fromJson(Map<String, dynamic> json) {
    temp = json['temp'] != null ? Volume.fromJson(json['temp']) : null;
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (temp != null) {
      data['temp'] = temp!.toJson();
    }
    data['duration'] = duration;
    return data;
  }
}

class Fermentation {
  Volume? temp;

  Fermentation({this.temp});

  Fermentation.fromJson(Map<String, dynamic> json) {
    temp = json['temp'] != null ? Volume.fromJson(json['temp']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (temp != null) {
      data['temp'] = temp!.toJson();
    }
    return data;
  }
}
