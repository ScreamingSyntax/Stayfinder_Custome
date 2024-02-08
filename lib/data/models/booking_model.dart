import '../data_exports.dart';

class BookModel {
  int? id;
  RoomAccommodation? room;
  UserModel? user;
  String? check_in;
  String? check_out;
  String? booked_on;
  String? paid_amount;
  BookModel({
    this.id,
    this.room,
    this.user,
    this.check_in,
    this.check_out,
    this.booked_on,
    this.paid_amount,
  });

  BookModel copyWith({
    int? id,
    RoomAccommodation? room,
    UserModel? user,
    String? check_in,
    String? check_out,
    String? booked_on,
    String? paid_amount,
  }) {
    return BookModel(
      id: id ?? this.id,
      room: room ?? this.room,
      user: user ?? this.user,
      check_in: check_in ?? this.check_in,
      check_out: check_out ?? this.check_out,
      booked_on: booked_on ?? this.booked_on,
      paid_amount: paid_amount ?? this.paid_amount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'room': room?.toMap(),
      'user': user?.toMap(),
      'check_in': check_in,
      'check_out': check_out,
      'booked_on': booked_on,
      'paid_amount': paid_amount,
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      id: map['id'] != null ? map['id'] as int : null,
      room: map['room'] != null
          ? RoomAccommodation.fromMap(map['room'] as Map<String, dynamic>)
          : null,
      user: map['user'] != null
          ? UserModel.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      check_in: map['check_in'] != null ? map['check_in'] as String : null,
      check_out: map['check_out'] != null ? map['check_out'] as String : null,
      booked_on: map['booked_on'] != null ? map['booked_on'] as String : null,
      paid_amount:
          map['paid_amount'] != null ? map['paid_amount'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookModel.fromJson(String source) =>
      BookModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Booked(id: $id, room: $room, user: $user, check_in: $check_in, check_out: $check_out, booked_on: $booked_on, paid_amount: $paid_amount)';
  }

  @override
  bool operator ==(covariant BookModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.room == room &&
        other.user == user &&
        other.check_in == check_in &&
        other.check_out == check_out &&
        other.booked_on == booked_on &&
        other.paid_amount == paid_amount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        room.hashCode ^
        user.hashCode ^
        check_in.hashCode ^
        check_out.hashCode ^
        booked_on.hashCode ^
        paid_amount.hashCode;
  }
}
