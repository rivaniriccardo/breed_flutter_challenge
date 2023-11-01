part of 'breed_bloc.dart';

@freezed
class BreedEvent with _$BreedEvent {
  const factory BreedEvent.fetch(Breed breed) = _Fetch;
}
