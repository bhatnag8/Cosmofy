//
//  ChangeLogView.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 5/21/24.
//

import SwiftUI

struct ChangelogView: View {
    var body: some View {
        let photo = Photo(image: Image("app-icon-4k"), caption: "Check out Cosomfy's June 2024 Update")
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Text("Version 1.1")
                            .font(Font.custom("SF Pro Rounded Medium", size: 20))

                        Spacer()
                    }
                    .padding([.top, .horizontal])
                    
                    HStack {
                        Text("June")
                            .font(Font.custom("SF Pro Rounded Bold", size: 34))
                        Text("2024")
                            .font(Font.custom("SF Pro Rounded Bold", size: 34))
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                    .padding(.horizontal)

                    
                    ZStack {
                        Color.indigo
                        VStack() {
                            HStack {
                                Text("Each update is accompanied with:")
                                    .foregroundStyle(.white)
                                    .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                    .padding([.top, .horizontal])
                                Spacer()
                            }
                            
                            HStack {
                                Image(systemName: "1.circle.fill")
                                    .font(.title3)
                                    .foregroundStyle(.white)
                                Text("an image associated with the update")
                                    .foregroundStyle(.white)
                                    .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 2)
                            
                            HStack {
                                Image(systemName: "2.circle.fill")
                                    .font(.title3)
                                    .foregroundStyle(.white)
                                Text("list of new features")
                                    .foregroundStyle(.white)
                                    .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 2)
                            
                            HStack {
                                Image(systemName: "3.circle.fill")
                                    .font(.title3)
                                    .foregroundStyle(.white)
                                Text("list of deprecated features")
                                    .foregroundStyle(.white)
                                    .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 2)
                            
                            HStack {
                                Image(systemName: "4.circle.fill")
                                    .font(.title3)
                                    .foregroundStyle(.white)
                                Text("list of bug fixes")
                                    .foregroundStyle(.white)
                                    .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 2)
                            
                            HStack {
                                Image(systemName: "5.circle.fill")
                                    .font(.title3)
                                    .foregroundStyle(.white)
                                Text("some interesting statistics")
                                    .foregroundStyle(.white)
                                    .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 2)
                            .padding(.bottom, 16)
                        }
                    }

                    HStack {
                        Text("Stats")
                            .font(Font.custom("SF Pro Rounded Regular", size: 15))
                            .textCase(.uppercase)
                            .padding([.top, .horizontal])
                            .padding(.bottom, 2)
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                    
                    ActivityView()
                        .padding(.bottom, 2)
                    
                    Divider()

                    TagsView()
                        .padding(.bottom)
   
                }
            }
            .navigationBarItems(
                trailing: ShareLink(item: URL(string: "https://apps.apple.com/app/cosmofy/id6450969556")!, preview: SharePreview("Cosmofy on the Apple App Store", image: Image("iconApp")))
    )
        }
    }
}

struct Photo: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \.image)
    }

    public var image: Image
    public var caption: String
}

#Preview {
    TabBarView()
}



