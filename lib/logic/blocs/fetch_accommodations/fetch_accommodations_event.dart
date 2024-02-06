part of 'fetch_accommodations_bloc.dart';

sealed class FetchAccommodationsEvent extends Equatable {
  const FetchAccommodationsEvent();

  @override
  List<Object> get props => [];
}

class HitFetchAccommodationsEvent extends FetchAccommodationsEvent {
  HitFetchAccommodationsEvent();
}
