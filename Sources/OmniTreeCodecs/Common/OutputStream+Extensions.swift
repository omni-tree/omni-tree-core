// Copyright 2019 The OmniTree Authors.

import Foundation

extension OutputStream {
  public func write(_ string: String) {
    if string == "" { return }
    write(string, maxLength: string.utf8.count)
    // TODO: handle the case where the bytes written (return value above) is
    // less than data.count.
  }

  public func getDataWrittenToMemory() -> Data? {
    let nsData = property(forKey: .dataWrittenToMemoryStreamKey) as! NSData?
    return nsData.map { Data(referencing: $0) }
  }
}
