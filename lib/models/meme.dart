import 'dart:convert';

class Memes {
  final String url;
  final String name;
  final String description;
  final int id;

  Memes({
    this.id,
    this.url,
    this.name,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'caption': description,
    };
  }

  factory Memes.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Memes(
      id: map['id'],
      url: map['url'],
      name: map['name'],
      description: map['caption'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Memes.fromJson(String source) => Memes.fromMap(json.decode(source));
}
