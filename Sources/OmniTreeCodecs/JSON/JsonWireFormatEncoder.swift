// Copyright 2019 The OmniTree Authors.

import Foundation

public class JsonWireFormatEncoder: WireFormatEncoder {
  private let output: OutputStream
  private let prettyPrint: PrettyPrintHelper

  init(output: OutputStream, prettyPrint: Bool = false, indentSizeInSpaces: Int = 2) {
    self.output = output
    self.prettyPrint = PrettyPrintHelper(prettyPrint: prettyPrint, indentSizeInSpaces: indentSizeInSpaces)
  }

  private func open(name: String?, brace: String) {
    output.write(prettyPrint.currentIndent)
    if let name = name {
      output.write("\"\(name)\": ")
    }
    output.write(brace)
    output.write(prettyPrint.endOfLine)
    prettyPrint.indent()
  }

  private func close(brace: String) {
    prettyPrint.unindent()
    output.write(prettyPrint.currentIndent)
    output.write(brace)
    output.write(",")
    output.write(prettyPrint.endOfLine)
  }

  // MARK: - WireFormatEncoder Methods -

  public func encodeObjectStart(name: String?) {
    open(name: name, brace: "{")
  }

  public func encodeObjectEnd() {
    close(brace: "}")
  }

  public func encodeListStart(name: String?) {
    open(name: name, brace: "[")
  }

  public func encodeListEnd() {
    close(brace: "]")
  }

  public func encodeStringField(name: String, value: String) {
    output.write(prettyPrint.currentIndent)
    output.write("\"\(name)\": \"\(value)\",")
    output.write(prettyPrint.endOfLine)
  }
}
