// Copyright 2019 The OmniTree Authors.

/// Schema visitor (Visitor Pattern).
///
/// `visit()` methods should return `true` to proceed with schema traversal
/// and `false` to stop schema traversal.
public protocol SchemaVisitor {
  func visit(package: PackageSchema) -> Bool

  func visit(alias: AliasSchema) -> Bool
  func visit(enumeration: EnumerationSchema) -> Bool
  func visit(entity: EntitySchema) -> Bool

  // Fields
  func visit(primitiveField: PrimitiveFieldSchema) -> Bool
  func visit(aliasField: AliasFieldSchema) -> Bool
  func visit(enumerationField: EnumerationFieldSchema) -> Bool
  func visit(entityField: EntityFieldSchema) -> Bool

  // Primitives
  func visit(boolean: BooleanSchema) -> Bool
  func visit<T: NumericSchema>(number: T) -> Bool
  func visit(string: StringSchema) -> Bool
  func visit(password1Way: Password1WaySchema) -> Bool
  func visit(password2Way: Password2WaySchema) -> Bool
  func visit(uuid: UuidSchema) -> Bool
  func visit(blob: BlobSchema) -> Bool
}
