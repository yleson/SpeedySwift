//
//  DateExtensions.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation
extension Date {
    
    /// Returns the user’s current calendar.
    var calendar: Calendar {
        return Calendar.current
    }
    
    /// The time zone currently used by the system.
    var timeZone: TimeZone {
        return self.calendar.timeZone
    }
    
    /// Nanoseconds
    var nanosecond: Int {
        return calendar.component(.nanosecond, from: self)
    }
    
    /// Seconds
    var second: Int {
        get {
            return calendar.component(.second, from: self)
        }
        set {
            self = Date(calendar: calendar, timeZone: timeZone, era: era, year: year, month: month, day: day, hour: hour, minute: minute, second: newValue, nanosecond: nanosecond)
        }
    }
    
    /// Minutes
    var minute: Int {
        get {
            return calendar.component(.minute, from: self)
        }
        set {
            self = Date(calendar: calendar, timeZone: timeZone, era: era, year: year, month: month, day: day, hour: hour, minute: newValue, second: second, nanosecond: nanosecond)
        }
    }
    
    /// Hour
    var hour: Int {
        get {
            return calendar.component(.hour, from: self)
        }
        set {
            self = Date(calendar: calendar, timeZone: timeZone, era: era, year: year, month: month, day: day, hour: newValue, minute: minute, second: second, nanosecond: nanosecond)
        }
    }
    
    /// Day
    var day: Int {
        get {
            return calendar.component(.day, from: self)
        }
        set {
            self = Date(calendar: calendar, timeZone: timeZone, era: era, year: year, month: month, day: newValue, hour: hour, minute: minute, second: second, nanosecond: nanosecond)
        }
    }
    
    /// Weekday
    var weekday: Int {
        return calendar.component(.weekday, from: self)
    }
    
    /// A week of the month
    var weekOfMonth: Int {
        return calendar.component(.weekOfMonth, from: self)
    }
    
    /// A week of the year
    var weekOfYear: Int {
        return calendar.component(.weekOfYear, from: self)
    }
    
    /// Month
    var month: Int {
        get {
            return calendar.component(.month, from: self)
        }
        set {
            self = Date(calendar: calendar, timeZone: timeZone, era: era, year: year, month: newValue, day: day, hour: hour, minute: minute, second: newValue, nanosecond: nanosecond)
        }
    }
    
    /// Year
    var year: Int {
        get {
            return calendar.component(.year, from: self)
        }
        set {
            self = Date(calendar: calendar, timeZone: timeZone, era: era, year: newValue, month: month, day: day, hour: hour, minute: minute, second: newValue, nanosecond: nanosecond)
        }
    }
    
    /// Era
    var era: Int {
        return calendar.component(.era, from: self)
    }
    
    /// Quarter
    var quarter: Int {
        return calendar.component(.quarter, from: self)
    }
    
    /// Return true if date is in today
    var isInToday: Bool {
        return self.day == Date().day && self.month == Date().month && self.year == Date().year
    }
    
    /// Add calendar components to date
    mutating func add(component: Calendar.Component, value: Int) {
        switch component {
            
        case .second:
            self = calendar.date(byAdding: .second, value: value, to: self) ?? self
            break
            
        case .minute:
            self = calendar.date(byAdding: .minute, value: value, to: self) ?? self
            break
            
        case .hour:
            self = calendar.date(byAdding: .hour, value: value, to: self) ?? self
            break
            
        case .day:
            self = calendar.date(byAdding: .day, value: value, to: self) ?? self
            break
            
        case .weekOfYear, .weekOfMonth:
            self = calendar.date(byAdding: .day, value: value * 7, to: self) ?? self
            break
            
        case .month:
            self = calendar.date(byAdding: .month, value: value, to: self) ?? self
            break
            
        case .year:
            self = calendar.date(byAdding: .year, value: value, to: self) ?? self
            break
            
        default:
            break
        }
    }
    
    /// Return beginning of given date component
    func beginning(of component: Calendar.Component) -> Date {
        
        switch component {
            
        case .second:
            return calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)) ?? self
            
        case .minute:
            return calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self)) ?? self
            
        case .hour:
            return calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour], from: self)) ?? self
            
        case .day:
            return self.calendar.startOfDay(for: self)
            
        case .weekOfYear, .weekOfMonth:
            return calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) ?? self
            
        case .month:
            return calendar.date(from: calendar.dateComponents([.year, .month], from: self)) ?? self
            
        case .year:
            return calendar.date(from: calendar.dateComponents([.year], from: self)) ?? self
            
        default:
            return self
        }
    }
    
    /// Create a new Date
    init(calendar: Calendar?, timeZone: TimeZone?, era: Int?, year: Int?, month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?, nanosecond: Int?) {
        
        let calendar = calendar ?? Calendar.current
        let timeZone = timeZone ?? TimeZone.current
        let era = era ?? Date().era
        let year = year ?? Date().year
        let month = month ?? Date().month
        let day = day ?? Date().day
        let hour = hour ?? Date().hour
        let minute = minute ?? Date().minute
        let second = second ?? Date().second
        let nanosecond = nanosecond ?? Date().nanosecond
        
        let components = DateComponents(calendar: calendar, timeZone: timeZone, era: era, year: year, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
        
        self = calendar.date(from: components) ?? Date()
    }
}