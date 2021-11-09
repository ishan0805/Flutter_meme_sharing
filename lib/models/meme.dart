import 'dart:convert';

class Memes {
  final String? url;

  final String? caption;
  final int? id;
  final String? ownerEmail;
  final String? ownerName;

  Memes({
    this.id,
    this.url,
    this.caption,
    this.ownerEmail,
    this.ownerName,
  });

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'caption': caption,
    };
  }

  factory Memes.fromMap(Map<String, dynamic> map) {
    return Memes(
        id: map['id'],
        url: map['url'],
        caption: map['caption'],
        ownerEmail: map['owner']['email'],
        ownerName: map['owner']['name']);
  }

  String toJson() => json.encode(toMap());

  factory Memes.fromJson(String source) => Memes.fromMap(json.decode(source));
}