struct ActivityView: View {
    @State private var trigger: Bool = false

    
    var body: some View {
        VStack() {

            HStack(alignment: .firstTextBaseline) {
                GarenText(text: "497", trigger: trigger)
                    .font(Font.system(size: 44, weight: .bold, design: .monospaced))
                Text("files changed")
                    .font(Font.custom("SF Pro Rounded Semibold", size: 24))
                Spacer()
            }
            
            HStack(alignment: .firstTextBaseline) {
                GarenText(text: "4434", trigger: trigger)
                    .font(Font.system(size: 44, weight: .bold, design: .monospaced))

                    .foregroundStyle(.green)
                Text("lines added")
                    .font(Font.custom("SF Pro Rounded Semibold", size: 24))
                Spacer()
            }
            
            HStack(alignment: .firstTextBaseline) {
                GarenText(text: "12850", trigger: trigger)
                    .font(Font.system(size: 44, weight: .bold, design: .monospaced))
                    .foregroundStyle(.red)
                Text("lines deleted")
                    .font(Font.custom("SF Pro Rounded Semibold", size: 24))
                Spacer()
            }
            
            Spacer(minLength: 20)

            
            
            HStack {
                VStack(spacing: 10) {
                    Text("February")
                        .font(.subheadline)
                    
                    ForEach(0..<5) { row in
                        HStack(spacing: 10) {
                            ForEach(0..<7) { col in
                                if (row == 0 && (col < 4)) || (row == 4 && (col == 5 || col == 6)) {
                                    Circle()
                                        .fill(Color(.BETRAY))
                                        .frame(width: 15, height: 15)
                                } else if (row == 3 && (col == 3 || col == 5)) {
                                    Circle()
                                        .fill(.blue)
                                        .frame(width: 15, height: 15)
                                } else {
                                    Circle()
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(width: 15, height: 15)
                                }
                                
                            }
                        }
                    }
                }
                Spacer()
                VStack(spacing: 10) {
                    Text("March")
                        .font(.subheadline)
                    ForEach(0..<5) { row in
                        HStack(spacing: 10) {
                            ForEach(0..<7) { col in
                                if (row == 0 && (col < 5)) || (row == 4 && (col > 0)) {
                                    Circle()
                                        .fill(Color(.BETRAY))
                                        .frame(width: 15, height: 15)
                                } else if (row == 2 && (col == 2 || col == 3 || col == 4 || col == 5)) || ((row == 3 || row == 4) && (col == 0)) {
                                    Circle()
                                        .fill(.green)
                                        .frame(width: 15, height: 15)
                                } else if (row == 3 && (col == 2 || col == 3)) {
                                        Circle()
                                            .fill(.blue)
                                            .frame(width: 15, height: 15)
                                } else {
                                    Circle()
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(width: 15, height: 15)
                                }
                                
                            }
                        }
                    }
                }
            }
            Spacer(minLength: 24)
            
            HStack {
                VStack(spacing: 10) {
                    Text("April")
                        .font(.subheadline)
                    ForEach(0..<5) { row in
                        HStack(spacing: 10) {
                            ForEach(0..<7) { col in
                                if (row == 0 && (col == 0)) || (row == 4 && (col > 2)) {
                                    Circle()
                                        .fill(Color(.BETRAY))
                                        .frame(width: 15, height: 15)
                                } else if (row == 0 && (col == 2 || col == 4)) || (row == 1 && col == 1) {
                                    Circle()
                                        .fill(.blue)
                                        .frame(width: 15, height: 15)
                                } else {
                                    Circle()
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(width: 15, height: 15)
                                }
                                
                            }
                        }
                    }
                }
                Spacer()
                VStack(spacing: 10) {
                    Text("May")
                        .font(.subheadline)
                    ForEach(0..<5) { row in
                        HStack(spacing: 10) {
                            ForEach(0..<7) { col in
                                if (row == 0 && (col < 3)) || (row == 4 && (col == 6)) {
                                    Circle()
                                        .fill(Color(.BETRAY))
                                        .frame(width: 15, height: 15)
                                } else if (row == 1 && (col == 3 || col == 6) || (row == 2 && (col == 2)) || (row == 3 && col == 1))
                                           {
                                    Circle()
                                        .fill(.blue)
                                        .frame(width: 15, height: 15)
                                } else if (row == 3 && (col >= 2) || (row == 4 && (col != 6))) {
                                    Circle()
                                        .fill(.yellow)
                                        .frame(width: 15, height: 15)
                                } else {
                                    Circle()
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(width: 15, height: 15)
                                }
                            }
                        }
                    }
                }
            }
            
            Spacer(minLength: 16)
            
            HStack(spacing: 16) {
                
                HStack {
                    Circle()
                        .fill(.blue)
                        .frame(width: 8, height: 8)
                    Text("1 Commit")
                        .font(.caption)
                }
                
                HStack {
                    Circle()
                        .fill(.green)
                        .frame(width: 8, height: 8)
                    Text("2+ Commits")
                        .font(.caption)
                }
                
                HStack {
                    Circle()
                        .fill(.yellow)
                        .frame(width: 8, height: 8)
                    Text("Release Push")
                        .font(.caption)
                }
                
                
                
            }
            

        }
        .padding(.horizontal)
        
    }
}


struct TagsView: View {

    @State private var added: [String] = [
        "Image of the Day", "Nature Scope", "Full Redesign", "Swifter Swift Responses", "New Animations", "Saturn in 3D", "Charts", "New Fonts", "Light Mode", "Share Sheets"
    ]
    
