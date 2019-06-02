// Copyright 2019 The OmniTree Authors.

/// Wire-format encoder.
///
/// `name` parameter values will be in snake_case.
public protocol WireFormatEncoder {
  func encodeObjectStart(name: String?)
  func encodeObjectEnd()
  func encodeListStart(name: String?)
  func encodeListEnd()
  func encodeStringField(name: String, value: String)
}
