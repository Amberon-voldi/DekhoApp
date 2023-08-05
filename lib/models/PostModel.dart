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


/** This is an auto generated class representing the PostModel type in your schema. */
@immutable
class PostModel extends Model {
  static const classType = const _PostModelModelType();
  final String id;
  final TemporalDateTime? _time;
  final String? _videourl;
  final bool? _isReel;
  final String? _caption;
  final bool? _isPublic;
  final String? _previewimage;
  final int? _shareCount;
  final bool? _isCommentDisabled;
  final String? _pfp;
  final String? _username;
  final List<String>? _media;
  final List<String>? _viewCount;
  final String? _userID;
  final String? _song;
  final List<CommentModel>? _comments;
  final List<String>? _arrayLikes;
  final bool? _isAdultContent;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  PostModelModelIdentifier get modelIdentifier {
      return PostModelModelIdentifier(
        id: id
      );
  }
  
  TemporalDateTime? get time {
    return _time;
  }
  
  String? get videourl {
    return _videourl;
  }
  
  bool? get isReel {
    return _isReel;
  }
  
  String? get caption {
    return _caption;
  }
  
  bool? get isPublic {
    return _isPublic;
  }
  
  String? get previewimage {
    return _previewimage;
  }
  
  int? get shareCount {
    return _shareCount;
  }
  
  bool? get isCommentDisabled {
    return _isCommentDisabled;
  }
  
  String? get pfp {
    return _pfp;
  }
  
  String? get username {
    return _username;
  }
  
  List<String>? get media {
    return _media;
  }
  
