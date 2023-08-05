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
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Follow type in your schema. */
@immutable
class Follow extends Model {
  static const classType = const _FollowModelType();
  final String id;
  final String? _following;
  final String? _followedby;
  final String? _metaData;
  final TemporalDateTime? _time;
  final bool? _accepted;
  final TemporalDateTime? _acceptedOn;
  final String? _username;
  final String? _pfp;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  FollowModelIdentifier get modelIdentifier {
      return FollowModelIdentifier(
        id: id
      );
  }
  
  String? get following {
    return _following;
  }
  
  String? get followedby {
    return _followedby;
  }
  
  String? get metaData {
    return _metaData;
  }
  
  TemporalDateTime? get time {
    return _time;
  }
  
  bool? get accepted {
    return _accepted;
  }
  
  TemporalDateTime? get acceptedOn {
    return _acceptedOn;
  }
  
  String? get username {
    return _username;
  }
  
  String? get pfp {
    return _pfp;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Follow._internal({required this.id, following, followedby, metaData, time, accepted, acceptedOn, username, pfp, createdAt, updatedAt}): _following = following, _followedby = followedby, _metaData = metaData, _time = time, _accepted = accepted, _acceptedOn = acceptedOn, _username = username, _pfp = pfp, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Follow({String? id, String? following, String? followedby, String? metaData, TemporalDateTime? time, bool? accepted, TemporalDateTime? acceptedOn, String? username, String? pfp}) {
    return Follow._internal(
      id: id == null ? UUID.getUUID() : id,
      following: following,
      followedby: followedby,
      metaData: metaData,
      time: time,
      accepted: accepted,
      acceptedOn: acceptedOn,
      username: username,
      pfp: pfp);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Follow &&
      id == other.id &&
      _following == other._following &&
      _followedby == other._followedby &&
      _metaData == other._metaData &&
      _time == other._time &&
      _accepted == other._accepted &&
      _acceptedOn == other._acceptedOn &&
      _username == other._username &&
      _pfp == other._pfp;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Follow {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("following=" + "$_following" + ", ");
    buffer.write("followedby=" + "$_followedby" + ", ");
    buffer.write("metaData=" + "$_metaData" + ", ");
    buffer.write("time=" + (_time != null ? _time!.format() : "null") + ", ");
    buffer.write("accepted=" + (_accepted != null ? _accepted!.toString() : "null") + ", ");
    buffer.write("acceptedOn=" + (_acceptedOn != null ? _acceptedOn!.format() : "null") + ", ");
    buffer.write("username=" + "$_username" + ", ");
    buffer.write("pfp=" + "$_pfp" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Follow copyWith({String? following, String? followedby, String? metaData, TemporalDateTime? time, bool? accepted, TemporalDateTime? acceptedOn, String? username, String? pfp}) {
    return Follow._internal(
      id: id,
      following: following ?? this.following,
      followedby: followedby ?? this.followedby,
      metaData: metaData ?? this.metaData,
      time: time ?? this.time,
      accepted: accepted ?? this.accepted,
      acceptedOn: acceptedOn ?? this.acceptedOn,
      username: username ?? this.username,
      pfp: pfp ?? this.pfp);
  }
  
  Follow.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _following = json['following'],
      _followedby = json['followedby'],
      _metaData = json['metaData'],
      _time = json['time'] != null ? TemporalDateTime.fromString(json['time']) : null,
      _accepted = json['accepted'],
      _acceptedOn = json['acceptedOn'] != null ? TemporalDateTime.fromString(json['acceptedOn']) : null,
      _username = json['username'],
      _pfp = json['pfp'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'following': _following, 'followedby': _followedby, 'metaData': _metaData, 'time': _time?.format(), 'accepted': _accepted, 'acceptedOn': _acceptedOn?.format(), 'username': _username, 'pfp': _pfp, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'following': _following, 'followedby': _followedby, 'metaData': _metaData, 'time': _time, 'accepted': _accepted, 'acceptedOn': _acceptedOn, 'username': _username, 'pfp': _pfp, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<FollowModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<FollowModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField FOLLOWING = QueryField(fieldName: "following");
  static final QueryField FOLLOWEDBY = QueryField(fieldName: "followedby");
  static final QueryField METADATA = QueryField(fieldName: "metaData");
  static final QueryField TIME = QueryField(fieldName: "time");
  static final QueryField ACCEPTED = QueryField(fieldName: "accepted");
  static final QueryField ACCEPTEDON = QueryField(fieldName: "acceptedOn");
  static final QueryField USERNAME = QueryField(fieldName: "username");
  static final QueryField PFP = QueryField(fieldName: "pfp");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Follow";
    modelSchemaDefinition.pluralName = "Follows";
    
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
      key: Follow.FOLLOWING,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Follow.FOLLOWEDBY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Follow.METADATA,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Follow.TIME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Follow.ACCEPTED,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Follow.ACCEPTEDON,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Follow.USERNAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Follow.PFP,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
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

class _FollowModelType extends ModelType<Follow> {
  const _FollowModelType();
  
  @override
  Follow fromJson(Map<String, dynamic> jsonData) {
    return Follow.fromJson(jsonData);
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Follow] in your schema.
 */
@immutable
class FollowModelIdentifier implements ModelIdentifier<Follow> {
  final String id;

  /** Create an instance of FollowModelIdentifier using [id] the primary key. */
  const FollowModelIdentifier({
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
  String toString() => 'FollowModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is FollowModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}