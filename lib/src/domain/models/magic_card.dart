// To parse this JSON data, do
//
//     final card = cardFromJson(jsonString);

import 'dart:convert';

import 'package:magic/src/domain/models/foreign.dart';

MagicCard cardFromJson(String str) => MagicCard.fromJson(json.decode(str));

String cardToJson(MagicCard data) => json.encode(data.toJson());

class MagicCard {
  String? name;
  List<String>? types;
  List<String>? subtypes;
  String? setName;
  String? text;
  String? power;
  String? toughness;
  String? imageUrl;
  List<ForeignName>? foreignNames;
  String? id;

  MagicCard({
    this.name,
    this.types,
    this.subtypes,
    this.setName,
    this.text,
    this.power,
    this.toughness,
    this.imageUrl,
    this.foreignNames,
    this.id,
  });

  factory MagicCard.fromJson(Map<String, dynamic> json) => MagicCard(
        name: json["name"],
        types: json["types"] == null
            ? []
            : List<String>.from(json["types"]!.map((x) => x)),
        subtypes: json["subtypes"] == null
            ? []
            : List<String>.from(json["subtypes"]!.map((x) => x)),
        setName: json["setName"],
        text: json["text"],
        power: json["power"],
        toughness: json["toughness"],
        imageUrl: json["imageUrl"],
        foreignNames: json["foreignNames"] == null
            ? []
            : List<ForeignName>.from(
                json["foreignNames"]!.map((x) => ForeignName.fromJson(x))),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "types": types == null ? [] : List<dynamic>.from(types!.map((x) => x)),
        "subtypes":
            subtypes == null ? [] : List<dynamic>.from(subtypes!.map((x) => x)),
        "setName": setName,
        "text": text,
        "power": power,
        "toughness": toughness,
        "imageUrl": imageUrl,
        "foreignNames": foreignNames == null
            ? []
            : List<dynamic>.from(foreignNames!.map((x) => x.toJson())),
        "id": id,
      };
}
