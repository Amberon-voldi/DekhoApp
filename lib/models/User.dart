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


/** This is an auto generated class representing the User type in your schema. */
@immutable
class User extends Model {
  static const classType = const _UserModelType();
  final String id;
  final String? _uid;
  final String? _username;
  final String? _nameLowerCase;
  final String? _email;
  final String? _name;
  final String? _phone;
  final bool? _verified;
  final String? _bio;
  final String? _gender;
  final String? _address;
  final String? _pfp;
  final List<String>? _workplace;
  final bool? _married;
  final List<String>? _hobbies;
  final List<String>? _blockedusers;
  final List<String>? _blockedposts;
  final String? _dob;
  final int? _coins;
  final String? _lastredem;
  final String? _accountType;
  final UserStory? _story;
  final bool? _storyUploaded;
  final String? _banner;
  final List<PostModel>? _Posts;
  final String? _country;
  final bool? _isActive;
  final bool? _showActivityStatus;
  final bool? _showMatureContent;
  final String? _referercode;
  final String? _refercode;
  final List<Message>? _Messages;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  UserModelIdentifier get modelIdentifier {
      return UserModelIdentifier(
        id: id
      );
  }
  
  String? get uid {
    return _uid;
  }
  
  String? get username {
    return _username;
  }
  
  String? get nameLowerCase {
    return _nameLowerCase;
  }
  
  String? get email {
    return _email;
  }
  
  String? get name {
    return _name;
  }
  
  String? get phone {
    return _phone;
  }
  
  bool? get verified {
    return _verified;
  }
  
  String? get bio {
    return _bio;
  }
  
  String? get gender {
    return _gender;
  }
  
  String? get address {
    return _address;
  }
  
  String? get pfp {
    return _pfp;
  }
  
  List<String>? get workplace {
    return _workplace;
  }
  
  bool? get married {
    return _married;
  }
  
  List<String>? get hobbies {
    return _hobbies;
  }
  
  List<String>? get blockedusers {
    return _blockedusers;
  }
  
  List<String>? get blockedposts {
    return _blockedposts;
  }
  
  String? get dob {
    return _dob;
  }
  
  int? get coins {
    return _coins;
  }
  
  String? get lastredem {
    return _lastredem;
  }
  
  String? get accountType {
    return _accountType;
  }
  
  UserStory? get story {
    return _story;
  }
  
  bool? get storyUploaded {
    return _storyUploaded;
  }
  
  String? get banner {
    return _banner;
  }
  
  List<PostModel>? get Posts {
    return _Posts;
  }
  
  String? get country {
    return _country;
  }
  
  bool? get isActive {
    return _isActive;
  }
  
  bool? get showActivityStatus {
    return _showActivityStatus;
  }
  
  bool? get showMatureContent {
    return _showMatureContent;
  }
  
  String? get referercode {
    return _referercode;
  }
  
