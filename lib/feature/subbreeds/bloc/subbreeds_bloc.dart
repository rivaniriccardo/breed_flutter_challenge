import 'package:bloc/bloc.dart';
import 'package:breed_flutter_challenge/feature/subbreeds/repo/subbreeds_repo.dart';
import 'package:breed_flutter_challenge/model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'subbreeds_bloc.freezed.dart';
part 'subbreeds_event.dart';
part 'subbreeds_state.dart';

@injectable
class SubBreedsBloc extends Bloc<SubBreedsEvent, SubBreedsState> {
  SubBreedsBloc({
    required this.breedsRepo,
  }) : super(const _Loading()) {
    on<SubBreedsEvent>((event, emit) async {
      await event.map(
        fetch: (event) => _fetch(event, emit),
      );
    });
  }

  final SubBreedsRepo breedsRepo;

  Future _fetch(
    _Fetch event,
    Emitter<SubBreedsState> emit,
  ) async {
    emit(const _Loading());
    try {
      final breeds = await breedsRepo.getSubBreeds(event.breedName);

      emit(
        _Loaded(
          breeds: breeds,
        ),
      );
    } catch (e) {
      emit(const _Error());
    }
  }
}
