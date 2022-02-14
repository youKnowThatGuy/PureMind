//
//  DateValueFormatter.swift
//  PureMind
//
//  Created by Клим on 17.08.2021.
//

import Foundation
import Charts

public class DateValueFormatter: NSObject, IAxisValueFormatter {
    private let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        //dateFormatter.dateFormat = "dd MMM HH:mm"
        dateFormatter.dateFormat = "EEE"
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}
