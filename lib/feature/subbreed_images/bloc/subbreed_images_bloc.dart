import 'package:bloc/bloc.dart';
import 'package:breed_flutter_challenge/feature/subbreed_images/repo/subbreed_images_repo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'subbreed_images_bloc.freezed.dart';
part 'subbreed_images_event.dart';
part 'subbreed_images_state.dart';

@injectable
class SubBreedImagesBloc
    extends Bloc<SubBreedImagesEvent, SubBreedImagesState> {
  SubBreedImagesBloc({
    required this.breedImagesRepo,
  }) : super(const SubBreedImagesState.loading()) {
    on<SubBreedImagesEvent>((event, emit) async {
      await event.map(
        fetch: (event) => _fetch(event, emit),
      );
    });
  }

  final SubBreedImagesRepo breedImagesRepo;

  Future _fetch(
    _Fetch event,
    Emitter<SubBreedImagesState> emit,
  ) async {
    emit(const SubBreedImagesState.loading());
    try {
      final imgs = await breedImagesRepo.getSubBreedImages(
        event.breedName,
        event.subBreedName,
      );
      emit(
        SubBreedImagesState.loaded(
          imgs: imgs,
        ),
      );
    } catch (e) {
      emit(const SubBreedImagesState.error());
    }
  }
}
