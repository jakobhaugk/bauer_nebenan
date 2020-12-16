import 'package:bauer_nebenan/models/category.dart';

import "eco_score.dart";
import "farmer.dart";

class Product {
  String id;
  String title;
  String description;
  List<AdditionalInfo> additionalInformation;
  Category category;
  List<String> tags;
  String baseUnit;
  double baseUnitRelation;
  int quantityAvailable;
  int quantitySelected;
  double price;
  EcoScore ecoScore;
  List<String> images;
  Farmer farmer;

  Product(
      {this.id,
      this.title,
      this.description,
      this.additionalInformation,
      this.category,
      this.tags,
      this.baseUnit,
      this.baseUnitRelation,
      this.quantityAvailable,
      this.price,
      this.ecoScore,
      this.images,
      this.farmer,
      this.quantitySelected = 0});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      additionalInformation: json['additionalInformation']?.map((Map json) => AdditionalInfo.fromJSON(json))?.toList(),
      category: json['categoryID'] != null
          ? new Category(id: json['categoryID'], name: json['categoryName'])
          : null,
      tags: json['tags'].cast<String>(),
      baseUnit: json['baseUnit'],
      baseUnitRelation: json['baseUnitRelation'],
      quantityAvailable: json['quantityAvailable'],
      price: json['price'],
      ecoScore: json['ecoScore'] != null
          ? new EcoScore.fromJson(json['ecoScore'])
          : null,
      images: json['images'].cast<String>(),
      farmer:
          json['farmer'] != null ? new Farmer.fromJson(json['farmer']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['categoryID'] = this.category?.id;
    data['categoryName'] = this.category?.name;
    data['tags'] = this.tags;
    data['unit'] = this.unit;
    data['quantityAvailable'] = this.quantityAvailable;
    data['price'] = this.price;
    if (this.ecoScore != null) {
      data['ecoScore'] = this.ecoScore.toJson();
    }
    data['images'] = this.images;
    if (this.farmer != null) {
      data['farmer'] = this.farmer.toJson();
    }
    return data;
  }

  _f(num n) => n.toStringAsFixed(2).replaceFirst('.', ',');

  num get total => quantitySelected * price;

  String get displayPrice => '${_f(this.price)} €';

  String get priceAndQuantity =>
      '${this.quantitySelected} x ${_f(this.price)} €';

  String get unit => baseUnit.split(' ').last;

  double get _weight =>
      double.parse(this.baseUnit.split(' ').first) * baseUnitRelation;

  String get weight => '${_f(_weight)} $unit';

  String get groundprice => '${_f(price / baseUnitRelation)} € / $unit';
}

class AdditionalInfo {
  final String title, text, image;

  AdditionalInfo({this.title, this.text, this.image});

  factory AdditionalInfo.fromJSON(json) => AdditionalInfo(
    image: json['iamge'] ?? null,
    text: json['text'] ?? null,
    title: json['title'] ?? null,
  );
}
