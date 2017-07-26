/*
   Copyright 2015-2017 Ryuichi Laboratories and the Yanagiba project contributors

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

import Foundation

public extension String {
  public var truncatedPath: String {
    return truncatedPath()
  }

  public func truncatedPath(
    currentDirectoryPath currentDirectory: String = FileManager.default.currentDirectoryPath
  ) -> String {
    // Note: one extra character is truncated after the prefix
    guard hasPrefix(currentDirectory) else {
      return self
    }

    return substring(from: index(startIndex, offsetBy: currentDirectory.count+1))
  }

  public var absolutePath: String {
    return absolutePath()
  }

  public func absolutePath(
    currentDirectoryPath currentDirectory: String = FileManager.default.currentDirectoryPath
  ) -> String {
    if self.hasPrefix("/") {
      return self
    }

    var pathHead = NSString(string: currentDirectory).pathComponents.filter { $0 != "." }
    if pathHead.count > 1 && pathHead.last == "/" {
      pathHead.removeLast()
    }
    var pathTail = NSString(string: self).pathComponents.filter { $0 != "." }
    if pathTail.count > 1 && pathTail.last == "/" {
      pathTail.removeLast()
    }

    while pathTail.first == ".." {
      pathTail.removeFirst()
      if !pathHead.isEmpty {
        pathHead.removeLast()
      }

      if pathHead.isEmpty || pathTail.isEmpty {
        break
      }
    }

    let absolutePath = pathHead.joined(separator: "/") + "/" + pathTail.joined(separator: "/")
    return absolutePath.substring(from: absolutePath.index(after: absolutePath.startIndex))
  }

  public var parentPath: String {
    return parentPath()
  }

  public func parentPath(
    currentDirectoryPath currentDirectory: String = FileManager.default.currentDirectoryPath
  ) -> String {
    var components = absolutePath(currentDirectoryPath: currentDirectory).split(separator: "/")
    components.removeLast()
    return "/" + components.map(String.init).joined(separator: "/")
  }
}
