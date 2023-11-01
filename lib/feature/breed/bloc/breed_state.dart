part of 'breed_bloc.dart';

@freezed
class BreedState with _$BreedState {
  const factory BreedState.loading() = _Loading;
  const factory BreedState.loaded({
    required List<String> imgs,
  }) = _Loaded;
  const factory BreedState.error() = _Error;
}
