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


/** This is an auto generated class representing the ChatContainer type in your schema. */
@immutable
class ChatContainer extends Model {
  static const classType = const _ChatContainerModelType();
  final String id;
  final bool? _isGroup;
  final String? _startedby;
  final List<String>? _members;
  final TemporalDateTime? _startTime;
  final String? _icon;
  final String? _title;
  final String? _description;
  final String? _lastMessage;
  final TemporalDateTime? _lastMessageTime;
  final List<Message>? _Messages;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  ChatContainerModelIdentifier get modelIdentifier {
      return ChatContainerModelIdentifier(
        id: id
      );
  }
  
  bool? get isGroup {
    return _isGroup;
  }
  
  String? get startedby {
    return _startedby;
  }
  
  List<String> get members {
    try {
      return _members!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime? get startTime {
    return _startTime;
  }
  
  String? get icon {
    return _icon;
  }
  
  String? get title {
    return _title;
  }
  
  String? get description {
    return _description;
  }
  
  String? get lastMessage {
    return _lastMessage;
  }
  
  TemporalDateTime? get lastMessageTime {
    return _lastMessageTime;
  }
  
  List<Message>? get Messages {
    return _Messages;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const ChatContainer._internal({required this.id, isGroup, startedby, required members, startTime, icon, title, description, lastMessage, lastMessageTime, Messages, createdAt, updatedAt}): _isGroup = isGroup, _startedby = startedby, _members = members, _startTime = startTime, _icon = icon, _title = title, _description = description, _lastMessage = lastMessage, _lastMessageTime = lastMessageTime, _Messages = Messages, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory ChatContainer({String? id, bool? isGroup, String? startedby, required List<String> members, TemporalDateTime? startTime, String? icon, String? title, String? description, String? lastMessage, TemporalDateTime? lastMessageTime, List<Message>? Messages}) {
    return ChatContainer._internal(
      id: id == null ? UUID.getUUID() : id,
      isGroup: isGroup,
      startedby: startedby,
      members: members != null ? List<String>.unmodifiable(members) : members,
      startTime: startTime,
      icon: icon,
      title: title,
      description: description,
      lastMessage: lastMessage,
      lastMessageTime: lastMessageTime,
      Messages: Messages != null ? List<Message>.unmodifiable(Messages) : Messages);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatContainer &&
      id == other.id &&
      _isGroup == other._isGroup &&
      _startedby == other._startedby &&
      DeepCollectionEquality().equals(_members, other._members) &&
      _startTime == other._startTime &&
      _icon == other._icon &&
      _title == other._title &&
      _description == other._description &&
      _lastMessage == other._lastMessage &&
      _lastMessageTime == other._lastMessageTime &&
      DeepCollectionEquality().equals(_Messages, other._Messages);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("ChatContainer {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("isGroup=" + (_isGroup != null ? _isGroup!.toString() : "null") + ", ");
    buffer.write("startedby=" + "$_startedby" + ", ");
    buffer.write("members=" + (_members != null ? _members!.toString() : "null") + ", ");
    buffer.write("startTime=" + (_startTime != null ? _startTime!.format() : "null") + ", ");
    buffer.write("icon=" + "$_icon" + ", ");
    buffer.write("title=" + "$_title" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("lastMessage=" + "$_lastMessage" + ", ");
    buffer.write("lastMessageTime=" + (_lastMessageTime != null ? _lastMessageTime!.format() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  ChatContainer copyWith({bool? isGroup, String? startedby, List<String>? members, TemporalDateTime? startTime, String? icon, String? title, String? description, String? lastMessage, TemporalDateTime? lastMessageTime, List<Message>? Messages}) {
    return ChatContainer._internal(
      id: id,
      isGroup: isGroup ?? this.isGroup,
      startedby: startedby ?? this.startedby,
      members: members ?? this.members,
      startTime: startTime ?? this.startTime,
      icon: icon ?? this.icon,
      title: title ?? this.title,
      description: description ?? this.description,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      Messages: Messages ?? this.Messages);
  }
  
  ChatContainer.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _isGroup = json['isGroup'],
      _startedby = json['startedby'],
      _members = json['members']?.cast<String>(),
      _startTime = json['startTime'] != null ? TemporalDateTime.fromString(json['startTime']) : null,
      _icon = json['icon'],
      _title = json['title'],
      _description = json['description'],
      _lastMessage = json['lastMessage'],
      _lastMessageTime = json['lastMessageTime'] != null ? TemporalDateTime.fromString(json['lastMessageTime']) : null,
      _Messages = json['Messages'] is List
        ? (json['Messages'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Message.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'isGroup': _isGroup, 'startedby': _startedby, 'members': _members, 'startTime': _startTime?.format(), 'icon': _icon, 'title': _title, 'description': _description, 'lastMessage': _lastMessage, 'lastMessageTime': _lastMessageTime?.format(), 'Messages': _Messages?.map((Message? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'isGroup': _isGroup, 'startedby': _startedby, 'members': _members, 'startTime': _startTime, 'icon': _icon, 'title': _title, 'description': _description, 'lastMessage': _lastMessage, 'lastMessageTime': _lastMessageTime, 'Messages': _Messages, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<ChatContainerModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<ChatContainerModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField ISGROUP = QueryField(fieldName: "isGroup");
  static final QueryField STARTEDBY = QueryField(fieldName: "startedby");
  static final QueryField MEMBERS = QueryField(fieldName: "members");
  static final QueryField STARTTIME = QueryField(fieldName: "startTime");
  static final QueryField ICON = QueryField(fieldName: "icon");
  static final QueryField TITLE = QueryField(fieldName: "title");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField LASTMESSAGE = QueryField(fieldName: "lastMessage");
  static final QueryField LASTMESSAGETIME = QueryField(fieldName: "lastMessageTime");
  static final QueryField MESSAGES = QueryField(
    fieldName: "Messages",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Message).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ChatContainer";
    modelSchemaDefinition.pluralName = "ChatContainers";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ChatContainer.ISGROUP,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ChatContainer.STARTEDBY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ChatContainer.MEMBERS,
      isRequired: true,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ChatContainer.STARTTIME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ChatContainer.ICON,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ChatContainer.TITLE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ChatContainer.DESCRIPTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ChatContainer.LASTMESSAGE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ChatContainer.LASTMESSAGETIME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: ChatContainer.MESSAGES,
      isRequired: false,
      ofModelName: (Message).toString(),
      associatedKey: Message.CHATCONTAINERID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _ChatContainerModelType extends ModelType<ChatContainer> {
  const _ChatContainerModelType();
  
  @override
  ChatContainer fromJson(Map<String, dynamic> jsonData) {
    return ChatContainer.fromJson(jsonData);
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [ChatContainer] in your schema.
 */
@immutable
class ChatContainerModelIdentifier implements ModelIdentifier<ChatContainer> {
  final String id;

  /** Create an instance of ChatContainerModelIdentifier using [id] the primary key. */
  const ChatContainerModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'ChatContainerModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is ChatContainerModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}