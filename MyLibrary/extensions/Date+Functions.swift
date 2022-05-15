//
//  Date+Functions.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 15/5/22.
//

import Foundation

extension Date {
    func toString(_ format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension String {
    func formatDate(with formatSoruce: String = "yyyy-MM-dd", formatReturn: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formatSoruce
        guard let date = formatter.date(from: self) else {
            return ""
        }
        formatter.dateFormat = formatReturn
        return formatter.string(from: date)
    }
}
