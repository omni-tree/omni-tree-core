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

// MARK: - Top Level Traversal Extensions -

extension ElementSchema {
  public func accept(visitor _: SchemaVisitor) -> Bool { return false }
}

extension PackageSchema {
  public func accept(visitor: SchemaVisitor) -> Bool {
    // Visit the package.
    (visitor as? BracketedVisitor)?.objectStart(name: "package")
    defer { (visitor as? BracketedVisitor)?.objectEnd() }
    if !visitor.visit(package: self) { return false }

    // Traverse the children.
    if !aliases.isEmpty {
      (visitor as? BracketedVisitor)?.listStart(name: "aliases")
      defer { (visitor as? BracketedVisitor)?.listEnd() }
      for alias in aliases {
        if !alias.accept(visitor: visitor) { return false }
      }
    }
    if !enumerations.isEmpty {
      (visitor as? BracketedVisitor)?.listStart(name: "enumerations")
      defer { (visitor as? BracketedVisitor)?.listEnd() }
      for enumeration in enumerations {
        if !enumeration.accept(visitor: visitor) { return false }
      }
    }
    if !entities.isEmpty {
      (visitor as? BracketedVisitor)?.listStart(name: "entities")
      defer { (visitor as? BracketedVisitor)?.listEnd() }
      for entity in entities {
        if !entity.accept(visitor: visitor) { return false }
      }
    }

    return true
  }
}

extension AliasSchema {
  public func accept(visitor: SchemaVisitor) -> Bool {
    // Visit the alias.
    (visitor as? BracketedVisitor)?.objectStart(name: "alias")
    defer { (visitor as? BracketedVisitor)?.objectEnd() }
    if !visitor.visit(alias: self) { return false }

    // Traverse the children.
    if !primitive.accept(visitor: visitor) { return false }

    return true
  }
}

extension EnumerationSchema {
  public func accept(visitor: SchemaVisitor) -> Bool {
    // Visit the enumeration
    (visitor as? BracketedVisitor)?.objectStart(name: "enumeration")
    defer { (visitor as? BracketedVisitor)?.objectEnd() }
    return visitor.visit(enumeration: self)
  }
}

extension EntitySchema {
  public func accept(visitor: SchemaVisitor) -> Bool {
    // Visit the entity.
    (visitor as? BracketedVisitor)?.objectStart(name: "entity")
    defer { (visitor as? BracketedVisitor)?.objectEnd() }
    if !visitor.visit(entity: self) { return false }

    // Traverse the children.
    if !fields.isEmpty {
      (visitor as? BracketedVisitor)?.listStart(name: "fields")
      defer { (visitor as? BracketedVisitor)?.listEnd() }
      for field in fields {
        if !field.accept(visitor: visitor) { return false }
      }
    }

    return true
  }
}

// MARK: - Field Traversal Extensions -

extension PrimitiveFieldSchema {
  public func accept(visitor: SchemaVisitor) -> Bool {
    // Visit the primitive field.
    (visitor as? BracketedVisitor)?.objectStart(name: "primitive_field")
    defer { (visitor as? BracketedVisitor)?.objectEnd() }
    if !visitor.visit(primitiveField: self) { return false }

    // Traverse the children.
    if !primitive.accept(visitor: visitor) { return false }

    return true
  }
}

extension AliasFieldSchema {
  public func accept(visitor: SchemaVisitor) -> Bool {
    // Visit the alias field.
    (visitor as? BracketedVisitor)?.objectStart(name: "alias_field")
    defer { (visitor as? BracketedVisitor)?.objectEnd() }
    if !visitor.visit(aliasField: self) { return false }

    // Traverse the children.
    if !alias.accept(visitor: visitor) { return false }

    return true
  }
}

extension EnumerationFieldSchema {
  public func accept(visitor: SchemaVisitor) -> Bool {
    // Visit the enumeration field.
    (visitor as? BracketedVisitor)?.objectStart(name: "enumeration_field")
    defer { (visitor as? BracketedVisitor)?.objectEnd() }
    if !visitor.visit(enumerationField: self) { return false }

    // Traverse the children.
    if !enumeration.accept(visitor: visitor) { return false }

    return true
  }
}

extension EntityFieldSchema {
  public func accept(visitor: SchemaVisitor) -> Bool {
    // Visit the entity field.
    (visitor as? BracketedVisitor)?.objectStart(name: "entity_field")
    defer { (visitor as? BracketedVisitor)?.objectEnd() }
    if !visitor.visit(entityField: self) { return false }

    // Traverse the children.
    if !entity.accept(visitor: visitor) { return false }

    return true
  }
}

// MARK: - Primitive Traversal Extensions -

extension PrimitiveSchema {
  public func accept(visitor _: SchemaVisitor) -> Bool { return false }
}

extension BooleanSchema {
  public func accept(visitor: SchemaVisitor) -> Bool {
    return visitor.visit(boolean: self)
  }
}

extension NumericSchema {
  public func accept(visitor: SchemaVisitor) -> Bool {
    return visitor.visit(number: self)
  }
}

extension StringSchema {
  public func accept(visitor: SchemaVisitor) -> Bool {
    return visitor.visit(string: self)
  }
}

extension Password1WaySchema {
  public func accept(visitor: SchemaVisitor) -> Bool {
    return visitor.visit(password1Way: self)
  }
}

extension Password2WaySchema {
  public func accept(visitor: SchemaVisitor) -> Bool {
    return visitor.visit(password2Way: self)
  }
}

extension UuidSchema {
  public func accept(visitor: SchemaVisitor) -> Bool {
    return visitor.visit(uuid: self)
  }
}

extension BlobSchema {
  public func accept(visitor: SchemaVisitor) -> Bool {
    return visitor.visit(blob: self)
  }
}
