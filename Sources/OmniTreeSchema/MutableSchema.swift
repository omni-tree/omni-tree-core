// Copyright 2019 The OmniTree Authors.

// Mutable classes for elements of the OmniTree schema.

public class MutableElementSchema: ElementSchema {
  public var name: String = ""
}

// MARK: - User-Defined Types -

public class MutablePackage: MutableElementSchema, Package {
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
}

public class MutableAliasSchema: MutableElementSchema, AliasSchema {
  public var primitive: PrimitiveSchema {
    return mutablePrimitive
  }

  public var mutablePrimitive: MutablePrimitiveSchema = MutablePrimitiveSchema()
}

public class MutableEnumerationSchema: MutableElementSchema, EnumerationSchema {
  public var values: [String] = []
}

public class MutableEntitySchema: MutableElementSchema, EntitySchema {
  public var fields: [FieldSchema] {
    return mutableFields
  }

  public var mutableFields: [MutableFieldSchema] = []
}

// MARK: - Fields -

public class MutableFieldSchema: MutableElementSchema, FieldSchema {}

public class MutablePrimitiveFieldSchema: MutableFieldSchema, PrimitiveFieldSchema {
  public var primitive: PrimitiveSchema {
    return mutablePrimitive
  }

  public var mutablePrimitive: MutablePrimitiveSchema = MutablePrimitiveSchema()
}

public class MutableAliasFieldSchema: MutableFieldSchema, AliasFieldSchema {
  public var alias: AliasSchema {
    return mutableAlias
  }

  public var mutableAlias: MutableAliasSchema = MutableAliasSchema()
}

public class MutableEnumerationFieldSchema: MutableFieldSchema, EnumerationFieldSchema {
  public var enumeration: EnumerationSchema {
    return mutableEnumeration
  }

  public var mutableEnumeration: MutableEnumerationSchema = MutableEnumerationSchema()
}

public class MutableEntityFieldSchema: MutableFieldSchema, EntityFieldSchema {
  public var entity: EntitySchema {
    return mutableEntity
  }

  public var mutableEntity: MutableEntitySchema = MutableEntitySchema()
}

// MARK: - Predefined Primitives -

public class MutablePrimitiveSchema: PrimitiveSchema {}

public class MutableBooleanSchema: MutablePrimitiveSchema, BooleanSchema {}

public class MutableNumericSchema<T: Numeric>: MutablePrimitiveSchema, NumericSchema {
  // TODO: does MutableNumericConstraints<T> leak when this is accessed as NumericSchema?
  public var constraints: MutableNumericConstraints<T> = MutableNumericConstraints<T>()
}

public class MutableStringSchema: MutablePrimitiveSchema, StringSchema {
  public var constraints: StringConstraints {
    return mutableConstraints
  }

  public var mutableConstraints: MutableStringConstraints = MutableStringConstraints()
}

public class MutablePassword1WaySchema: MutableStringSchema, Password1WaySchema {}

public class MutablePassword2WaySchema: MutableStringSchema, Password2WaySchema {}

public class MutableUuidSchema: MutablePrimitiveSchema, UuidSchema {}

public class MutableBlobSchema: MutablePrimitiveSchema, BlobSchema {}

// MARK: - Constraints -

public class MutableMultiplicity: Multiplicity {
  public var min: UInt = 1
  public var max: UInt = 1
}

public class MutableNumericConstraints<T: Numeric>: NumericConstraints {
  public var minValue: MutableNumericBound<T>?
  public var maxValue: MutableNumericBound<T>?
}

public class MutableNumericBound<T: Numeric>: NumericBound {
  public var value: T = 0
  public var inclusive: Bool = false
}

public class MutableStringConstraints: StringConstraints {
  public var minLength: Int?
  public var maxLength: Int?
  public var regexPattern: String?
}
