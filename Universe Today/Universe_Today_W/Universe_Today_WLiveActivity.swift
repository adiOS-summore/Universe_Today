//
//  Universe_Today_WLiveActivity.swift
//  Universe_Today_W
//
//  Created by Ruyha on 6/24/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct Universe_Today_WAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct Universe_Today_WLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: Universe_Today_WAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension Universe_Today_WAttributes {
    fileprivate static var preview: Universe_Today_WAttributes {
        Universe_Today_WAttributes(name: "World")
    }
}

extension Universe_Today_WAttributes.ContentState {
    fileprivate static var smiley: Universe_Today_WAttributes.ContentState {
        Universe_Today_WAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: Universe_Today_WAttributes.ContentState {
         Universe_Today_WAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: Universe_Today_WAttributes.preview) {
   Universe_Today_WLiveActivity()
} contentStates: {
    Universe_Today_WAttributes.ContentState.smiley
    Universe_Today_WAttributes.ContentState.starEyes
}
