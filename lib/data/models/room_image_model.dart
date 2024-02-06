// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RoomImage {
  int id;
  String images;
  int room;
  RoomImage({
    required this.id,
    required this.images,
    required this.room,
  });

  RoomImage copyWith({
    int? id,
    String? images,
    int? room,
  }) {
    return RoomImage(
      id: id ?? this.id,
      images: images ?? this.images,
      room: room ?? this.room,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'images': images,
      'room': room,
    };
  }

  factory RoomImage.fromMap(Map<String, dynamic> map) {
    return RoomImage(
      id: map['id'] as int,
      images: map['images'] as String,
      room: map['room'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomImage.fromJson(String source) =>
      RoomImage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RoomImage(id: $id, images: $images, room: $room)';

  @override
  bool operator ==(covariant RoomImage other) {
    if (identical(this, other)) return true;

    return other.id == id && other.images == images && other.room == room;
  }

  @override
  int get hashCode => id.hashCode ^ images.hashCode ^ room.hashCode;
}
