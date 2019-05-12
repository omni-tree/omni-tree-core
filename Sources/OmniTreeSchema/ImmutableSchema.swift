// Copyright 2019 The OmniTree Authors.

// Immutable protocols for elements of the OmniTree schema.

/// This is the base protocol for all schema elements. It contains fields that
/// are common to all schema elements.
public protocol ElementSchema: Codable {
  var name: String { get }
}

// MARK: - User-Defined Types -

/// Schema for a user-defined package.
public protocol Package: ElementSchema {
  var aliases: [AliasSchema] { get }
  var enumerations: [EnumerationSchema] { get }
  var entities: [EntitySchema] { get }
}

/// Schema for user-defined primitive aliases.
/// Primitive aliases allow constrained primitive types to be reused without
/// having to repeat the constratins at every field that needs those
/// constraints.
public protocol AliasSchema: ElementSchema {
  var primitive: PrimitiveSchema { get }
}

/// Schema for user-defined enumerations.
public protocol EnumerationSchema: ElementSchema {
  var values: [String] { get }
}

/// Schema for user-defined entities.
public protocol EntitySchema: ElementSchema {
  var fields: [FieldSchema] { get }
}

// MARK: - Fields -

/// Schema for fields in an entity.
/// There are subtypes for the schema of different types of fields: primitive
/// fields, alias fields, enum fields, and entity fields.
public protocol FieldSchema: ElementSchema {}

/// Schema for fields whose types are predefined primitives.
public protocol PrimitiveFieldSchema: FieldSchema {
  var primitive: PrimitiveSchema { get }
}

// TODO: ability to refer to aliases, enumerations, entities defined in a
// different pacakges.

/// Schema for fields whose types are user-defined primitive aliases.
public protocol AliasFieldSchema: FieldSchema {
  var alias: AliasSchema { get }
}

/// Schema for fields whose types are user-defined enumerations.
public protocol EnumerationFieldSchema: FieldSchema {
  var enumeration: EnumerationSchema { get }
}

/// Schema for fields whose types are user-defined entities.
public protocol EntityFieldSchema: FieldSchema {
  var entity: EntitySchema { get }
  // TODO: composition vs reference
}

// MARK: - Predefined Primitives -

/// Schema for primitives.
/// There are sub-protocols for each type of primitive.
public protocol PrimitiveSchema: Codable {}

/// Schema for boolean primitive.
public protocol BooleanSchema: PrimitiveSchema {}

/// Schema for numeric primitives.
public protocol NumericSchema: PrimitiveSchema {
  associatedtype T: NumericConstraints

  var constraints: T { get }
}

/// Schema for string primitive.
public protocol StringSchema: PrimitiveSchema {
  var constraints: StringConstraints { get }
}

/// Schema for password primitive that can be encrypted but not decrypted
/// (1-way).
public protocol Password1WaySchema: StringSchema {}

/// Schema for password primitive that can be encrypted as well as decrypted
/// (2-way).
public protocol Password2WaySchema: StringSchema {}

/// Schema for UUID fields.
public protocol UuidSchema: PrimitiveSchema {}

/// Schema for blob primtive that can store binary data.
public protocol BlobSchema: PrimitiveSchema {}

// MARK: - Constraints -

/// Constraints on the cardinality of a field.
public protocol Multiplicity: Codable {
  var min: UInt { get }
  var max: UInt { get }
}

/// Constraints for numeric fields.
public protocol NumericConstraints {
  associatedtype T: NumericBound
  var minValue: T? { get }
  var maxValue: T? { get }
}

/// An inclusive/exclusive bound for a numeric field.
public protocol NumericBound {
  associatedtype T: Numeric
  var value: T { get }
  var inclusive: Bool { get }
}

/// Constraints for string fields.
public protocol StringConstraints: Codable {
  var minLength: Int? { get }
  var maxLength: Int? { get }
  var regexPattern: String? { get }
}
