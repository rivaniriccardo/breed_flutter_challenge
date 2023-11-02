part of 'subbreed_images_bloc.dart';

@freezed
class SubBreedImagesEvent with _$SubBreedImagesEvent {
  const factory SubBreedImagesEvent.fetch(
    String breedName,
    String subBreedName,
  ) = _Fetch;
}
