part of 'subbreed_images_bloc.dart';

@freezed
class SubBreedImagesState with _$SubBreedImagesState {
  const factory SubBreedImagesState.loading() = _Loading;
  const factory SubBreedImagesState.loaded({
    required List<String> imgs,
  }) = _Loaded;
  const factory SubBreedImagesState.error() = _Error;
}
