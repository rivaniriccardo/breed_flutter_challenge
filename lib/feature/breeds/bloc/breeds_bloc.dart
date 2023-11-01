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
  }) : super(const BreedsState.loading()) {
    on<BreedsEvent>((event, emit) async {
      await event.map(
        fetch: (event) => _fetch(event, emit),
      );
    });
  }

  final BreedsRepo breedsRepo;

  Future _fetch(
    _Fetch event,
    Emitter<BreedsState> emit,
  ) async {
    emit(const BreedsState.loading());
    try {
      final breeds = await breedsRepo.getBreeds();
      emit(
        BreedsState.loaded(
          breeds: breeds,
        ),
      );
    } catch (e) {
      emit(const BreedsState.error());
    }
  }
}
