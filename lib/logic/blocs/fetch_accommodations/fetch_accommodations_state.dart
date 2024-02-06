part of 'fetch_accommodations_bloc.dart';

sealed class FetchAccommodationsState extends Equatable {
  const FetchAccommodationsState();
  @override
  List<Object> get props => [];
}

class FetchAccommodationsInitial extends FetchAccommodationsState {}

class FetchAccommodationLoading extends FetchAccommodationsState {}

class FetchAccommodationSuccess extends FetchAccommodationsState {
  final List<Accommodation> accommodation;
  FetchAccommodationSuccess({required this.accommodation});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'accommodation': accommodation};
  }

  factory FetchAccommodationSuccess.fromMap(Map<String, dynamic> map) {
    return FetchAccommodationSuccess(
        accommodation: List.from(map["accommodation"])
            .map((e) => Accommodation.fromMap(e))
            .toList());
  }
  List<Object> get props => [accommodation];
}

class FetchAccommodationError extends FetchAccommodationsState {
  final String message;
  FetchAccommodationError({required this.message});
}
