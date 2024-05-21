//
//  ChangeLogView.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 5/21/24.
//

import SwiftUI

struct ChangelogView: View {
    var body: some View {
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
                    
                    Divider()
                    
                    HStack {
                        Text("Stats for nerds 🤓").textCase(.uppercase)
                            .padding([.top, .horizontal])
                            .padding(.bottom, 2)
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                    
                    ActivityView()
                        .padding(.bottom, 2)
                    
                    Divider()
                    
                    
                    
                }
            }
            .navigationBarItems(
                trailing: Button(action: {
                    // Add your second trailing button action here
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundStyle(.black)
                }
            )
        }
    }
}

#Preview {
    ChangelogView()
}



struct ActivityView: View {
    @State private var trigger: Bool = false

    
    var body: some View {
        VStack() {

            HStack(alignment: .firstTextBaseline) {
                GarenText(text: "457", trigger: trigger)
                    .font(Font.custom("SF Mono Bold", size: 44))
                Text("files changed")
                    .font(Font.custom("SF Pro Rounded Semibold", size: 24))
                Spacer()
            }
            
            HStack(alignment: .firstTextBaseline) {
                GarenText(text: "3424", trigger: trigger)
                    .font(Font.custom("SF Mono Bold", size: 44))
                    .foregroundStyle(.green)
                Text("lines added")
                    .font(Font.custom("SF Pro Rounded Semibold", size: 24))
                Spacer()
            }
            
            HStack(alignment: .firstTextBaseline) {
                GarenText(text: "11921", trigger: trigger)
                    .font(Font.custom("SF Mono Bold", size: 44))
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
                        .foregroundColor(.secondary)
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
                        .foregroundColor(.secondary)
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
                        .foregroundColor(.secondary)
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
                        .foregroundColor(.secondary)
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
                                } else if (row == 3 && (col >= 2)) {
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


