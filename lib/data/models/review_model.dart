// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:stayfinder_customer/data/data_exports.dart';

class ReviewModel {
  String? title;
  String? description;
  String? image;
  Accommodation? accommodation;
  UserModel? userModel;
  bool? is_deleted;
  String? added_time;
  String? error;
  ReviewModel({
    this.title,
    this.description,
    this.image,
    this.accommodation,
    this.userModel,
    this.is_deleted,
    this.added_time,
    this.error,
  });

  ReviewModel.withError(String error) {
    this.error = error;
  }

  ReviewModel copyWith({
    String? title,
    String? description,
    String? image,
    Accommodation? accommodation,
    UserModel? userModel,
    bool? is_deleted,
    String? added_time,
    String? error,
  }) {
    return ReviewModel(
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      accommodation: accommodation ?? this.accommodation,
      userModel: userModel ?? this.userModel,
      is_deleted: is_deleted ?? this.is_deleted,
      added_time: added_time ?? this.added_time,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'image': image,
      'accommodation': accommodation?.toMap(),
      'userModel': userModel?.toMap(),
      'is_deleted': is_deleted,
      'added_time': added_time,
      'error': error,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      accommodation: map['accommodation'] != null
          ? Accommodation.fromMap(map['accommodation'] as Map<String, dynamic>)
          : null,
      userModel: map['userModel'] != null
          ? UserModel.fromMap(map['userModel'] as Map<String, dynamic>)
          : null,
      is_deleted: map['is_deleted'] != null ? map['is_deleted'] as bool : null,
      added_time:
          map['added_time'] != null ? map['added_time'] as String : null,
      error: map['error'] != null ? map['error'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(String source) =>
      ReviewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReviewModel(title: $title, description: $description, image: $image, accommodation: $accommodation, userModel: $userModel, is_deleted: $is_deleted, added_time: $added_time, error: $error)';
  }

  @override
  bool operator ==(covariant ReviewModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.description == description &&
        other.image == image &&
        other.accommodation == accommodation &&
        other.userModel == userModel &&
        other.is_deleted == is_deleted &&
        other.added_time == added_time &&
        other.error == error;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        image.hashCode ^
        accommodation.hashCode ^
        userModel.hashCode ^
        is_deleted.hashCode ^
        added_time.hashCode ^
        error.hashCode;
  }
}
