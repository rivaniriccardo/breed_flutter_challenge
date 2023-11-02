part of 'breeds_bloc.dart';

@freezed
class BreedsState with _$BreedsState {
  const factory BreedsState.loading() = _Loading;
  const factory BreedsState.loaded({
    required List<Breed> breeds,
    required String imageUrl,
  }) = _Loaded;
  const factory BreedsState.error() = _Error;
}
