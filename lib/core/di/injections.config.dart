// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:breed_flutter_challenge/core/di/register_module.dart' as _i7;
import 'package:breed_flutter_challenge/feature/breeds/bloc/breeds_bloc.dart'
    as _i6;
import 'package:breed_flutter_challenge/feature/breeds/repo/breeds_repo.dart'
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
  gh.factory<_i5.BreedsRepo>(
      () => _i5.BreedsRepo(restClient: gh<_i4.RestClient>()));
  gh.factory<_i6.BreedsBloc>(
      () => _i6.BreedsBloc(breedsRepo: gh<_i5.BreedsRepo>()));
  return getIt;
}

class _$RegisterModule extends _i7.RegisterModule {}