  List<String>? get viewCount {
    return _viewCount;
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
  
  String? get song {
    return _song;
  }
  
  List<CommentModel> get comments {
    try {
      return _comments!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<String>? get arrayLikes {
    return _arrayLikes;
  }
  
  bool? get isAdultContent {
    return _isAdultContent;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const PostModel._internal({required this.id, time, videourl, isReel, caption, isPublic, previewimage, shareCount, isCommentDisabled, pfp, username, media, viewCount, required userID, song, required comments, arrayLikes, isAdultContent, createdAt, updatedAt}): _time = time, _videourl = videourl, _isReel = isReel, _caption = caption, _isPublic = isPublic, _previewimage = previewimage, _shareCount = shareCount, _isCommentDisabled = isCommentDisabled, _pfp = pfp, _username = username, _media = media, _viewCount = viewCount, _userID = userID, _song = song, _comments = comments, _arrayLikes = arrayLikes, _isAdultContent = isAdultContent, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory PostModel({String? id, TemporalDateTime? time, String? videourl, bool? isReel, String? caption, bool? isPublic, String? previewimage, int? shareCount, bool? isCommentDisabled, String? pfp, String? username, List<String>? media, List<String>? viewCount, required String userID, String? song, required List<CommentModel> comments, List<String>? arrayLikes, bool? isAdultContent}) {
    return PostModel._internal(
      id: id == null ? UUID.getUUID() : id,
      time: time,
      videourl: videourl,
      isReel: isReel,
      caption: caption,
      isPublic: isPublic,
      previewimage: previewimage,
      shareCount: shareCount,
      isCommentDisabled: isCommentDisabled,
      pfp: pfp,
      username: username,
      media: media != null ? List<String>.unmodifiable(media) : media,
      viewCount: viewCount != null ? List<String>.unmodifiable(viewCount) : viewCount,
      userID: userID,
      song: song,
      comments: comments != null ? List<CommentModel>.unmodifiable(comments) : comments,
      arrayLikes: arrayLikes != null ? List<String>.unmodifiable(arrayLikes) : arrayLikes,
      isAdultContent: isAdultContent);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PostModel &&
      id == other.id &&
      _time == other._time &&
      _videourl == other._videourl &&
      _isReel == other._isReel &&
      _caption == other._caption &&
      _isPublic == other._isPublic &&
      _previewimage == other._previewimage &&
      _shareCount == other._shareCount &&
      _isCommentDisabled == other._isCommentDisabled &&
      _pfp == other._pfp &&
      _username == other._username &&
      DeepCollectionEquality().equals(_media, other._media) &&
      DeepCollectionEquality().equals(_viewCount, other._viewCount) &&
      _userID == other._userID &&
      _song == other._song &&
      DeepCollectionEquality().equals(_comments, other._comments) &&
      DeepCollectionEquality().equals(_arrayLikes, other._arrayLikes) &&
      _isAdultContent == other._isAdultContent;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("PostModel {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("time=" + (_time != null ? _time!.format() : "null") + ", ");
    buffer.write("videourl=" + "$_videourl" + ", ");
    buffer.write("isReel=" + (_isReel != null ? _isReel!.toString() : "null") + ", ");
    buffer.write("caption=" + "$_caption" + ", ");
    buffer.write("isPublic=" + (_isPublic != null ? _isPublic!.toString() : "null") + ", ");
    buffer.write("previewimage=" + "$_previewimage" + ", ");
    buffer.write("shareCount=" + (_shareCount != null ? _shareCount!.toString() : "null") + ", ");
    buffer.write("isCommentDisabled=" + (_isCommentDisabled != null ? _isCommentDisabled!.toString() : "null") + ", ");
    buffer.write("pfp=" + "$_pfp" + ", ");
    buffer.write("username=" + "$_username" + ", ");
    buffer.write("media=" + (_media != null ? _media!.toString() : "null") + ", ");
    buffer.write("viewCount=" + (_viewCount != null ? _viewCount!.toString() : "null") + ", ");
    buffer.write("userID=" + "$_userID" + ", ");
    buffer.write("song=" + "$_song" + ", ");
    buffer.write("comments=" + (_comments != null ? _comments!.toString() : "null") + ", ");
    buffer.write("arrayLikes=" + (_arrayLikes != null ? _arrayLikes!.toString() : "null") + ", ");
    buffer.write("isAdultContent=" + (_isAdultContent != null ? _isAdultContent!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  PostModel copyWith({TemporalDateTime? time, String? videourl, bool? isReel, String? caption, bool? isPublic, String? previewimage, int? shareCount, bool? isCommentDisabled, String? pfp, String? username, List<String>? media, List<String>? viewCount, String? userID, String? song, List<CommentModel>? comments, List<String>? arrayLikes, bool? isAdultContent}) {
    return PostModel._internal(
      id: id,
      time: time ?? this.time,
      videourl: videourl ?? this.videourl,
      isReel: isReel ?? this.isReel,
      caption: caption ?? this.caption,
      isPublic: isPublic ?? this.isPublic,
      previewimage: previewimage ?? this.previewimage,
      shareCount: shareCount ?? this.shareCount,
      isCommentDisabled: isCommentDisabled ?? this.isCommentDisabled,
      pfp: pfp ?? this.pfp,
      username: username ?? this.username,
      media: media ?? this.media,
      viewCount: viewCount ?? this.viewCount,
      userID: userID ?? this.userID,
      song: song ?? this.song,
      comments: comments ?? this.comments,
      arrayLikes: arrayLikes ?? this.arrayLikes,
      isAdultContent: isAdultContent ?? this.isAdultContent);
  }
  
  PostModel.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _time = json['time'] != null ? TemporalDateTime.fromString(json['time']) : null,
      _videourl = json['videourl'],
      _isReel = json['isReel'],
      _caption = json['caption'],
      _isPublic = json['isPublic'],
      _previewimage = json['previewimage'],
      _shareCount = (json['shareCount'] as num?)?.toInt(),
      _isCommentDisabled = json['isCommentDisabled'],
      _pfp = json['pfp'],
      _username = json['username'],
      _media = json['media']?.cast<String>(),
      _viewCount = json['viewCount']?.cast<String>(),
      _userID = json['userID'],
      _song = json['song'],
      _comments = json['comments'] is List
        ? (json['comments'] as List)
          .where((e) => e != null)
          .map((e) => CommentModel.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _arrayLikes = json['arrayLikes']?.cast<String>(),
      _isAdultContent = json['isAdultContent'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'time': _time?.format(), 'videourl': _videourl, 'isReel': _isReel, 'caption': _caption, 'isPublic': _isPublic, 'previewimage': _previewimage, 'shareCount': _shareCount, 'isCommentDisabled': _isCommentDisabled, 'pfp': _pfp, 'username': _username, 'media': _media, 'viewCount': _viewCount, 'userID': _userID, 'song': _song, 'comments': _comments?.map((CommentModel? e) => e?.toJson()).toList(), 'arrayLikes': _arrayLikes, 'isAdultContent': _isAdultContent, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'time': _time, 'videourl': _videourl, 'isReel': _isReel, 'caption': _caption, 'isPublic': _isPublic, 'previewimage': _previewimage, 'shareCount': _shareCount, 'isCommentDisabled': _isCommentDisabled, 'pfp': _pfp, 'username': _username, 'media': _media, 'viewCount': _viewCount, 'userID': _userID, 'song': _song, 'comments': _comments, 'arrayLikes': _arrayLikes, 'isAdultContent': _isAdultContent, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<PostModelModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<PostModelModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField TIME = QueryField(fieldName: "time");
  static final QueryField VIDEOURL = QueryField(fieldName: "videourl");
  static final QueryField ISREEL = QueryField(fieldName: "isReel");
  static final QueryField CAPTION = QueryField(fieldName: "caption");
  static final QueryField ISPUBLIC = QueryField(fieldName: "isPublic");
  static final QueryField PREVIEWIMAGE = QueryField(fieldName: "previewimage");
  static final QueryField SHARECOUNT = QueryField(fieldName: "shareCount");
  static final QueryField ISCOMMENTDISABLED = QueryField(fieldName: "isCommentDisabled");
  static final QueryField PFP = QueryField(fieldName: "pfp");
  static final QueryField USERNAME = QueryField(fieldName: "username");
  static final QueryField MEDIA = QueryField(fieldName: "media");
  static final QueryField VIEWCOUNT = QueryField(fieldName: "viewCount");
  static final QueryField USERID = QueryField(fieldName: "userID");
  static final QueryField SONG = QueryField(fieldName: "song");
  static final QueryField COMMENTS = QueryField(fieldName: "comments");
  static final QueryField ARRAYLIKES = QueryField(fieldName: "arrayLikes");
  static final QueryField ISADULTCONTENT = QueryField(fieldName: "isAdultContent");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "PostModel";
    modelSchemaDefinition.pluralName = "PostModels";
    
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
    
    modelSchemaDefinition.indexes = [
      ModelIndex(fields: const ["userID"], name: "byUser")
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: PostModel.TIME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: PostModel.VIDEOURL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: PostModel.ISREEL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: PostModel.CAPTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: PostModel.ISPUBLIC,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: PostModel.PREVIEWIMAGE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: PostModel.SHARECOUNT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: PostModel.ISCOMMENTDISABLED,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: PostModel.PFP,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: PostModel.USERNAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: PostModel.MEDIA,
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: PostModel.VIEWCOUNT,
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: PostModel.USERID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: PostModel.SONG,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.embedded(
      fieldName: 'comments',
      isRequired: true,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.embeddedCollection, ofCustomTypeName: 'CommentModel')
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: PostModel.ARRAYLIKES,
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: PostModel.ISADULTCONTENT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
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

class _PostModelModelType extends ModelType<PostModel> {
  const _PostModelModelType();
  
  @override
  PostModel fromJson(Map<String, dynamic> jsonData) {
    return PostModel.fromJson(jsonData);
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [PostModel] in your schema.
 */
@immutable
class PostModelModelIdentifier implements ModelIdentifier<PostModel> {
  final String id;

  /** Create an instance of PostModelModelIdentifier using [id] the primary key. */
  const PostModelModelIdentifier({
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
  String toString() => 'PostModelModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is PostModelModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}