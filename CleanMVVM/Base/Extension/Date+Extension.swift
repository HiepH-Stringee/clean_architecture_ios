//
//  Date+Extension.swift
//  CleanMVVM
//
//  Created by Hiệp Hoàng on 19/05/2023.
//

import Foundation

extension Date {
    static func now() -> Date { .init() }

    func string(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    static func dateFormatString(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }

    func duration(date: Date) -> String {
        let timeInterval = self.timeIntervalSince1970 - date.timeIntervalSince1970
        if Int(timeInterval.rounded()) / 31_536_000 >= 1 {
            return String(format: "%d years", Int(timeInterval.rounded()) / 31_536_000)
        } else if Int(timeInterval.rounded()) / 2_592_000 >= 1 {
            return String(format: "%d months", Int(timeInterval.rounded()) / 2_592_000)
        } else if Int(timeInterval.rounded()) / 604_800 >= 1 {
            return String(format: "%d weaks", Int(timeInterval.rounded()) / 604_800)
        } else if Int(timeInterval.rounded()) / 86_400 >= 1 {
            return String(format: "%d days", Int(timeInterval.rounded()) / 86_400)
        } else if Int(timeInterval.rounded()) / 3_600 >= 1 {
            return String(format: "%d hours", Int(timeInterval.rounded()) / 3_600)
        } else if Int(timeInterval.rounded()) / 60 >= 1 {
            return String(format: "%d minutes", Int(timeInterval.rounded()) / 60)
        } else {
            return String(format: "%d seconds", Int(timeInterval.rounded()) % 60)
        }
    }
}
