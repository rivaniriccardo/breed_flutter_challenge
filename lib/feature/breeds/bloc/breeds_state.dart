part of 'breeds_bloc.dart';

@freezed
class BreedsState with _$BreedsState {
  const factory BreedsState.loading() = _Loading;
  const factory BreedsState.loaded({
    required Breeds breeds,
  }) = _Loaded;
  const factory BreedsState.error() = _Error;
}
