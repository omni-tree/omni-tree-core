// Copyright 2019 The OmniTree Authors.

import OmniTreeSchema
import XCTest
@testable import OmniTreeCodecs

final class JsonWireFormatEncoderTests: XCTestCase {
  func testPrettyPrintEncoder() {
    let outputMemoryStream = OutputStream.toMemory()
    outputMemoryStream.open()
    let jsonFormatEncoder = JsonWireFormatEncoder(output: outputMemoryStream, prettyPrint: true)
    let encoder = SchemaEncoder(wireFormatEncoder: jsonFormatEncoder)

    let schema = getGoldenSwiftSchema()
    _ = schema.accept(visitor: encoder)

    let encodedSchema = outputMemoryStream.getDataWrittenToMemory().flatMap {
      String(data: $0, encoding: String.Encoding.utf8)
    }
    addAttachment(encodedSchema: encodedSchema)

    XCTAssertEqual(encodedSchema, goldenJsonPrettyPrintedSchema)
  }

  func addAttachment(encodedSchema: String?) {
    if let encodedSchema = encodedSchema {
      let attachment = XCTAttachment(string: encodedSchema)
      attachment.name = "JsonWireFormatEncoder output"
      attachment.lifetime = .keepAlways
      add(attachment)
    }
  }

  static var allTests = [
    ("testPrettyPrintEncoder", testPrettyPrintEncoder),
  ]
}
