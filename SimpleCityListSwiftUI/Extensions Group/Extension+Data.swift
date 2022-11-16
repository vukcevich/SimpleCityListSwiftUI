//
//  Extension+Data.swift
//  SimpleCityListSwiftUI
//
//  Created by MARIJAN VUKCEVICH on 11/16/22.
//

import Foundation

//Extension for to make Pretty json String
extension Data {
    var prettyjsonString: NSString? { // NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
