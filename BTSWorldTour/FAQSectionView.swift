//
//  FAQSectionView.swift
//  BTSWorldTour
//
//  Created by Deniz Alp on 25.01.2026.
//

import SwiftUI

struct FAQSectionView: View {
    let items: [FAQItem]
    @Binding var expandedIDs: Set<UUID>

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("FREQUENTLY ASKED QUESTIONS")
                .font(.headline)
                .foregroundStyle(.black)
               

            ForEach(items) { item in
                DisclosureGroup(
                    isExpanded: Binding(
                        get: { expandedIDs.contains(item.id) },
                        set: { isOpen in
                            if isOpen {
                                expandedIDs.insert(item.id)
                            } else {
                                expandedIDs.remove(item.id)
                            }
                        }
                    )
                ) {
                    Text(item.answer)
                        .font(.footnote)
                        .foregroundStyle(.primary)
                        .padding(.top, 6)
                } label: {
                    HStack {
                        Text(item.question)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                            .fontWeight(.semibold)
                            .foregroundStyle(.red)
                            Spacer()
                        
                    }
                }
                .tint(.primary)
                .padding(14)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 14))
            }
        }
    }
}

#Preview {
    PreviewWrapper()
}

private struct PreviewWrapper: View {
    @State private var expandedIDs: Set<UUID> = []

    private let previewItems: [FAQItem] = [
        FAQItem(
            question: "How do I sign up for the ARMY MEMBERSHIP PRESALE?",
            answer: "You must be an ARMY MEMBERSHIP holder and register on Weverse before the deadline."
        ),
        FAQItem(
            question: "Is there a presale code?",
            answer: "Your ARMY MEMBERSHIP NUMBER will serve as your presale code."
        ),
        FAQItem(
            question: "How many tickets can I purchase?",
            answer: "You may purchase a maximum of four (4) tickets per show."
        )
    ]

    var body: some View {
        FAQSectionView(items: previewItems, expandedIDs: $expandedIDs)
            .padding()
    }
}
