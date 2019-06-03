// Copyright 2019 The OmniTree Authors.

/// A generic stack data-structure.
public class Stack<T> {
  var items = [T]()

  func push(_ item: T) {
    items.append(item)
  }

  @discardableResult func pop() -> T {
    return items.removeLast()
  }

  /// Returns the item at the top without removing it from the stack.
  func peek() -> T? {
    return items.last
  }
}
