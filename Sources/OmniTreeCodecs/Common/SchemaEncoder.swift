// Copyright 2019 The OmniTree Authors.

import OmniTreeSchema

public protocol SchemaEncoder {
  /// - Returns: `false` if entire schema is not encoded.
  func encode(_ element: ElementSchema) -> Bool

  /// - Returns: `false` if entire schema is not encoded.
  func encode(_ elements: [ElementSchema]) -> Bool
}
