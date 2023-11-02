part of 'subbreeds_bloc.dart';

@freezed
class SubBreedsEvent with _$SubBreedsEvent {
  const factory SubBreedsEvent.fetch(String breedName) = _Fetch;
}
