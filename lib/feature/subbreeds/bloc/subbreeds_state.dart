part of 'subbreeds_bloc.dart';

@freezed
class SubBreedsState with _$SubBreedsState {
  const factory SubBreedsState.loading() = _Loading;
  const factory SubBreedsState.loaded({
    required List<Breed> breeds,
  }) = _Loaded;
  const factory SubBreedsState.error() = _Error;
}
