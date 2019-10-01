//
//  TestUtilities.swift
//  SharedComponents
//
//  Created by Alessandro Manni on 29/09/2019.
//

public class TestUtilities {
  
  enum TestUtilitiesErrors: Error {
    case bundleNotFound
  }

  public static func loadJSONFile(_ fileName: String, inBundle bundle: Bundle) throws -> Data {
    guard let path = bundle.path(forResource: fileName, ofType: "json") else {
      throw TestUtilitiesErrors.bundleNotFound
    }
    return try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
  }

  public static func prettyPrint(with json: [String: Any]) -> String {
    let data = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
    return (string ?? "Invalid json format") as String
  }
}
