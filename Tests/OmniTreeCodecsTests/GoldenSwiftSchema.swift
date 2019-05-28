// Copyright 2019 The OmniTree Authors.

import OmniTreeSchema

func getGoldenSwiftSchema() -> PackageSchema {
  let package = MutablePackageSchema()
  package.name = "test_package"
  return package
}
