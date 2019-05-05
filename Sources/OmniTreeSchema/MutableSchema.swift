// Copyright 2019 The OmniTree Authors.

// Mutable classes for elements of the OmniTree schema.

public class MutableElementSchema: ElementSchema {
  public var name: String

  init(name: String) {
    self.name = name
  }
}

// MARK: - User-Defined Types -

public class MutablePackage: MutableElementSchema, Package {
  public var aliases: [AliasSchema] {
    get {
      return mutableAliases
    }
  }
  public var enumerations: [EnumerationSchema] {
    get {
      return mutableEnumerations
    }
  }
  public var entities: [EntitySchema] {
    get {
      return mutableEntities
    }
  }

  public var mutableAliases: [MutableAliasSchema]
  public var mutableEnumerations: [MutableEnumerationSchema]
  public var mutableEntities: [MutableEntitySchema]

  init(name: String, aliases: [MutableAliasSchema], enumerations: [MutableEnumerationSchema], entities: [MutableEntitySchema]) {
    self.mutableAliases = aliases
    self.mutableEnumerations = enumerations
    self.mutableEntities = entities
    super.init(name: name)
  }
}

public class MutableAliasSchema: MutableElementSchema, AliasSchema {
  public var primitive: PrimitiveSchema {
    get {
      return mutablePrimitive
    }
  }

  public var mutablePrimitive: MutablePrimitiveSchema

  init(name: String, primitive: MutablePrimitiveSchema) {
    self.mutablePrimitive = primitive
    super.init(name: name)
  }
}

public class MutableEnumerationSchema: MutableElementSchema, EnumerationSchema {
  public var values: [String]

  init(name: String, values: [String]) {
    self.values = values
    super.init(name: name)
  }
}

public class MutableEntitySchema: MutableElementSchema, EntitySchema {
  public var fields: [FieldSchema] {
    get {
      return mutableFields
    }
  }

  public var mutableFields: [MutableFieldSchema]

  init(name: String, fields: [MutableFieldSchema]) {
    self.mutableFields = fields
    super.init(name: name)
  }
}

// MARK: - Fields -

public class MutableFieldSchema: MutableElementSchema, FieldSchema {
}

public class MutablePrimitiveFieldSchema: MutableFieldSchema, PrimitiveFieldSchema {
  public var primitive: PrimitiveSchema {
    get {
      return mutablePrimitive
    }
  }

  public var mutablePrimitive: MutablePrimitiveSchema

  init(name: String, primitive: MutablePrimitiveSchema) {
    self.mutablePrimitive = primitive
    super.init(name: name)
  }
}

public class MutableAliasFieldSchema: MutableFieldSchema, AliasFieldSchema {
  public var alias: AliasSchema {
    get {
      return mutableAlias
    }
  }

  public var mutableAlias: MutableAliasSchema

  init(name: String, alias: MutableAliasSchema) {
    self.mutableAlias = alias
    super.init(name: name)
  }
}

public class MutableEnumerationFieldSchema: MutableFieldSchema, EnumerationFieldSchema {
  public var enumeration: EnumerationSchema {
    get {
      return mutableEnumeration
    }
  }

  public var mutableEnumeration: MutableEnumerationSchema

  init(name: String, enumeration: MutableEnumerationSchema) {
    self.mutableEnumeration = enumeration
    super.init(name: name)
  }
}

public class MutableEntityFieldSchema: MutableFieldSchema, EntityFieldSchema {
  public var entity: EntitySchema {
    get {
      return mutableEntity
    }
  }

  public var mutableEntity: MutableEntitySchema

  init(name: String, entity: MutableEntitySchema) {
    self.mutableEntity = entity
    super.init(name: name)
  }
}

// MARK: - Predefined Primitives -

public class MutablePrimitiveSchema: PrimitiveSchema {}

public class MutableBooleanSchema: MutablePrimitiveSchema, BooleanSchema {}

public class MutableNumericSchema<T: Numeric>: MutablePrimitiveSchema, NumericSchema {
  // TODO: does MutableNumericConstraints<T> leak when this is accessed as NumericSchema?
  public var constraints: MutableNumericConstraints<T>

  init(constraints: MutableNumericConstraints<T>) {
    self.constraints = constraints
  }
}

public class MutableStringSchema: MutablePrimitiveSchema, StringSchema {
  public var constraints: StringConstraints {
    get {
      return mutableConstraints
    }
  }

  public var mutableConstraints: MutableStringConstraints

  init(constraints: MutableStringConstraints) {
    self.mutableConstraints = constraints
  }
}

public class MutablePassword1WaySchema: MutableStringSchema, Password1WaySchema {
}

public class MutablePassword2WaySchema: MutableStringSchema, Password2WaySchema {
}

public class MutableUuidSchema: MutablePrimitiveSchema, UuidSchema {
}

public class MutableBlobSchema: MutablePrimitiveSchema, BlobSchema {
}

// MARK: - Constraints -

public class MutableMultiplicity: Multiplicity {
  public var min: UInt = 1
  public var max: UInt = 1
}

public class MutableNumericConstraints<T: Numeric>: NumericConstraints {
  public var minValue: MutableNumericBound<T>? = nil
  public var maxValue: MutableNumericBound<T>? = nil
}

public class MutableNumericBound<T: Numeric>: NumericBound {
  public var value: T
  public var inclusive: Bool

  init(value: T, inclusive: Bool = false) {
    self.value = value
    self.inclusive = inclusive
  }
}

public class MutableStringConstraints: StringConstraints {
  public var minLength: Int? = nil
  public var maxLength: Int? = nil
  public var regexPattern: String? = nil
}
