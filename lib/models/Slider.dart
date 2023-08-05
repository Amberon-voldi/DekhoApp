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


/** This is an auto generated class representing the Slider type in your schema. */
@immutable
class Slider extends Model {
  static const classType = const _SliderModelType();
  final String id;
  final String? _image;
  final String? _link;
  final bool? _isClickable;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  SliderModelIdentifier get modelIdentifier {
      return SliderModelIdentifier(
        id: id
      );
  }
  
  String? get image {
    return _image;
  }
  
  String? get link {
    return _link;
  }
  
  bool? get isClickable {
    return _isClickable;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Slider._internal({required this.id, image, link, isClickable, createdAt, updatedAt}): _image = image, _link = link, _isClickable = isClickable, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Slider({String? id, String? image, String? link, bool? isClickable}) {
    return Slider._internal(
      id: id == null ? UUID.getUUID() : id,
      image: image,
      link: link,
      isClickable: isClickable);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Slider &&
      id == other.id &&
      _image == other._image &&
      _link == other._link &&
      _isClickable == other._isClickable;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Slider {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("image=" + "$_image" + ", ");
    buffer.write("link=" + "$_link" + ", ");
    buffer.write("isClickable=" + (_isClickable != null ? _isClickable!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Slider copyWith({String? image, String? link, bool? isClickable}) {
    return Slider._internal(
      id: id,
      image: image ?? this.image,
      link: link ?? this.link,
      isClickable: isClickable ?? this.isClickable);
  }
  
  Slider.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _image = json['image'],
      _link = json['link'],
      _isClickable = json['isClickable'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'image': _image, 'link': _link, 'isClickable': _isClickable, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'image': _image, 'link': _link, 'isClickable': _isClickable, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<SliderModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<SliderModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField IMAGE = QueryField(fieldName: "image");
  static final QueryField LINK = QueryField(fieldName: "link");
  static final QueryField ISCLICKABLE = QueryField(fieldName: "isClickable");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Slider";
    modelSchemaDefinition.pluralName = "Sliders";
    
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
      key: Slider.IMAGE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Slider.LINK,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Slider.ISCLICKABLE,
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

class _SliderModelType extends ModelType<Slider> {
  const _SliderModelType();
  
  @override
  Slider fromJson(Map<String, dynamic> jsonData) {
    return Slider.fromJson(jsonData);
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Slider] in your schema.
 */
@immutable
class SliderModelIdentifier implements ModelIdentifier<Slider> {
  final String id;

  /** Create an instance of SliderModelIdentifier using [id] the primary key. */
  const SliderModelIdentifier({
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
  String toString() => 'SliderModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is SliderModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}