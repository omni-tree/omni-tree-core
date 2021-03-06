// Copyright 2019 The OmniTree Authors.

// Mutable classes for elements of the OmniTree schema.

public class MutableElementSchema: ElementSchema {
  public var name: String = ""

  fileprivate init() {}

  fileprivate init(name: String) {
    self.name = name
  }

  public func accept(visitor _: SchemaVisitor) -> Bool {
    fatalError("Abstract method called")
  }
}

// MARK: - User-Defined Types -

public class MutablePackageSchema: MutableElementSchema, PackageSchema {
  public var aliases: [AliasSchema] {
    return mutableAliases
  }

  public var enumerations: [EnumerationSchema] {
    return mutableEnumerations
  }

  public var entities: [EntitySchema] {
    return mutableEntities
  }

  public var mutableAliases: [MutableAliasSchema] = []
  public var mutableEnumerations: [MutableEnumerationSchema] = []
  public var mutableEntities: [MutableEntitySchema] = []

  public override init() {
    super.init()
  }

  public init(name: String, aliases: [MutableAliasSchema] = [], enumerations: [MutableEnumerationSchema] = [], entities: [MutableEntitySchema] = []) {
    super.init(name: name)
    mutableAliases = aliases
    mutableEnumerations = enumerations
    mutableEntities = entities
  }

