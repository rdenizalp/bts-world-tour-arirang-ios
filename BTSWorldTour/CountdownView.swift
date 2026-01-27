//
//  CountdownView.swift
//  BTSWorldTour
//
//  Created by Deniz Alp on 25.01.2026.
//
import SwiftUI

struct CountdownView: View {
    let targetDate: Date

    var body: some View {
        TimelineView(.periodic(from: .now, by: 1)) { context in
            let remaining = max(0, Int(targetDate.timeIntervalSince(context.date)))

            let days = remaining / 86400
            let hours = (remaining % 86400) / 3600
            let minutes = (remaining % 3600) / 60
            let seconds = remaining % 60

            HStack(spacing: 10) {
                TimeBlock(value: days, label: "DAYS")
                TimeBlock(value: hours, label: "HRS")
                TimeBlock(value: minutes, label: "MIN")
                TimeBlock(value: seconds, label: "SEC")
            }
            .padding(14)
            .frame(maxWidth: .infinity)
            .background( LinearGradient(
                colors: [
                    Color.red.opacity(0.7),
                    Color.red.opacity(0.5)
                ],
                startPoint: .topLeading,
                endPoint: .bottomLeading
            ))
            .clipShape(RoundedRectangle(cornerRadius: 9))
        }
    }
}

private struct TimeBlock: View {
    let value: Int
    let label: String

    var body: some View {
        VStack(spacing: 2) {
            Text(String(format: "%02d", value))
                .font(.title2)
                .fontWeight(.bold)
                .monospacedDigit()

            Text(label)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    CountdownView(
        targetDate: Calendar.current.date(
            from: DateComponents(year: 2026, month: 7, day: 17)
        )!
    )
    .padding()
}
