// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breeds.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BreedsImpl _$$BreedsImplFromJson(Map<String, dynamic> json) => _$BreedsImpl(
      message: (json['message'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
      status: json['status'] as String,
    );

Map<String, dynamic> _$$BreedsImplToJson(_$BreedsImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
    };
