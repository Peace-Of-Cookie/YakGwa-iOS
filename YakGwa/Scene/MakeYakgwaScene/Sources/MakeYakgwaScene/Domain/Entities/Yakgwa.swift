//
//  Yakgwa.swift
//
//
//  Created by Ekko on 6/4/24.
//

import Foundation

/// 약속 엔터티
struct Yakgwa {
    var yakgwaTitle: String?
    var yakgwaDescription: String?
    var yakgwaTheme: String?
    var alreadySelectedLocation: Bool = false
    var yakgwaLocation: [String] = []
    var alreadySelectedDate: Bool = false
    var yakgwaStartDate: Date?
    var yakgwaEndDate: Date?
    var yakgwaStartTime: Date?
    var yakgwaEndTime: Date?
    var expiredDate: Date?
}