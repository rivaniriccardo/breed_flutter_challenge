part of 'breed_images_bloc.dart';

@freezed
class BreedImagesState with _$BreedImagesState {
  const factory BreedImagesState.loading() = _Loading;
  const factory BreedImagesState.loaded({
    required List<String> imgs,
  }) = _Loaded;
  const factory BreedImagesState.error() = _Error;
}
