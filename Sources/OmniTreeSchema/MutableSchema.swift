// Mutable classes for elements of the OmniTree schema.

/*
public class MutableElementSchema: ElementSchema {
  public var name: String

  init(name: String) {
    self.name = name
  }
}

public class MutableFieldSchema: MutableElementSchema, FieldSchema {
  public var type: String

  init(name: String, type: String) {
    self.type = type
    super.init(name: name)
  }
}

public class MutableEntitySchema: MutableElementSchema, EntitySchema {
  public var fields: [String: FieldSchema] {
    get {
      return mutableFields
    }
  }
  public var mutableFields: [String: MutableFieldSchema] = [:]
}
*/
