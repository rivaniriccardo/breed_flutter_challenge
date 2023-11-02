import 'package:bloc/bloc.dart';
import 'package:breed_flutter_challenge/feature/subbreed/repo/subbreed_repo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'subbreed_bloc.freezed.dart';
part 'subbreed_event.dart';
part 'subbreed_state.dart';

@injectable
class SubBreedBloc extends Bloc<SubBreedEvent, SubBreedState> {
  SubBreedBloc({
    required this.breedRepo,
  }) : super(const SubBreedState.loading()) {
    on<SubBreedEvent>((event, emit) async {
      await event.map(
        fetch: (event) => _fetch(event, emit),
        reFetch: (event) => _reFetch(event, emit),
      );
    });
  }

  final SubBreedRepo breedRepo;

  Future _fetch(
    _Fetch event,
    Emitter<SubBreedState> emit,
  ) async {
    emit(const SubBreedState.loading());
    try {
      final imageUrl = await breedRepo.getBreedRandomImage(
        event.breedName,
        event.subBreedName,
      );
      emit(
        SubBreedState.loaded(imageUrl: imageUrl),
      );
    } catch (e) {
      emit(const SubBreedState.error());
    }
  }

  Future _reFetch(
    _ReFetch event,
    Emitter<SubBreedState> emit,
  ) async {
    final currState = state;
    if (currState is _Loaded) {
      try {
        final imageUrl = await breedRepo.getBreedRandomImage(
          event.breedName,
          event.subBreedname,
        );
        emit(currState.copyWith(imageUrl: imageUrl));
      } catch (e) {
        emit(const SubBreedState.error());
      }
    }
  }
}
