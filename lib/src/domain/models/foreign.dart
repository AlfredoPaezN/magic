class ForeignName {
  String? name;
  String? text;
  String? type;
  String? imageUrl;
  String? language;
  int? multiverseid;

  ForeignName({
    this.name,
    this.text,
    this.type,
    this.imageUrl,
    this.language,
    this.multiverseid,
  });

  factory ForeignName.fromJson(Map<String, dynamic> json) => ForeignName(
        name: json["name"],
        text: json["text"],
        type: json["type"],
        imageUrl: json["imageUrl"],
        language: json["language"],
        multiverseid: json["multiverseid"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "text": text,
        "type": type,
        "imageUrl": imageUrl,
        "language": language,
        "multiverseid": multiverseid,
      };
}
