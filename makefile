build_runner:
	@flutter pub run build_runner build --delete-conflicting-outputs

test-unit:
	@flutter test

test-integration:
	@flutter test integration_test

test-coverage:
	@flutter test --coverage && lcov --remove coverage/lcov.info '**/*.freezed.dart' '**/*.g.dart' '**/*.part.dart' '**/*.config.dart' '**/*_event.dart' '**/*_state.dart' '**/core/*' --ignore-errors unused -o coverage/lcov.info && genhtml coverage/lcov.info --output=coverage && open coverage/index.html

test-golden:
	@flutter test --update-goldens

clean:
	@rm -rf pubspec.lock
	@flutter clean