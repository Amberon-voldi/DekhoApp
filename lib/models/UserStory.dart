/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'package:amplify_core/amplify_core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the UserStory type in your schema. */
@immutable
class UserStory {
  final bool? _privacyType;
  final List<String>? _visibleto;
  final List<String>? _contentUrl;
  final String? _userID;
  final String? _music;
  final List<String>? _likes;
  final TemporalDateTime? _time;

  bool? get privacyType {
    return _privacyType;
  }
  
  List<String>? get visibleto {
    return _visibleto;
  }
  
  List<String> get contentUrl {
    try {
      return _contentUrl!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get userID {
    return _userID;
  }
  
  String? get music {
    return _music;
  }
  
  List<String>? get likes {
    return _likes;
  }
  
  TemporalDateTime? get time {
    return _time;
  }
  
  const UserStory._internal({privacyType, visibleto, required contentUrl, userID, music, likes, time}): _privacyType = privacyType, _visibleto = visibleto, _contentUrl = contentUrl, _userID = userID, _music = music, _likes = likes, _time = time;
  
  factory UserStory({bool? privacyType, List<String>? visibleto, required List<String> contentUrl, String? userID, String? music, List<String>? likes, TemporalDateTime? time}) {
    return UserStory._internal(
      privacyType: privacyType,
      visibleto: visibleto != null ? List<String>.unmodifiable(visibleto) : visibleto,
      contentUrl: contentUrl != null ? List<String>.unmodifiable(contentUrl) : contentUrl,
      userID: userID,
      music: music,
      likes: likes != null ? List<String>.unmodifiable(likes) : likes,
      time: time);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserStory &&
      _privacyType == other._privacyType &&
      DeepCollectionEquality().equals(_visibleto, other._visibleto) &&
      DeepCollectionEquality().equals(_contentUrl, other._contentUrl) &&
      _userID == other._userID &&
      _music == other._music &&
      DeepCollectionEquality().equals(_likes, other._likes) &&
      _time == other._time;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("UserStory {");
    buffer.write("privacyType=" + (_privacyType != null ? _privacyType!.toString() : "null") + ", ");
    buffer.write("visibleto=" + (_visibleto != null ? _visibleto!.toString() : "null") + ", ");
    buffer.write("contentUrl=" + (_contentUrl != null ? _contentUrl!.toString() : "null") + ", ");
    buffer.write("userID=" + "$_userID" + ", ");
    buffer.write("music=" + "$_music" + ", ");
    buffer.write("likes=" + (_likes != null ? _likes!.toString() : "null") + ", ");
    buffer.write("time=" + (_time != null ? _time!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  UserStory copyWith({bool? privacyType, List<String>? visibleto, List<String>? contentUrl, String? userID, String? music, List<String>? likes, TemporalDateTime? time}) {
    return UserStory._internal(
      privacyType: privacyType ?? this.privacyType,
      visibleto: visibleto ?? this.visibleto,
      contentUrl: contentUrl ?? this.contentUrl,
      userID: userID ?? this.userID,
      music: music ?? this.music,
      likes: likes ?? this.likes,
      time: time ?? this.time);
  }
  
  UserStory.fromJson(Map<String, dynamic> json)  
    : _privacyType = json['privacyType'],
      _visibleto = json['visibleto']?.cast<String>(),
      _contentUrl = json['contentUrl']?.cast<String>(),
      _userID = json['userID'],
      _music = json['music'],
      _likes = json['likes']?.cast<String>(),
      _time = json['time'] != null ? TemporalDateTime.fromString(json['time']) : null;
  
  Map<String, dynamic> toJson() => {
    'privacyType': _privacyType, 'visibleto': _visibleto, 'contentUrl': _contentUrl, 'userID': _userID, 'music': _music, 'likes': _likes, 'time': _time?.format()
  };
  
  Map<String, Object?> toMap() => {
    'privacyType': _privacyType, 'visibleto': _visibleto, 'contentUrl': _contentUrl, 'userID': _userID, 'music': _music, 'likes': _likes, 'time': _time
  };

  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UserStory";
    modelSchemaDefinition.pluralName = "UserStories";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'privacyType',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'visibleto',
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'contentUrl',
      isRequired: true,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'userID',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'music',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'likes',
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'time',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}