import '../data_exports.dart';

class HotelTier {
  int? id;
  String? tier_name;
  String? description;
  String? image;
  int? accommodation;
  List<Room?>? rooms;
  HotelTier({
    this.id,
    this.tier_name,
    this.description,
    this.image,
    this.accommodation,
    this.rooms,
  });

  HotelTier copyWith({
    int? id,
    String? tier_name,
    String? description,
    String? image,
    int? accommodation,
    List<Room?>? rooms,
  }) {
    return HotelTier(
      id: id ?? this.id,
      tier_name: tier_name ?? this.tier_name,
      description: description ?? this.description,
      image: image ?? this.image,
      accommodation: accommodation ?? this.accommodation,
      rooms: rooms ?? this.rooms,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tier_name': tier_name,
      'description': description,
      'image': image,
      'accommodation': accommodation,
      'rooms': rooms?.map((x) => x?.toMap()).toList(),
    };
  }

  factory HotelTier.fromMap(Map<String, dynamic> map) {
    return HotelTier(
      id: map['id'] != null ? map['id'] as int : null,
      tier_name: map['tier_name'] != null ? map['tier_name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      accommodation:
          map['accommodation'] != null ? map['accommodation'] as int : null,
      rooms: map['rooms'] != null
          ? List<Room?>.from(
              (map['rooms'] as List<dynamic>).map<Room>(
                (x) => Room?.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelTier.fromJson(String source) =>
      HotelTier.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HotelTier(id: $id, tier_name: $tier_name, description: $description, image: $image, accommodation: $accommodation, rooms: $rooms)';
  }

  @override
  bool operator ==(covariant HotelTier other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.tier_name == tier_name &&
        other.description == description &&
        other.image == image &&
        other.accommodation == accommodation &&
        listEquals(other.rooms, rooms);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        tier_name.hashCode ^
        description.hashCode ^
        image.hashCode ^
        accommodation.hashCode ^
        rooms.hashCode;
  }
}
