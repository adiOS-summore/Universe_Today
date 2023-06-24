//
//  TodayWidget.swift
//  TodayWidget
//
//  Created by 원태영 on 2023/06/24.
//

import WidgetKit
import SwiftUI
import Intents

struct CatImages {
    let images: [String] = [
        "pop-cat-1",
        "pop-cat-2"
    ]
}


struct Provider: IntentTimelineProvider {
    
    let catImages: CatImages = .init()
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(),
                    imageURL: catImages.images.randomElement()!)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(),
                                imageURL: catImages.images.randomElement()!)
        completion(entry)
    }

    func getTimeline(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (Timeline<Entry>) -> ()
    ) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 60 {
            let entryDate = Calendar.current.date(
                byAdding: .second,
                value: hourOffset,
                to: currentDate)!
            let entry = SimpleEntry(date: entryDate,
                                    imageURL: catImages.images[hourOffset % 2])
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    
    let imageURL: String
}

struct TodayWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        
        VStack {
            /*
            AsyncImage(url: URL(string: entry.imageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            } placeholder: {
                Image(systemName: "plus")
                
            }
             */
            
            Image(entry.imageURL)
                .resizable()
                .aspectRatio(contentMode: .fill)
            
        }
    }
}

struct TodayWidget: Widget {
    let kind: String = "TodayWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind,
            intent: ConfigurationIntent.self,
            provider: Provider()
        ) { entry in
            TodayWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}
