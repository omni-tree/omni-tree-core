// Copyright 2019 The OmniTree Authors.

import OmniTreeSchema

/// A visitor for encoding a schema.
public class SchemaEncodingVisitor: BracketedVisitor, SchemaVisitor {
  private let wireFormatEncoder: WireFormatEncoder

  init(wireFormatEncoder: WireFormatEncoder) {
    self.wireFormatEncoder = wireFormatEncoder
  }

  // MARK: - BracketedVisitor Methods -

  public func objectStart(name: String) {
    wireFormatEncoder.encodeObjectStart(name: name)
  }

  public func objectEnd() {
    wireFormatEncoder.encodeObjectEnd()
  }

  public func listStart(name: String) {
    wireFormatEncoder.encodeListStart(name: name)
  }

  public func listEnd() {
    wireFormatEncoder.encodeListEnd()
  }

  // MARK: - SchemaVisitor Methods -

  public func visit(package: PackageSchema) -> Bool {
    wireFormatEncoder.encodeStringField(name: "name", value: package.name)
    return true
  }

  public func visit(alias: AliasSchema) -> Bool {
    wireFormatEncoder.encodeStringField(name: "name", value: alias.name)
    return true
  }

  public func visit(enumeration: EnumerationSchema) -> Bool {
    wireFormatEncoder.encodeStringField(name: "name", value: enumeration.name)
    wireFormatEncoder.encodeListStart(name: "values")
    defer { wireFormatEncoder.encodeListEnd() }
    for value in enumeration.values {
      wireFormatEncoder.encodeStringField(name: "value", value: value)
    }
    return true
  }

  public func visit(entity: EntitySchema) -> Bool {
    wireFormatEncoder.encodeStringField(name: "name", value: entity.name)
    return true
  }

  public func visit(primitiveField _: PrimitiveFieldSchema) -> Bool {
    return true
  }

  public func visit(aliasField _: AliasFieldSchema) -> Bool {
    return true
  }

  public func visit(enumerationField _: EnumerationFieldSchema) -> Bool {
    return true
  }

  public func visit(entityField _: EntityFieldSchema) -> Bool {
    return true
  }

  public func visit(boolean _: BooleanSchema) -> Bool {
    return true
  }

  public func visit<T>(number _: T) -> Bool where T: NumericSchema {
    return true
  }

  public func visit(string _: StringSchema) -> Bool {
    return true
  }

  public func visit(password1Way _: Password1WaySchema) -> Bool {
    return true
  }

  public func visit(password2Way _: Password2WaySchema) -> Bool {
    return true
  }

  public func visit(uuid _: UuidSchema) -> Bool {
    return true
  }

  public func visit(blob _: BlobSchema) -> Bool {
    return true
  }
}