  String? get refercode {
    return _refercode;
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
  
  const User._internal({required this.id, uid, username, nameLowerCase, email, name, phone, verified, bio, gender, address, pfp, workplace, married, hobbies, blockedusers, blockedposts, dob, coins, lastredem, accountType, story, storyUploaded, banner, Posts, country, isActive, showActivityStatus, showMatureContent, referercode, refercode, Messages, createdAt, updatedAt}): _uid = uid, _username = username, _nameLowerCase = nameLowerCase, _email = email, _name = name, _phone = phone, _verified = verified, _bio = bio, _gender = gender, _address = address, _pfp = pfp, _workplace = workplace, _married = married, _hobbies = hobbies, _blockedusers = blockedusers, _blockedposts = blockedposts, _dob = dob, _coins = coins, _lastredem = lastredem, _accountType = accountType, _story = story, _storyUploaded = storyUploaded, _banner = banner, _Posts = Posts, _country = country, _isActive = isActive, _showActivityStatus = showActivityStatus, _showMatureContent = showMatureContent, _referercode = referercode, _refercode = refercode, _Messages = Messages, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory User({String? id, String? uid, String? username, String? nameLowerCase, String? email, String? name, String? phone, bool? verified, String? bio, String? gender, String? address, String? pfp, List<String>? workplace, bool? married, List<String>? hobbies, List<String>? blockedusers, List<String>? blockedposts, String? dob, int? coins, String? lastredem, String? accountType, UserStory? story, bool? storyUploaded, String? banner, List<PostModel>? Posts, String? country, bool? isActive, bool? showActivityStatus, bool? showMatureContent, String? referercode, String? refercode, List<Message>? Messages}) {
    return User._internal(
      id: id == null ? UUID.getUUID() : id,
      uid: uid,
      username: username,
      nameLowerCase: nameLowerCase,
      email: email,
      name: name,
      phone: phone,
      verified: verified,
      bio: bio,
      gender: gender,
      address: address,
      pfp: pfp,
      workplace: workplace != null ? List<String>.unmodifiable(workplace) : workplace,
      married: married,
      hobbies: hobbies != null ? List<String>.unmodifiable(hobbies) : hobbies,
      blockedusers: blockedusers != null ? List<String>.unmodifiable(blockedusers) : blockedusers,
      blockedposts: blockedposts != null ? List<String>.unmodifiable(blockedposts) : blockedposts,
      dob: dob,
      coins: coins,
      lastredem: lastredem,
      accountType: accountType,
      story: story,
      storyUploaded: storyUploaded,
      banner: banner,
      Posts: Posts != null ? List<PostModel>.unmodifiable(Posts) : Posts,
      country: country,
      isActive: isActive,
      showActivityStatus: showActivityStatus,
      showMatureContent: showMatureContent,
      referercode: referercode,
      refercode: refercode,
      Messages: Messages != null ? List<Message>.unmodifiable(Messages) : Messages);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
      id == other.id &&
      _uid == other._uid &&
      _username == other._username &&
      _nameLowerCase == other._nameLowerCase &&
      _email == other._email &&
      _name == other._name &&
      _phone == other._phone &&
      _verified == other._verified &&
      _bio == other._bio &&
      _gender == other._gender &&
      _address == other._address &&
      _pfp == other._pfp &&
      DeepCollectionEquality().equals(_workplace, other._workplace) &&
      _married == other._married &&
      DeepCollectionEquality().equals(_hobbies, other._hobbies) &&
      DeepCollectionEquality().equals(_blockedusers, other._blockedusers) &&
      DeepCollectionEquality().equals(_blockedposts, other._blockedposts) &&
      _dob == other._dob &&
      _coins == other._coins &&
      _lastredem == other._lastredem &&
      _accountType == other._accountType &&
      _story == other._story &&
      _storyUploaded == other._storyUploaded &&
      _banner == other._banner &&
      DeepCollectionEquality().equals(_Posts, other._Posts) &&
      _country == other._country &&
      _isActive == other._isActive &&
      _showActivityStatus == other._showActivityStatus &&
      _showMatureContent == other._showMatureContent &&
      _referercode == other._referercode &&
      _refercode == other._refercode &&
      DeepCollectionEquality().equals(_Messages, other._Messages);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("User {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("uid=" + "$_uid" + ", ");
    buffer.write("username=" + "$_username" + ", ");
    buffer.write("nameLowerCase=" + "$_nameLowerCase" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("phone=" + "$_phone" + ", ");
    buffer.write("verified=" + (_verified != null ? _verified!.toString() : "null") + ", ");
    buffer.write("bio=" + "$_bio" + ", ");
    buffer.write("gender=" + "$_gender" + ", ");
    buffer.write("address=" + "$_address" + ", ");
    buffer.write("pfp=" + "$_pfp" + ", ");
    buffer.write("workplace=" + (_workplace != null ? _workplace!.toString() : "null") + ", ");
    buffer.write("married=" + (_married != null ? _married!.toString() : "null") + ", ");
    buffer.write("hobbies=" + (_hobbies != null ? _hobbies!.toString() : "null") + ", ");
    buffer.write("blockedusers=" + (_blockedusers != null ? _blockedusers!.toString() : "null") + ", ");
    buffer.write("blockedposts=" + (_blockedposts != null ? _blockedposts!.toString() : "null") + ", ");
    buffer.write("dob=" + "$_dob" + ", ");
    buffer.write("coins=" + (_coins != null ? _coins!.toString() : "null") + ", ");
    buffer.write("lastredem=" + "$_lastredem" + ", ");
    buffer.write("accountType=" + "$_accountType" + ", ");
    buffer.write("story=" + (_story != null ? _story!.toString() : "null") + ", ");
    buffer.write("storyUploaded=" + (_storyUploaded != null ? _storyUploaded!.toString() : "null") + ", ");
    buffer.write("banner=" + "$_banner" + ", ");
    buffer.write("country=" + "$_country" + ", ");
    buffer.write("isActive=" + (_isActive != null ? _isActive!.toString() : "null") + ", ");
    buffer.write("showActivityStatus=" + (_showActivityStatus != null ? _showActivityStatus!.toString() : "null") + ", ");
    buffer.write("showMatureContent=" + (_showMatureContent != null ? _showMatureContent!.toString() : "null") + ", ");
    buffer.write("referercode=" + "$_referercode" + ", ");
    buffer.write("refercode=" + "$_refercode" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  User copyWith({String? uid, String? username, String? nameLowerCase, String? email, String? name, String? phone, bool? verified, String? bio, String? gender, String? address, String? pfp, List<String>? workplace, bool? married, List<String>? hobbies, List<String>? blockedusers, List<String>? blockedposts, String? dob, int? coins, String? lastredem, String? accountType, UserStory? story, bool? storyUploaded, String? banner, List<PostModel>? Posts, String? country, bool? isActive, bool? showActivityStatus, bool? showMatureContent, String? referercode, String? refercode, List<Message>? Messages}) {
    return User._internal(
      id: id,
      uid: uid ?? this.uid,
      username: username ?? this.username,
      nameLowerCase: nameLowerCase ?? this.nameLowerCase,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      verified: verified ?? this.verified,
      bio: bio ?? this.bio,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      pfp: pfp ?? this.pfp,
      workplace: workplace ?? this.workplace,
      married: married ?? this.married,
      hobbies: hobbies ?? this.hobbies,
      blockedusers: blockedusers ?? this.blockedusers,
      blockedposts: blockedposts ?? this.blockedposts,
      dob: dob ?? this.dob,
      coins: coins ?? this.coins,
      lastredem: lastredem ?? this.lastredem,
      accountType: accountType ?? this.accountType,
      story: story ?? this.story,
      storyUploaded: storyUploaded ?? this.storyUploaded,
      banner: banner ?? this.banner,
      Posts: Posts ?? this.Posts,
      country: country ?? this.country,
      isActive: isActive ?? this.isActive,
      showActivityStatus: showActivityStatus ?? this.showActivityStatus,
      showMatureContent: showMatureContent ?? this.showMatureContent,
      referercode: referercode ?? this.referercode,
      refercode: refercode ?? this.refercode,
      Messages: Messages ?? this.Messages);
  }
  
  User.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _uid = json['uid'],
      _username = json['username'],
      _nameLowerCase = json['nameLowerCase'],
      _email = json['email'],
      _name = json['name'],
      _phone = json['phone'],
      _verified = json['verified'],
      _bio = json['bio'],
      _gender = json['gender'],
      _address = json['address'],
      _pfp = json['pfp'],
      _workplace = json['workplace']?.cast<String>(),
      _married = json['married'],
      _hobbies = json['hobbies']?.cast<String>(),
      _blockedusers = json['blockedusers']?.cast<String>(),
      _blockedposts = json['blockedposts']?.cast<String>(),
      _dob = json['dob'],
      _coins = (json['coins'] as num?)?.toInt(),
      _lastredem = json['lastredem'],
      _accountType = json['accountType'],
      _story = json['story']?['serializedData'] != null
        ? UserStory.fromJson(new Map<String, dynamic>.from(json['story']['serializedData']))
        : null,
      _storyUploaded = json['storyUploaded'],
      _banner = json['banner'],
      _Posts = json['Posts'] is List
        ? (json['Posts'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => PostModel.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _country = json['country'],
      _isActive = json['isActive'],
      _showActivityStatus = json['showActivityStatus'],
      _showMatureContent = json['showMatureContent'],
      _referercode = json['referercode'],
      _refercode = json['refercode'],
      _Messages = json['Messages'] is List
        ? (json['Messages'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Message.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'uid': _uid, 'username': _username, 'nameLowerCase': _nameLowerCase, 'email': _email, 'name': _name, 'phone': _phone, 'verified': _verified, 'bio': _bio, 'gender': _gender, 'address': _address, 'pfp': _pfp, 'workplace': _workplace, 'married': _married, 'hobbies': _hobbies, 'blockedusers': _blockedusers, 'blockedposts': _blockedposts, 'dob': _dob, 'coins': _coins, 'lastredem': _lastredem, 'accountType': _accountType, 'story': _story?.toJson(), 'storyUploaded': _storyUploaded, 'banner': _banner, 'Posts': _Posts?.map((PostModel? e) => e?.toJson()).toList(), 'country': _country, 'isActive': _isActive, 'showActivityStatus': _showActivityStatus, 'showMatureContent': _showMatureContent, 'referercode': _referercode, 'refercode': _refercode, 'Messages': _Messages?.map((Message? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'uid': _uid, 'username': _username, 'nameLowerCase': _nameLowerCase, 'email': _email, 'name': _name, 'phone': _phone, 'verified': _verified, 'bio': _bio, 'gender': _gender, 'address': _address, 'pfp': _pfp, 'workplace': _workplace, 'married': _married, 'hobbies': _hobbies, 'blockedusers': _blockedusers, 'blockedposts': _blockedposts, 'dob': _dob, 'coins': _coins, 'lastredem': _lastredem, 'accountType': _accountType, 'story': _story, 'storyUploaded': _storyUploaded, 'banner': _banner, 'Posts': _Posts, 'country': _country, 'isActive': _isActive, 'showActivityStatus': _showActivityStatus, 'showMatureContent': _showMatureContent, 'referercode': _referercode, 'refercode': _refercode, 'Messages': _Messages, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<UserModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<UserModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField UID = QueryField(fieldName: "uid");
  static final QueryField USERNAME = QueryField(fieldName: "username");
  static final QueryField NAMELOWERCASE = QueryField(fieldName: "nameLowerCase");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField PHONE = QueryField(fieldName: "phone");
  static final QueryField VERIFIED = QueryField(fieldName: "verified");
  static final QueryField BIO = QueryField(fieldName: "bio");
  static final QueryField GENDER = QueryField(fieldName: "gender");
  static final QueryField ADDRESS = QueryField(fieldName: "address");
  static final QueryField PFP = QueryField(fieldName: "pfp");
  static final QueryField WORKPLACE = QueryField(fieldName: "workplace");
  static final QueryField MARRIED = QueryField(fieldName: "married");
  static final QueryField HOBBIES = QueryField(fieldName: "hobbies");
  static final QueryField BLOCKEDUSERS = QueryField(fieldName: "blockedusers");
  static final QueryField BLOCKEDPOSTS = QueryField(fieldName: "blockedposts");
  static final QueryField DOB = QueryField(fieldName: "dob");
  static final QueryField COINS = QueryField(fieldName: "coins");
  static final QueryField LASTREDEM = QueryField(fieldName: "lastredem");
  static final QueryField ACCOUNTTYPE = QueryField(fieldName: "accountType");
  static final QueryField STORY = QueryField(fieldName: "story");
  static final QueryField STORYUPLOADED = QueryField(fieldName: "storyUploaded");
  static final QueryField BANNER = QueryField(fieldName: "banner");
  static final QueryField POSTS = QueryField(
    fieldName: "Posts",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (PostModel).toString()));
  static final QueryField COUNTRY = QueryField(fieldName: "country");
  static final QueryField ISACTIVE = QueryField(fieldName: "isActive");
  static final QueryField SHOWACTIVITYSTATUS = QueryField(fieldName: "showActivityStatus");
  static final QueryField SHOWMATURECONTENT = QueryField(fieldName: "showMatureContent");
  static final QueryField REFERERCODE = QueryField(fieldName: "referercode");
  static final QueryField REFERCODE = QueryField(fieldName: "refercode");
  static final QueryField MESSAGES = QueryField(
    fieldName: "Messages",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Message).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
    modelSchemaDefinition.pluralName = "Users";
    
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
      key: User.UID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.USERNAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.NAMELOWERCASE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.EMAIL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.PHONE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.VERIFIED,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.BIO,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.GENDER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.ADDRESS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.PFP,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.WORKPLACE,
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.MARRIED,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.HOBBIES,
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.BLOCKEDUSERS,
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.BLOCKEDPOSTS,
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.DOB,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.COINS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.LASTREDEM,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.ACCOUNTTYPE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.embedded(
      fieldName: 'story',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.embedded, ofCustomTypeName: 'UserStory')
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.STORYUPLOADED,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.BANNER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: User.POSTS,
      isRequired: false,
      ofModelName: (PostModel).toString(),
      associatedKey: PostModel.USERID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.COUNTRY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.ISACTIVE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.SHOWACTIVITYSTATUS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.SHOWMATURECONTENT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.REFERERCODE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.REFERCODE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: User.MESSAGES,
      isRequired: false,
      ofModelName: (Message).toString(),
      associatedKey: Message.USERID
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

class _UserModelType extends ModelType<User> {
  const _UserModelType();
  
  @override
  User fromJson(Map<String, dynamic> jsonData) {
    return User.fromJson(jsonData);
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [User] in your schema.
 */
@immutable
class UserModelIdentifier implements ModelIdentifier<User> {
  final String id;

  /** Create an instance of UserModelIdentifier using [id] the primary key. */
  const UserModelIdentifier({
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
  String toString() => 'UserModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is UserModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}