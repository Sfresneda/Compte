//
//  CompteWidget.swift
//  CompteWidget
//
//  Created by likeadeveloper on 6/6/23.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        let object = CompteObject.defaultImplementation()
        return SimpleEntry(date: Date(),
                           compte: .defaultImplementation(),
                           configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(),
                                compte: .defaultImplementation(),
                                configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate,
                                    compte: .defaultImplementation(),
                                    configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let compte: CompteObject
    let configuration: ConfigurationIntent
}

struct CompteWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        HStack {
            Text(entry.compte.name)
            Text(entry.compte.dateFormatted, style: .date)
            Text(String(entry.compte.taps.count))
        }
    }
}

struct CompteWidget: Widget {
    let kind: String = "CompteWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            CompteWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct CompteWidget_Previews: PreviewProvider {
    static var previews: some View {
        CompteWidgetEntryView(entry: SimpleEntry(date: Date(),
                                                 compte: .defaultImplementation(),
                                                 configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
