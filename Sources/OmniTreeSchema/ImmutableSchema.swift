// Immutable protocols and classes for elements of the OmniTree schema.

/// This is the base class for all schema elements. It contains fields that
/// are common to all schema elements.
public protocol ElementSchema {
  var name: String { get }
}

// MARK: - User-Defined Types -

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
}

// MARK: - Predefined Primitives -

/// Schema for primitives.
/// There are subclasses for each type of primitive.
public protocol PrimitiveSchema {}

/// Schema for boolean primitive.
public class BooleanSchema: PrimitiveSchema {}

/// Schema for numeric primitives.
public class NumericSchema<T: Numeric>: PrimitiveSchema {
  var constraints: NumericConstraints<T>

  init(constraints: NumericConstraints<T>) {
    self.constraints = constraints
  }
}

/// Schema for string primitive.
public class StringSchema: PrimitiveSchema {
  var constraints: StringConstraints

  init(constraints: StringConstraints) {
    self.constraints = constraints
  }
}

/// Schema for password primitive that can be encrypted but not decrypted
/// (1-way).
public class Password1WaySchema: StringSchema {}

/// Schema for password primitive that can be encrypted as well as decrypted
/// (2-way).
public class Password2WaySchema: StringSchema {}

/// Schema for UUID fields.
public class UuidSchema: PrimitiveSchema {}

/// Schema for blob primtive that can store binary data.
public class BlobSchema: PrimitiveSchema {}

// TODO: should timestamps be user-defined primitives? It can be user-defined
// if it does not need any special treatment in the frameworks/libraries.
/// Schema for timestamp primitive.
public class TimestampSchema: PrimitiveSchema {}

// MARK: - Constraints -

/// Constraints on the cardinality of a field.
public class Multiplicity {
  let min: UInt = 1
  let max: UInt = 1
}

/// Constraints for numeric fields.
public class NumericConstraints<T> {
  let minValue: NumericBound<T>? = nil
  let maxValue: NumericBound<T>? = nil
}

/// An inclusive/exclusive bound for a numeric field.
public class NumericBound<T> {
  let value: T
  let inclusive: Bool

  init(value: T, inclusive: Bool = false) {
    self.value = value
    self.inclusive = inclusive
  }
}

/// Constraints for string fields.
public class StringConstraints {
  let minLength: Int? = nil
  let maxLength: Int? = nil
  let regexPattern: String? = nil
}
