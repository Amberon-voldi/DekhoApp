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


/** This is an auto generated class representing the CommentModel type in your schema. */
@immutable
class CommentModel {
  final String? _comment;
  final List<String>? _likes;
  final bool? _isReply;
  final String? _replyTo;
  final String? _username;
  final String? _pfp;
  final bool? _isEdited;
  final TemporalDateTime? _time;
  final String? _userID;

  String? get comment {
    return _comment;
  }
  
  List<String>? get likes {
    return _likes;
  }
  
  bool? get isReply {
    return _isReply;
  }
  
  String? get replyTo {
    return _replyTo;
  }
  
  String? get username {
    return _username;
  }
  
  String? get pfp {
    return _pfp;
  }
  
  bool? get isEdited {
    return _isEdited;
  }
  
  TemporalDateTime? get time {
    return _time;
  }
  
  String? get userID {
    return _userID;
  }
  
  const CommentModel._internal({comment, likes, isReply, replyTo, username, pfp, isEdited, time, userID}): _comment = comment, _likes = likes, _isReply = isReply, _replyTo = replyTo, _username = username, _pfp = pfp, _isEdited = isEdited, _time = time, _userID = userID;
  
  factory CommentModel({String? comment, List<String>? likes, bool? isReply, String? replyTo, String? username, String? pfp, bool? isEdited, TemporalDateTime? time, String? userID}) {
    return CommentModel._internal(
      comment: comment,
      likes: likes != null ? List<String>.unmodifiable(likes) : likes,
      isReply: isReply,
      replyTo: replyTo,
      username: username,
      pfp: pfp,
      isEdited: isEdited,
      time: time,
      userID: userID);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CommentModel &&
      _comment == other._comment &&
      DeepCollectionEquality().equals(_likes, other._likes) &&
      _isReply == other._isReply &&
      _replyTo == other._replyTo &&
      _username == other._username &&
      _pfp == other._pfp &&
      _isEdited == other._isEdited &&
      _time == other._time &&
      _userID == other._userID;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("CommentModel {");
    buffer.write("comment=" + "$_comment" + ", ");
    buffer.write("likes=" + (_likes != null ? _likes!.toString() : "null") + ", ");
    buffer.write("isReply=" + (_isReply != null ? _isReply!.toString() : "null") + ", ");
    buffer.write("replyTo=" + "$_replyTo" + ", ");
    buffer.write("username=" + "$_username" + ", ");
    buffer.write("pfp=" + "$_pfp" + ", ");
    buffer.write("isEdited=" + (_isEdited != null ? _isEdited!.toString() : "null") + ", ");
    buffer.write("time=" + (_time != null ? _time!.format() : "null") + ", ");
    buffer.write("userID=" + "$_userID");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  CommentModel copyWith({String? comment, List<String>? likes, bool? isReply, String? replyTo, String? username, String? pfp, bool? isEdited, TemporalDateTime? time, String? userID}) {
    return CommentModel._internal(
      comment: comment ?? this.comment,
      likes: likes ?? this.likes,
      isReply: isReply ?? this.isReply,
      replyTo: replyTo ?? this.replyTo,
      username: username ?? this.username,
      pfp: pfp ?? this.pfp,
      isEdited: isEdited ?? this.isEdited,
      time: time ?? this.time,
      userID: userID ?? this.userID);
  }
  
  CommentModel.fromJson(Map<String, dynamic> json)  
    : _comment = json['comment'],
      _likes = json['likes']?.cast<String>(),
      _isReply = json['isReply'],
      _replyTo = json['replyTo'],
      _username = json['username'],
      _pfp = json['pfp'],
      _isEdited = json['isEdited'],
      _time = json['time'] != null ? TemporalDateTime.fromString(json['time']) : null,
      _userID = json['userID'];
  
  Map<String, dynamic> toJson() => {
    'comment': _comment, 'likes': _likes, 'isReply': _isReply, 'replyTo': _replyTo, 'username': _username, 'pfp': _pfp, 'isEdited': _isEdited, 'time': _time?.format(), 'userID': _userID
  };
  
  Map<String, Object?> toMap() => {
    'comment': _comment, 'likes': _likes, 'isReply': _isReply, 'replyTo': _replyTo, 'username': _username, 'pfp': _pfp, 'isEdited': _isEdited, 'time': _time, 'userID': _userID
  };

  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "CommentModel";
    modelSchemaDefinition.pluralName = "CommentModels";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'comment',
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
      fieldName: 'isReply',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'replyTo',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'username',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'pfp',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'isEdited',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'time',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'userID',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}