// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'breed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Breed _$BreedFromJson(Map<String, dynamic> json) {
  return _Breed.fromJson(json);
}

/// @nodoc
mixin _$Breed {
  String get breed => throw _privateConstructorUsedError;
  List<String> get subBreeds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BreedCopyWith<Breed> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BreedCopyWith<$Res> {
  factory $BreedCopyWith(Breed value, $Res Function(Breed) then) =
      _$BreedCopyWithImpl<$Res, Breed>;
  @useResult
  $Res call({String breed, List<String> subBreeds});
}

/// @nodoc
class _$BreedCopyWithImpl<$Res, $Val extends Breed>
    implements $BreedCopyWith<$Res> {
  _$BreedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? breed = null,
    Object? subBreeds = null,
  }) {
    return _then(_value.copyWith(
      breed: null == breed
          ? _value.breed
          : breed // ignore: cast_nullable_to_non_nullable
              as String,
      subBreeds: null == subBreeds
          ? _value.subBreeds
          : subBreeds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BreedImplCopyWith<$Res> implements $BreedCopyWith<$Res> {
  factory _$$BreedImplCopyWith(
          _$BreedImpl value, $Res Function(_$BreedImpl) then) =
      __$$BreedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String breed, List<String> subBreeds});
}

/// @nodoc
class __$$BreedImplCopyWithImpl<$Res>
    extends _$BreedCopyWithImpl<$Res, _$BreedImpl>
    implements _$$BreedImplCopyWith<$Res> {
  __$$BreedImplCopyWithImpl(
      _$BreedImpl _value, $Res Function(_$BreedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? breed = null,
    Object? subBreeds = null,
  }) {
    return _then(_$BreedImpl(
      breed: null == breed
          ? _value.breed
          : breed // ignore: cast_nullable_to_non_nullable
              as String,
      subBreeds: null == subBreeds
          ? _value._subBreeds
          : subBreeds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BreedImpl implements _Breed {
  const _$BreedImpl(
      {required this.breed, required final List<String> subBreeds})
      : _subBreeds = subBreeds;

  factory _$BreedImpl.fromJson(Map<String, dynamic> json) =>
      _$$BreedImplFromJson(json);

  @override
  final String breed;
  final List<String> _subBreeds;
  @override
  List<String> get subBreeds {
    if (_subBreeds is EqualUnmodifiableListView) return _subBreeds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subBreeds);
  }

  @override
  String toString() {
    return 'Breed(breed: $breed, subBreeds: $subBreeds)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BreedImpl &&
            (identical(other.breed, breed) || other.breed == breed) &&
            const DeepCollectionEquality()
                .equals(other._subBreeds, _subBreeds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, breed, const DeepCollectionEquality().hash(_subBreeds));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BreedImplCopyWith<_$BreedImpl> get copyWith =>
      __$$BreedImplCopyWithImpl<_$BreedImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BreedImplToJson(
      this,
    );
  }
}

abstract class _Breed implements Breed {
  const factory _Breed(
      {required final String breed,
      required final List<String> subBreeds}) = _$BreedImpl;

  factory _Breed.fromJson(Map<String, dynamic> json) = _$BreedImpl.fromJson;

  @override
  String get breed;
  @override
  List<String> get subBreeds;
  @override
  @JsonKey(ignore: true)
  _$$BreedImplCopyWith<_$BreedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
