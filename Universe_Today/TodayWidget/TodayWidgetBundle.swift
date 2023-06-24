//
//  TodayWidgetBundle.swift
//  TodayWidget
//
//  Created by 원태영 on 2023/06/24.
//

import WidgetKit
import SwiftUI

@main
struct TodayWidgetBundle: WidgetBundle {
    var body: some Widget {
        TodayWidget()
        TodayWidgetLiveActivity()
    }
}
