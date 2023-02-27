import 'dart:convert';

import 'package:crio_meme_sharing_app/repository/models/meme.dart';


class User {
  final String? name;
  final String email;
  final List<Memes> usermemes;
  User({
    this.name,
    required this.email,
    required this.usermemes,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'usermemes': usermemes.map((x) => x.toMap()).toList(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      email: map['email'],
      usermemes:
          List<Memes>.from(map['usermemes'].map((x) => Memes.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
