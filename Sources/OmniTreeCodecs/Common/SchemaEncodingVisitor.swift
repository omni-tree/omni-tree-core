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

  // MARK: - SchemaVisitor Methods for User-Defined Types -

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

  // MARK: - SchemaVisitor Methods for Fields -

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

  // MARK: - SchemaVisitor Methods for Predefined Primitives -

  public func visit(boolean _: BooleanSchema) -> Bool {
    wireFormatEncoder.encodeStringField(name: "type", value: "boolean")
    return true
  }

  public func visit<T>(number: T) -> Bool where T: NumericSchema {
    // TODO: how do we specify the specific numeric type? i.e. the type of T?
    wireFormatEncoder.encodeStringField(name: "type", value: "numeric")
    if let constraints = number.constraints {
      encodeNumericConstraints(constraints)
    }
    return true
  }

  public func visit(string: StringSchema) -> Bool {
    wireFormatEncoder.encodeStringField(name: "type", value: "string")
    if let constraints = string.constraints {
      encodeStringConstraints(constraints)
    }
    return true
  }

  public func visit(password1Way: Password1WaySchema) -> Bool {
    wireFormatEncoder.encodeStringField(name: "type", value: "password_1_way")
    if let constraints = password1Way.constraints {
      encodeStringConstraints(constraints)
    }
    return true
  }

  public func visit(password2Way: Password2WaySchema) -> Bool {
    wireFormatEncoder.encodeStringField(name: "type", value: "password_2_way")
    if let constraints = password2Way.constraints {
      encodeStringConstraints(constraints)
    }
    return true
  }

  public func visit(uuid _: UuidSchema) -> Bool {
    wireFormatEncoder.encodeStringField(name: "type", value: "uuid")
    return true
  }

  public func visit(blob _: BlobSchema) -> Bool {
    wireFormatEncoder.encodeStringField(name: "type", value: "blob")
    return true
  }

  // MARK: - Helper Methods for Constraints -

  private func encodeNumericConstraints<T: NumericConstraints>(_ constraints: T) {
    objectStart(name: "constraints")
    defer { objectEnd() }
    if let minBound = constraints.minBound {
      encodeNumericBound(minBound, name: "min_bound")
    }
    if let maxBound = constraints.maxBound {
      encodeNumericBound(maxBound, name: "max_bound")
    }
  }

  private func encodeNumericBound<T: NumericBound>(_ bound: T, name: String) {
    objectStart(name: name)
    defer { objectEnd() }
    wireFormatEncoder.encodeNumericField(name: "value", value: bound.value)
    wireFormatEncoder.encodeBooleanField(name: "inclusive", value: bound.inclusive)
  }

  private func encodeStringConstraints(_ constraints: StringConstraints) {
    objectStart(name: "constraints")
    defer { objectEnd() }
    if let minLength = constraints.minLength {
      wireFormatEncoder.encodeNumericField(name: "min_length", value: minLength)
    }
    if let maxLength = constraints.maxLength {
      wireFormatEncoder.encodeNumericField(name: "max_length", value: maxLength)
    }
    if let regex = constraints.regex {
      wireFormatEncoder.encodeStringField(name: "regex", value: regex)
    }
  }
}
