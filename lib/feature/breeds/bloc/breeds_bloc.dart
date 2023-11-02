import 'package:bloc/bloc.dart';
import 'package:breed_flutter_challenge/feature/breeds/repo/breeds_repo.dart';
import 'package:breed_flutter_challenge/model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'breeds_bloc.freezed.dart';
part 'breeds_event.dart';
part 'breeds_state.dart';

@injectable
class BreedsBloc extends Bloc<BreedsEvent, BreedsState> {
  BreedsBloc({
    required this.breedsRepo,
  }) : super(const _Loading()) {
    on<BreedsEvent>((event, emit) async {
      await event.map(
        fetch: (event) => _fetch(event, emit),
        fetchRandomImage: (event) => _fetchRandomImage(event, emit),
      );
    });
  }

  final BreedsRepo breedsRepo;

  Future _fetch(
    _Fetch event,
    Emitter<BreedsState> emit,
  ) async {
    emit(const _Loading());
    try {
      final breeds = await breedsRepo.getBreeds();

      final imageUrl = await breedsRepo.getBreedsRandomImage();

      emit(
        _Loaded(
          breeds: breeds,
          imageUrl: imageUrl,
        ),
      );
    } catch (e) {
      emit(const _Error());
    }
  }

  Future _fetchRandomImage(
    _FetchRandomImage event,
    Emitter<BreedsState> emit,
  ) async {
    final currState = state;
    if (currState is _Loaded) {
      try {
        final imageUrl = await breedsRepo.getBreedsRandomImage();
        emit(currState.copyWith(imageUrl: imageUrl));
      } catch (e) {
        emit(const _Error());
      }
    }
  }
}
