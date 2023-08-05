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

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the MessageModel type in your schema. */
@immutable
class MessageModel {
  final String id;
  final bool? _isEdited;
  final TemporalDateTime? _time;
  final List<String>? _reactions;
  final String? _message;
  final bool? _isReply;
  final String? _replyTo;
  final MessageStatus? _messageStatus;
  final String? _userID;

  bool? get isEdited {
    return _isEdited;
  }
  
  TemporalDateTime? get time {
    return _time;
  }
  
  List<String>? get reactions {
    return _reactions;
  }
  
  String? get message {
    return _message;
  }
  
  bool? get isReply {
    return _isReply;
  }
  
  String? get replyTo {
    return _replyTo;
  }
  
  MessageStatus? get messageStatus {
    return _messageStatus;
  }
  
  String get userID {
    try {
      return _userID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  const MessageModel._internal({required this.id, isEdited, time, reactions, message, isReply, replyTo, messageStatus, required userID}): _isEdited = isEdited, _time = time, _reactions = reactions, _message = message, _isReply = isReply, _replyTo = replyTo, _messageStatus = messageStatus, _userID = userID;
  
  factory MessageModel({String? id, bool? isEdited, TemporalDateTime? time, List<String>? reactions, String? message, bool? isReply, String? replyTo, MessageStatus? messageStatus, required String userID}) {
    return MessageModel._internal(
      id: id == null ? UUID.getUUID() : id,
      isEdited: isEdited,
      time: time,
      reactions: reactions != null ? List<String>.unmodifiable(reactions) : reactions,
      message: message,
      isReply: isReply,
      replyTo: replyTo,
      messageStatus: messageStatus,
      userID: userID);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MessageModel &&
      id == other.id &&
      _isEdited == other._isEdited &&
      _time == other._time &&
      DeepCollectionEquality().equals(_reactions, other._reactions) &&
      _message == other._message &&
      _isReply == other._isReply &&
      _replyTo == other._replyTo &&
      _messageStatus == other._messageStatus &&
      _userID == other._userID;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("MessageModel {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("isEdited=" + (_isEdited != null ? _isEdited!.toString() : "null") + ", ");
    buffer.write("time=" + (_time != null ? _time!.format() : "null") + ", ");
    buffer.write("reactions=" + (_reactions != null ? _reactions!.toString() : "null") + ", ");
    buffer.write("message=" + "$_message" + ", ");
    buffer.write("isReply=" + (_isReply != null ? _isReply!.toString() : "null") + ", ");
    buffer.write("replyTo=" + "$_replyTo" + ", ");
    buffer.write("messageStatus=" + (_messageStatus != null ? enumToString(_messageStatus)! : "null") + ", ");
    buffer.write("userID=" + "$_userID");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  MessageModel copyWith({String? id, bool? isEdited, TemporalDateTime? time, List<String>? reactions, String? message, bool? isReply, String? replyTo, MessageStatus? messageStatus, String? userID}) {
    return MessageModel._internal(
      id: id ?? this.id,
      isEdited: isEdited ?? this.isEdited,
      time: time ?? this.time,
      reactions: reactions ?? this.reactions,
      message: message ?? this.message,
      isReply: isReply ?? this.isReply,
      replyTo: replyTo ?? this.replyTo,
      messageStatus: messageStatus ?? this.messageStatus,
      userID: userID ?? this.userID);
  }
  
  MessageModel.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _isEdited = json['isEdited'],
      _time = json['time'] != null ? TemporalDateTime.fromString(json['time']) : null,
      _reactions = json['reactions']?.cast<String>(),
      _message = json['message'],
      _isReply = json['isReply'],
      _replyTo = json['replyTo'],
      _messageStatus = enumFromString<MessageStatus>(json['messageStatus'], MessageStatus.values),
      _userID = json['userID'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'isEdited': _isEdited, 'time': _time?.format(), 'reactions': _reactions, 'message': _message, 'isReply': _isReply, 'replyTo': _replyTo, 'messageStatus': enumToString(_messageStatus), 'userID': _userID
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'isEdited': _isEdited, 'time': _time, 'reactions': _reactions, 'message': _message, 'isReply': _isReply, 'replyTo': _replyTo, 'messageStatus': _messageStatus, 'userID': _userID
  };

  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "MessageModel";
    modelSchemaDefinition.pluralName = "MessageModels";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'id',
      isRequired: true,
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
      fieldName: 'reactions',
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'message',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
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
      fieldName: 'messageStatus',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'userID',
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}