part of 'breed_images_bloc.dart';

@freezed
class BreedImagesEvent with _$BreedImagesEvent {
  const factory BreedImagesEvent.fetch(String breedName) = _Fetch;
}
