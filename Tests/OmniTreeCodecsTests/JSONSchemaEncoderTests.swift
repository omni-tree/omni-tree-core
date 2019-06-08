// Copyright 2019 The OmniTree Authors.

import OmniTreeSchema
import XCTest
@testable import OmniTreeCodecs

final class JSONSchemaEncoderTests: XCTestCase {
  func testPrettyPrintEncoder() {
    let outputMemoryStream = OutputStream.toMemory()
    outputMemoryStream.open()

    let jsonSchemaEncoder = JSONSchemaEncoder(output: outputMemoryStream, prettyPrint: true)

    let schema = getGoldenSwiftSchema()
    _ = jsonSchemaEncoder.encode(schema)

    let encodedSchema = outputMemoryStream.getDataWrittenToMemory().flatMap {
      String(data: $0, encoding: String.Encoding.utf8)
    }
    addAttachment(encodedSchema: encodedSchema)

    XCTAssertEqual(encodedSchema, goldenJsonPrettyPrintedSchema)
  }

  func addAttachment(encodedSchema: String?) {
    // Activities and attachments currently don't work with `swift test`.
    // Using workaround suggested in https://bugs.swift.org/browse/SR-9526
    if !ProcessInfo.processInfo.environment.keys.contains("__XCODE_BUILT_PRODUCTS_DIR_PATHS") {
      return
    }

    if let encodedSchema = encodedSchema {
      let attachment = XCTAttachment(string: encodedSchema)
      attachment.name = "JSONSchemaEncoder output"
      attachment.lifetime = .keepAlways
      add(attachment)
    }
  }

  static var allTests = [
    ("testPrettyPrintEncoder", testPrettyPrintEncoder),
  ]
}
