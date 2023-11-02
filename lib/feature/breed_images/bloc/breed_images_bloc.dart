import 'package:bloc/bloc.dart';
import 'package:breed_flutter_challenge/feature/breed_images/repo/breed_images_repo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'breed_images_bloc.freezed.dart';
part 'breed_images_event.dart';
part 'breed_images_state.dart';

@injectable
class BreedImagesBloc extends Bloc<BreedImagesEvent, BreedImagesState> {
  BreedImagesBloc({
    required this.breedImagesRepo,
  }) : super(const BreedImagesState.loading()) {
    on<BreedImagesEvent>((event, emit) async {
      await event.map(
        fetch: (event) => _fetch(event, emit),
      );
    });
  }

  final BreedImagesRepo breedImagesRepo;

  Future _fetch(
    _Fetch event,
    Emitter<BreedImagesState> emit,
  ) async {
    emit(const BreedImagesState.loading());
    try {
      final imgs = await breedImagesRepo.getBreedImages(event.breedName);
      emit(
        BreedImagesState.loaded(
          imgs: imgs,
        ),
      );
    } catch (e) {
      emit(const BreedImagesState.error());
    }
  }
}
