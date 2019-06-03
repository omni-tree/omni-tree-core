// Copyright 2019 The OmniTree Authors.

import Foundation
import OmniTreeSchema

public final class JSONSchemaEncoder: SchemaEncoder {
  private let wireFormatEncoder: JSONWireFormatEncoder
  private let encodingVisitor: SchemaEncodingVisitor

  public init(output: OutputStream, prettyPrint: Bool = false, indentSizeInSpaces: Int = 2) {
    wireFormatEncoder = JSONWireFormatEncoder(output: output, prettyPrint: prettyPrint, indentSizeInSpaces: indentSizeInSpaces)
    encodingVisitor = SchemaEncodingVisitor(wireFormatEncoder: wireFormatEncoder)
  }

  // MARK: - SchemaEncoder Methods -

  public func encode(_ element: ElementSchema) -> Bool {
    wireFormatEncoder.encodeObjectStart(name: nil)
    let completed = element.accept(visitor: encodingVisitor)
    wireFormatEncoder.encodeObjectEnd()
    return completed
  }

  public func encode(_ elements: [ElementSchema]) -> Bool {
    wireFormatEncoder.encodeListStart(name: nil)
    let completed = elements.allSatisfy { encode($0) }
    wireFormatEncoder.encodeListEnd()
    return completed
  }
}
