// Copyright 2019 The OmniTree Authors.

/// Visitor that should be called whenever an object or list starts or ends.
///
/// `name` parameter values will be in snake_case.
public protocol BracketedVisitor {
  func objectStart(name: String)
  func objectEnd()
  func listStart(name: String)
  func listEnd()
}
