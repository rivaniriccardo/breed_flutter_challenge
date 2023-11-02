part of 'breed_bloc.dart';

@freezed
class BreedState with _$BreedState {
  const factory BreedState.loading() = _Loading;
  const factory BreedState.loaded({
    required String imageUrl,
  }) = _Loaded;
  const factory BreedState.error() = _Error;
}
