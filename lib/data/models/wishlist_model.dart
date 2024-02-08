// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../data_exports.dart';

class WishListModel {
  int? id;
  int? user;
  Accommodation? accommodation;
  String? error;
  WishListModel({
    this.id,
    this.user,
    this.accommodation,
    this.error,
  });
  WishListModel.withError(String error) {
    this.error = error;
  }

  WishListModel copyWith({
    int? id,
    int? user,
    Accommodation? accommodation,
    String? error,
  }) {
    return WishListModel(
      id: id ?? this.id,
      user: user ?? this.user,
      accommodation: accommodation ?? this.accommodation,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': user,
      'accommodation': accommodation?.toMap(),
      'error': error,
    };
  }

  factory WishListModel.fromMap(Map<String, dynamic> map) {
    return WishListModel(
      id: map['id'] != null ? map['id'] as int : null,
      user: map['user'] != null ? map['user'] as int : null,
      accommodation: map['accommodation'] != null
          ? Accommodation.fromMap(map['accommodation'] as Map<String, dynamic>)
          : null,
      error: map['error'] != null ? map['error'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WishListModel.fromJson(String source) =>
      WishListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WishListModel(id: $id, user: $user, accommodation: $accommodation, error: $error)';
  }

  @override
  bool operator ==(covariant WishListModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.user == user &&
        other.accommodation == accommodation &&
        other.error == error;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user.hashCode ^
        accommodation.hashCode ^
        error.hashCode;
  }
}
