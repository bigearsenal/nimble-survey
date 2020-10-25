//
//  Date+Extensions.swift
//  nimble
//
//  Created by Chung Tran on 10/25/20.
//

import Foundation

extension Date {
    static func ISO8601(string: String?) -> Date? {
        guard let string = string?.replacingOccurrences(of: "\\.\\d+", with: "", options: .regularExpression) else {
            return nil
        }
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: string)
    }
    
    func dayDifference() -> String
    {
        let calendar = Calendar.current
        if calendar.isDateInYesterday(self) { return "Yesterday" }
        else if calendar.isDateInToday(self) { return "Today" }
        else if calendar.isDateInTomorrow(self) { return "Tomorrow" }
        else {
            let startOfNow = calendar.startOfDay(for: Date())
            let startOfTimeStamp = calendar.startOfDay(for: self)
            let components = calendar.dateComponents([.day], from: startOfNow, to: startOfTimeStamp)
            let day = components.day!
            if day < 1 { return "\(-day) days ago" }
            else { return "In \(day) days" }
        }
    }
}
