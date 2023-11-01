// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BreedImpl _$$BreedImplFromJson(Map<String, dynamic> json) => _$BreedImpl(
      breed: json['breed'] as String,
      subBreeds:
          (json['subBreeds'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$BreedImplToJson(_$BreedImpl instance) =>
    <String, dynamic>{
      'breed': instance.breed,
      'subBreeds': instance.subBreeds,
    };
