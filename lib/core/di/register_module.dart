import 'package:breed_flutter_challenge/utils/utils.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  Client get httpClient => Client();
  RestClient get restClient => RestClient(httpClient: httpClient);
}
