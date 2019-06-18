// Copyright 2019 The OmniTree Authors.

import Foundation

private enum NestingState {
  case objectStart, objectElement
  case listStart, listElement
}

public class JSONWireFormatEncoder: WireFormatEncoder {
  private let output: OutputStream
  private let prettyPrint: PrettyPrintHelper
  private let nesting = Stack<NestingState>()

  init(output: OutputStream, prettyPrint: Bool = false, indentSizeInSpaces: Int = 2) {
    self.output = output
    self.prettyPrint = PrettyPrintHelper(prettyPrint: prettyPrint, indentSizeInSpaces: indentSizeInSpaces)
  }

  private func encodeNameValue(name: String?, value: String) {
    switch nesting.peek() {
    case .objectStart:
      output.write(prettyPrint.endOfLine)
      prettyPrint.indent()
      output.write(prettyPrint.currentIndent)
      assert(name != nil)
      output.write("\"\(name ?? "")\": \(value)")
    case .objectElement:
      output.write(",")
      output.write(prettyPrint.endOfLine)
      output.write(prettyPrint.currentIndent)
      assert(name != nil)
      output.write("\"\(name ?? "")\": \(value)")
    case .listStart:
      output.write(prettyPrint.endOfLine)
      prettyPrint.indent()
      output.write(prettyPrint.currentIndent)
      output.write(value)
    case .listElement:
      output.write(",")
      output.write(prettyPrint.endOfLine)
      output.write(prettyPrint.currentIndent)
      output.write(value)
    case .none:
      assert(prettyPrint.currentIndent == "")
      output.write(value)
    }
  }

  private func elementEncoded() {
    switch nesting.peek() {
    case .objectStart:
      nesting.push(.objectElement)
    case .objectElement:
      break
    case .listStart:
      nesting.push(.listElement)
    case .listElement:
      break
    case .none:
      break
    }
  }

  // MARK: - WireFormatEncoder Methods -

  public func encodeObjectStart(name: String?) {
    encodeNameValue(name: name, value: "{")
    nesting.push(.objectStart)
  }

  public func encodeObjectEnd() {
    switch nesting.peek() {
    case .objectStart:
      output.write("}")
      nesting.pop()
      elementEncoded()
    case .objectElement:
      output.write(prettyPrint.endOfLine)
      prettyPrint.unindent()
      output.write(prettyPrint.currentIndent)
      output.write("}")
      nesting.pop() // remove objectElement
      assert(nesting.peek() == .objectStart)
      nesting.pop() // remove objectStart
      elementEncoded()
    case .listStart:
      assertionFailure("End of JSON object instead of end of JSON list")
    case .listElement:
      assertionFailure("End of JSON object instead of end of JSON list")
    case .none:
      assertionFailure("End of JSON object without start of JSON object")
    }
  }

  public func encodeListStart(name: String?) {
    encodeNameValue(name: name, value: "[")
    nesting.push(.listStart)
  }

  public func encodeListEnd() {
    switch nesting.peek() {
    case .objectStart:
      assertionFailure("End of JSON list instead of end of JSON object")
    case .objectElement:
      assertionFailure("End of JSON list instead of end of JSON object")
    case .listStart:
      output.write("]")
      nesting.pop()
      elementEncoded()
    case .listElement:
      output.write(prettyPrint.endOfLine)
      prettyPrint.unindent()
      output.write(prettyPrint.currentIndent)
      output.write("]")
      nesting.pop() // remove listElement
      assert(nesting.peek() == .listStart)
      nesting.pop() // remove listStart
      elementEncoded()
    case .none:
      assertionFailure("End of JSON list without start of JSON list")
    }
  }

  public func encodeStringField(name: String, value: String) {
    encodeNameValue(name: name, value: "\"\(value)\"")
    elementEncoded()
  }

  public func encodeNumericField<T>(name: String, value: T) where T : Numeric {
    encodeNameValue(name: name, value: String(describing: value))
    elementEncoded()
  }

  public func encodeBooleanField(name: String, value: Bool) {
    encodeNameValue(name: name, value: value ? "true" : "false")
    elementEncoded()
  }
}
