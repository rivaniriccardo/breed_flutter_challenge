part of 'breed_bloc.dart';

@freezed
class BreedEvent with _$BreedEvent {
  const factory BreedEvent.fetch(String breedName) = _Fetch;
  const factory BreedEvent.reFetch(String breedName) = _ReFetch;
}
