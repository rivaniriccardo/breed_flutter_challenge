// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:breed_flutter_challenge/core/di/register_module.dart' as _i13;
import 'package:breed_flutter_challenge/feature/breed/bloc/breed_bloc.dart'
    as _i10;
import 'package:breed_flutter_challenge/feature/breed/repo/breed_repo.dart'
    as _i7;
import 'package:breed_flutter_challenge/feature/breed_images/bloc/breed_images_bloc.dart'
    as _i11;
import 'package:breed_flutter_challenge/feature/breed_images/repo/breed_images_repo.dart'
    as _i6;
import 'package:breed_flutter_challenge/feature/breeds/bloc/breeds_bloc.dart'
    as _i12;
import 'package:breed_flutter_challenge/feature/breeds/repo/breeds_repo.dart'
    as _i8;
import 'package:breed_flutter_challenge/feature/subbreeds/bloc/subbreeds_bloc.dart'
    as _i9;
import 'package:breed_flutter_challenge/feature/subbreeds/repo/subbreeds_repo.dart'
    as _i5;
import 'package:breed_flutter_challenge/utils/utils.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.factory<_i3.Client>(() => registerModule.httpClient);
  gh.factory<_i4.RestClient>(() => registerModule.restClient);
  gh.factory<_i5.SubBreedsRepo>(
      () => _i5.SubBreedsRepo(restClient: gh<_i4.RestClient>()));
  gh.factory<_i6.BreedImagesRepo>(
      () => _i6.BreedImagesRepo(restClient: gh<_i4.RestClient>()));
  gh.factory<_i7.BreedRepo>(
      () => _i7.BreedRepo(restClient: gh<_i4.RestClient>()));
  gh.factory<_i8.BreedsRepo>(
      () => _i8.BreedsRepo(restClient: gh<_i4.RestClient>()));
  gh.factory<_i9.SubBreedsBloc>(
      () => _i9.SubBreedsBloc(breedsRepo: gh<_i5.SubBreedsRepo>()));
  gh.factory<_i10.BreedBloc>(
      () => _i10.BreedBloc(breedRepo: gh<_i7.BreedRepo>()));
  gh.factory<_i11.BreedImagesBloc>(
      () => _i11.BreedImagesBloc(breedImagesRepo: gh<_i6.BreedImagesRepo>()));
  gh.factory<_i12.BreedsBloc>(
      () => _i12.BreedsBloc(breedsRepo: gh<_i8.BreedsRepo>()));
  return getIt;
}

class _$RegisterModule extends _i13.RegisterModule {}
