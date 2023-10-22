import '../core.dart';

class BeerIngredients {
  List<Malt>? malt;
  List<Hops>? hops;
  String? yeast;

  BeerIngredients({this.malt, this.hops, this.yeast});

  BeerIngredients.fromJson(Map<String, dynamic> json) {
    if (json['malt'] != null) {
      malt = <Malt>[];
      json['malt'].forEach((v) {
        malt!.add(new Malt.fromJson(v));
      });
    }
    if (json['hops'] != null) {
      hops = <Hops>[];
      json['hops'].forEach((v) {
        hops!.add(new Hops.fromJson(v));
      });
    }
    yeast = json['yeast'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.malt != null) {
      data['malt'] = this.malt!.map((v) => v.toJson()).toList();
    }
    if (this.hops != null) {
      data['hops'] = this.hops!.map((v) => v.toJson()).toList();
    }
    data['yeast'] = this.yeast;
    return data;
  }
}

class Malt {
  String? name;
  Amount? amount;

  Malt({this.name, this.amount});

  Malt.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    amount =
        json['amount'] != null ? new Amount.fromJson(json['amount']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.amount != null) {
      data['amount'] = this.amount!.toJson();
    }
    return data;
  }
}

class Hops {
  String? name;
  Amount? amount;
  String? add;
  String? attribute;

  Hops({this.name, this.amount, this.add, this.attribute});

  Hops.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    amount =
        json['amount'] != null ? new Amount.fromJson(json['amount']) : null;
    add = json['add'];
    attribute = json['attribute'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.amount != null) {
      data['amount'] = this.amount!.toJson();
    }
    data['add'] = this.add;
    data['attribute'] = this.attribute;
    return data;
  }
}
