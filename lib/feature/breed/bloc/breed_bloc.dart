import 'package:bloc/bloc.dart';
import 'package:breed_flutter_challenge/feature/breed/repo/breed_repo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'breed_bloc.freezed.dart';
part 'breed_event.dart';
part 'breed_state.dart';

@injectable
class BreedBloc extends Bloc<BreedEvent, BreedState> {
  BreedBloc({
    required this.breedRepo,
  }) : super(const BreedState.loading()) {
    on<BreedEvent>((event, emit) async {
      await event.map(
        fetch: (event) => _fetch(event, emit),
      );
    });
  }

  final BreedRepo breedRepo;

  Future _fetch(
    _Fetch event,
    Emitter<BreedState> emit,
  ) async {
    emit(const BreedState.loading());
    try {
      final imageUrl = await breedRepo.getBreedRandomImage(event.breedName);
      emit(
        BreedState.loaded(imageUrl: imageUrl),
      );
    } catch (e) {
      emit(const BreedState.error());
    }
  }
}
