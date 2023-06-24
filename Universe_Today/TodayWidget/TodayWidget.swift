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
    let images: [String]
    
    init(images: [String]) {
        self.images = images
    }
}

let images: [String] = [
    
]

struct Provider: IntentTimelineProvider {
    
    let catImages: [CatImages] = [
        .init(images: [
            "runCat1",
            "runCat2",
            "runCat3",
            "runCat4",
            "runCat5",
            "runCat6",
            "runCat7"
        ]),
        .init(images: [
            "cat1",
            "cat2"
        ])
    ]
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(),
                    imageURL: "runCat1")
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(),
                                imageURL:"runCat2")
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
        let selectedCatImages = catImages[configuration.CatName?.intValue ?? 0]
        for hourOffset in 1 ..< 3600 {
            let entryDate = Calendar.current.date(
                byAdding: .second,
                value: hourOffset,
                to: currentDate)!
            let entry = SimpleEntry(
                date: entryDate,
                imageURL: selectedCatImages.images[hourOffset % selectedCatImages.images.count]
            )
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
            VStack {
                Image(entry.imageURL)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
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
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
