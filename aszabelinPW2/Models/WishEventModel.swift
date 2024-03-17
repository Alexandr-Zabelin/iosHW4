//
//  WishEventModel.swift
//  aszabelinPW2
//
//  Created by Забелин Александр Сергеевич on 17.03.2024.
//

import Foundation

public class WishEventModel {
    var title: String
    var description: String
    var startDate: Date
    var endDate: Date
    
    init(title: String, description: String, startDate: Date, endDate: Date) {
        self.title = title
        self.description = description
        self.startDate = startDate
        self.endDate = endDate
        }
}
