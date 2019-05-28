// Copyright 2019 The OmniTree Authors.

public class PrettyPrintHelper {
  private let prettyPrint: Bool
  private let indentSizeInSpaces: Int
  private(set) var currentIndent: String
  private(set) var endOfLine: String

  init(prettyPrint: Bool, indentSizeInSpaces: Int = 2) {
    self.prettyPrint = prettyPrint
    self.indentSizeInSpaces = indentSizeInSpaces
    currentIndent = ""
    endOfLine = prettyPrint ? "\n" : ""
  }

  public func indent() {
    if prettyPrint {
      let newIndent = currentIndent.count + indentSizeInSpaces
      currentIndent = String(repeating: " ", count: newIndent)
    }
  }

  public func unindent() {
    if prettyPrint {
      let newIndent = currentIndent.count - indentSizeInSpaces
      currentIndent = String(repeating: " ", count: newIndent)
    }
  }
}