    @State private var removed: [String] = [
        "Auto Scrolling Home Screen", "Gradients", "App Roadmap", "Planet Images", "Planet Controls", "Planet Rotation Axis"
    ]
    
    @State private var bugs: [String] = [
        "OpenAI API Access Updated"
    ]
    
    var body: some View {
        VStack() {
            
            Text("Added Features")
                .font(Font.custom("SF Pro Rounded Medium", size: 16))
                .padding(.vertical, 4)
            
            TagLayout(alignment: .center, spacing: 10) {
                ForEach(added, id: \.self) { tag in
                    TagView(tag, .green)
                }
            }
            Spacer(minLength: 24)
            
            
            Text("Removed Features (might be added later)")
                .font(Font.custom("SF Pro Rounded Medium", size: 16))
                .padding(.vertical, 4)
            TagLayout(alignment: .center, spacing: 10) {
                ForEach(removed, id: \.self) { tag in
                    TagView(tag, .red)
                }
            }
            
            Spacer(minLength: 24)
            
            Text("Bug Fixes")
                .font(Font.custom("SF Pro Rounded Medium", size: 16))
                .padding(.vertical, 4)
            
            TagLayout(alignment: .center, spacing: 10) {
                ForEach(bugs, id: \.self) { tag in
                    TagView(tag, .orange)
                }
            }
            
            
        }
        .navigationTitle("Change Log")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    func TagView(_ tag: String, _ color: Color) -> some View {
        HStack(spacing: 10) {
            
            if color == .yellow {
                Text(tag)
                    .font(Font.custom("SF Pro Rounded Semibold", size: 16))
                    .foregroundStyle(.black)
            } else {
                Text(tag)
                    .font(Font.custom("SF Pro Rounded Semibold", size: 16))
            }
            
        }
        .frame(height: 30)
        .foregroundStyle(.white)
        .padding(.horizontal, 15)
        .background {
            Capsule()
                .fill(color.gradient)
        }
    }
}

struct TagLayout: Layout {
    var alignment: Alignment = .center
    var spacing: CGFloat = 12
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxWidth = proposal.width ?? 0
        var height: CGFloat = 0
        let rows = generateRows(maxWidth, proposal, subviews)
        
        for (index, row) in rows.enumerated() {
            if index == (rows.count - 1) {
                height += row.maxHeight(proposal)
            } else {
                height += row.maxHeight(proposal) + spacing
            }
        }
        return .init(width: maxWidth, height: height)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var origin = bounds.origin
        let maxWidth = bounds.width
        
        let rows = generateRows(maxWidth, proposal, subviews)
        
        for row in rows {
            let leading: CGFloat = bounds.maxX - maxWidth
            let trailing = bounds.maxX - (row.reduce(CGFloat.zero) { partialResult, view in
                let width = view.sizeThatFits(proposal).width
                
                if view == row.last {
                    return partialResult + width
                }
                return partialResult + width + spacing
            })
            let center = (trailing + leading) / 2
            
            origin.x = (alignment == .leading ? leading : alignment == .trailing ? trailing : center)
            
            for view in row {
                let viewSize = view.sizeThatFits(proposal)
                view.place(at: origin, proposal: proposal)
                origin.x += (viewSize.width + spacing)
            }
            origin.y += (row.maxHeight(proposal) + spacing)
        }
    }
    
    func generateRows(_ maxWidth: CGFloat, _ proposal: ProposedViewSize, _ subviews: Subviews) -> [[LayoutSubviews.Element]] {
        var row: [LayoutSubviews.Element] = []
        var rows: [[LayoutSubviews.Element]] = []
        
        var origin = CGRect.zero.origin
        
        for view in subviews {
            let viewSize = view.sizeThatFits(proposal)
            
            if (origin.x + viewSize.width + spacing) > maxWidth {
                rows.append(row)
                row.removeAll()
                origin.x = 0
                row.append(view)
                origin.x += (viewSize.width + spacing)
            } else {
                row.append(view)
                origin.x += (viewSize.width + spacing)
            }
        }
        
        if !row.isEmpty {
            rows.append(row)
            row.removeAll()
        }
        
        return rows
    }
}

extension [LayoutSubviews.Element] {
    func maxHeight(_ proposal: ProposedViewSize) -> CGFloat {
        return self.compactMap { view in
            return view.sizeThatFits(proposal).height
        }.max() ?? 0
    }
}

