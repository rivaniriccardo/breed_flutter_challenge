part of 'breeds_bloc.dart';

@freezed
class BreedsEvent with _$BreedsEvent {
  const factory BreedsEvent.fetch() = _Fetch;
  const factory BreedsEvent.fetchRandomImage() = _FetchRandomImage;
}
