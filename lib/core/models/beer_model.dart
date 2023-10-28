import 'package:equatable/equatable.dart';

class Beer extends Equatable {
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

  Beer({
    this.id,
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
  });

  Beer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tagline = json['tagline'];
    firstBrewed = json['first_brewed'];
    description = json['description'];
    imageUrl = json['image_url'];
    abv = json['abv'] ?? 0;
    ibu = json['ibu'] ?? 0;
    targetFg = json['target_fg'] ?? 0;
    targetOg = json['target_og'] ?? 0;
    ebc = json['ebc'] ?? 0;
    srm = json['srm'] ?? 0;
    ph = json['ph'] ?? 0;
    attenuationLevel = json['attenuation_level'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
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
    return data;
  }

  //Beer Ingredients map
  Map<String, String?> getIngredientsMap() {
    Map<String, String?> ingredientContent = {
      "ABV": "$abv",
      "IBU": "$ibu",
      "Target FG": "$targetFg",
      "Target OG": "$targetOg",
      "EBC": "$ebc",
      "SRM": "$srm",
      "PH": "$ph",
      "ATTENTION LEVEL": "$attenuationLevel",
    };
    return ingredientContent;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        tagline,
        firstBrewed,
        description,
        imageUrl,
        abv,
        ibu,
        targetFg,
        targetOg,
        ebc,
        srm,
        ph,
        attenuationLevel
      ];
}
