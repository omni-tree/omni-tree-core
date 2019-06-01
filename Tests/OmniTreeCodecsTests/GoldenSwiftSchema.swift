// Copyright 2019 The OmniTree Authors.

import OmniTreeSchema

func getGoldenSwiftSchema() -> PackageSchema {
  return MutablePackageSchema(
    name: "test_package",
    entities: [
      MutableEntitySchema(
        name: "entity1",
        fields: [
          MutablePrimitiveFieldSchema(
            name: "primitive_field",
            primitive: MutableStringSchema()
          ),
        ]
      ),
      MutableEntitySchema(name: "entity2", fields: []),
      MutableEntitySchema(name: "entity3", fields: []),
    ]
  )
}
