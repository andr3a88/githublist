//
//  Extensions.swift
//  GitHubList
//
//  Created by Andrea on 13/05/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit

extension Date {
    
    /**
     Get a date object from a String
     
     - parameter dateString: The date in string format (31-12-2016)
     - parameter dateFormat: The date format (dd-mm-yyyy)
     
     - returns: The date
     */
    static func fromString(_ dateString: String, dateFormat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        guard let date = dateFormatter.date(from: dateString) else { return nil }
        return date
    }
}
