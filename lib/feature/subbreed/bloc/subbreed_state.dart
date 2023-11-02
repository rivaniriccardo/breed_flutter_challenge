part of 'subbreed_bloc.dart';

@freezed
class SubBreedState with _$SubBreedState {
  const factory SubBreedState.loading() = _Loading;
  const factory SubBreedState.loaded({
    required String imageUrl,
  }) = _Loaded;
  const factory SubBreedState.error() = _Error;
}