  public override func accept(visitor: SchemaVisitor) -> Bool {
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

public class MutableAliasSchema: MutableElementSchema, AliasSchema {
  public var primitive: PrimitiveSchema {
    return mutablePrimitive
  }

  public var mutablePrimitive: MutablePrimitiveSchema = MutablePrimitiveSchema()

  public override init() {
    super.init()
  }

  public init(name: String, primitive: MutablePrimitiveSchema) {
    super.init(name: name)
    mutablePrimitive = primitive
  }

  public override func accept(visitor: SchemaVisitor) -> Bool {
    // Visit the alias.
    (visitor as? BracketedVisitor)?.objectStart(name: "alias")
    defer { (visitor as? BracketedVisitor)?.objectEnd() }
    if !visitor.visit(alias: self) { return false }

    // Traverse the children.
    if !primitive.accept(visitor: visitor) { return false }

    return true
  }
}

public class MutableEnumerationSchema: MutableElementSchema, EnumerationSchema {
  public var values: [String] = []

  public override init() {
    super.init()
  }

  public init(name: String, values: [String]) {
    super.init(name: name)
    self.values = values
  }

  public override func accept(visitor: SchemaVisitor) -> Bool {
    // Visit the enumeration
    (visitor as? BracketedVisitor)?.objectStart(name: "enumeration")
    defer { (visitor as? BracketedVisitor)?.objectEnd() }
    return visitor.visit(enumeration: self)
  }
}

public class MutableEntitySchema: MutableElementSchema, EntitySchema {
  public var fields: [FieldSchema] {
    return mutableFields
  }

  public var mutableFields: [MutableFieldSchema] = []

  public override init() {
    super.init()
  }

  public init(name: String, fields: [MutableFieldSchema]) {
    super.init(name: name)
    mutableFields = fields
  }

  public override func accept(visitor: SchemaVisitor) -> Bool {
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

// MARK: - Fields -

public class MutableFieldSchema: MutableElementSchema, FieldSchema {
  public override func accept(visitor _: SchemaVisitor) -> Bool {
    fatalError("Abstract method called")
  }
}

public class MutablePrimitiveFieldSchema: MutableFieldSchema, PrimitiveFieldSchema {
  public var primitive: PrimitiveSchema {
    return mutablePrimitive
  }

  public var mutablePrimitive: MutablePrimitiveSchema = MutablePrimitiveSchema()

  public override init() {
    super.init()
  }

  public init(name: String, primitive: MutablePrimitiveSchema) {
    super.init(name: name)
    mutablePrimitive = primitive
  }

  public override func accept(visitor: SchemaVisitor) -> Bool {
    // Visit the primitive field.
    (visitor as? BracketedVisitor)?.objectStart(name: "primitive_field")
    defer { (visitor as? BracketedVisitor)?.objectEnd() }
    if !visitor.visit(primitiveField: self) { return false }

    // Traverse the children.
    if !primitive.accept(visitor: visitor) { return false }

    return true
  }
}

public class MutableAliasFieldSchema: MutableFieldSchema, AliasFieldSchema {
  public var alias: AliasSchema {
    return mutableAlias
  }

  public var mutableAlias: MutableAliasSchema = MutableAliasSchema()

  public override init() {
    super.init()
  }

  public init(name: String, alias: MutableAliasSchema) {
    super.init(name: name)
    mutableAlias = alias
  }

  public override func accept(visitor: SchemaVisitor) -> Bool {
    // Visit the alias field.
    (visitor as? BracketedVisitor)?.objectStart(name: "alias_field")
    defer { (visitor as? BracketedVisitor)?.objectEnd() }
    if !visitor.visit(aliasField: self) { return false }

    // Traverse the children.
    if !alias.accept(visitor: visitor) { return false }

    return true
  }
}

public class MutableEnumerationFieldSchema: MutableFieldSchema, EnumerationFieldSchema {
  public var enumeration: EnumerationSchema {
    return mutableEnumeration
  }

  public var mutableEnumeration: MutableEnumerationSchema = MutableEnumerationSchema()

  public override init() {
    super.init()
  }

  public init(name: String, enumeration: MutableEnumerationSchema) {
    super.init(name: name)
    mutableEnumeration = enumeration
  }

  public override func accept(visitor: SchemaVisitor) -> Bool {
    // Visit the enumeration field.
    (visitor as? BracketedVisitor)?.objectStart(name: "enumeration_field")
    defer { (visitor as? BracketedVisitor)?.objectEnd() }
    if !visitor.visit(enumerationField: self) { return false }

    // Traverse the children.
    if !enumeration.accept(visitor: visitor) { return false }

    return true
  }
}

public class MutableEntityFieldSchema: MutableFieldSchema, EntityFieldSchema {
  public var entity: EntitySchema {
    return mutableEntity
  }

  public var mutableEntity: MutableEntitySchema = MutableEntitySchema()

  public override init() {
    super.init()
  }

  public init(name: String, entity: MutableEntitySchema) {
    super.init(name: name)
    mutableEntity = entity
  }

  public override func accept(visitor: SchemaVisitor) -> Bool {
    // Visit the entity field.
    (visitor as? BracketedVisitor)?.objectStart(name: "entity_field")
    defer { (visitor as? BracketedVisitor)?.objectEnd() }
    if !visitor.visit(entityField: self) { return false }

    // Traverse the children.
    if !entity.accept(visitor: visitor) { return false }

    return true
  }
}

// MARK: - Predefined Primitives -

public class MutablePrimitiveSchema: PrimitiveSchema {
  fileprivate init() {}

  public func accept(visitor _: SchemaVisitor) -> Bool {
    fatalError("Abstract method called")
  }
}

public class MutableBooleanSchema: MutablePrimitiveSchema, BooleanSchema {
  public override func accept(visitor: SchemaVisitor) -> Bool {
    return visitor.visit(boolean: self)
  }
}

public class MutableNumericSchema<T: Numeric>: MutablePrimitiveSchema, NumericSchema {
  // TODO: does MutableNumericConstraints<T> leak when this is accessed as NumericSchema?
  public var constraints: MutableNumericConstraints<T>? = nil

  public override init() {
    super.init()
  }

  public init(constraints: MutableNumericConstraints<T>?) {
    self.constraints = constraints
  }

  public override func accept(visitor: SchemaVisitor) -> Bool {
    return visitor.visit(number: self)
  }
}

public class MutableStringSchema: MutablePrimitiveSchema, StringSchema {
  public var constraints: StringConstraints? {
    return mutableConstraints
  }

  public var mutableConstraints: MutableStringConstraints? = nil

  public override init() {
    super.init()
  }

  public init(constraints: MutableStringConstraints?) {
    mutableConstraints = constraints
  }

  public override func accept(visitor: SchemaVisitor) -> Bool {
    return visitor.visit(string: self)
  }
}

public class MutablePassword1WaySchema: MutableStringSchema, Password1WaySchema {
  public override func accept(visitor: SchemaVisitor) -> Bool {
    return visitor.visit(password1Way: self)
  }
}

public class MutablePassword2WaySchema: MutableStringSchema, Password2WaySchema {
  public override func accept(visitor: SchemaVisitor) -> Bool {
    return visitor.visit(password2Way: self)
  }
}

public class MutableUuidSchema: MutablePrimitiveSchema, UuidSchema {
  public override func accept(visitor: SchemaVisitor) -> Bool {
    return visitor.visit(uuid: self)
  }
}

public class MutableBlobSchema: MutablePrimitiveSchema, BlobSchema {
  public override func accept(visitor: SchemaVisitor) -> Bool {
    return visitor.visit(blob: self)
  }
}

// MARK: - Constraints -

// TODO: refer to multiplicity in FieldSchema
public class MutableMultiplicity: Multiplicity {
  public var min: UInt = 1
  public var max: UInt = 1

  public init() {}

  public init(min: UInt, max: UInt) {
    self.min = min
    self.max = max
  }
}

public class MutableNumericConstraints<T: Numeric>: NumericConstraints {
  public var minBound: MutableNumericBound<T>?
  public var maxBound: MutableNumericBound<T>?

  public init() {}

  public init(minBound: MutableNumericBound<T>? = nil, maxBound: MutableNumericBound<T>? = nil) {
    self.minBound = minBound
    self.maxBound = maxBound
  }
}

public class MutableNumericBound<T: Numeric>: NumericBound {
  public var value: T = 0
  public var inclusive: Bool = false

  public init() {}

  public init(value: T, inclusive: Bool) {
    self.value = value
    self.inclusive = inclusive
  }
}

public class MutableStringConstraints: StringConstraints {
  public var minLength: Int?
  public var maxLength: Int?
  public var regex: String?

  public init() {}

  public init(minLength: Int? = nil, maxLength: Int? = nil, regex: String? = nil) {
    self.minLength = minLength
    self.maxLength = maxLength
    self.regex = regex
  }
}
