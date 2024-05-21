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
                        Text("1.1")
                            .font(Font.custom("SF Pro Rounded Medium", size: 20))
                            .foregroundStyle(.SOUR)

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
                        Text("Codebase").textCase(.uppercase)
                            .padding()
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                    
                    ActivityView()
                    
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
    
    var body: some View {
        VStack() {

            HStack(alignment: .firstTextBaseline) {
                Text("483")
                    .font(Font.custom("SF Pro Rounded Bold", size: 40))
                Text("files changed")
                    .font(Font.custom("SF Pro Rounded Semibold", size: 24))
                Spacer()
            }
            
            HStack(alignment: .firstTextBaseline) {
                Text("3,469")
                    .font(Font.custom("SF Pro Rounded Bold", size: 40))
                    .foregroundStyle(.green)
                Text("additions")
                    .font(Font.custom("SF Pro Rounded Semibold", size: 24))
                Spacer()
            }
            
            HStack(alignment: .firstTextBaseline) {
                Text("6,778")
                    .font(Font.custom("SF Pro Rounded Bold", size: 40))
                    .foregroundStyle(.red)
                Text("deletions")
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
                                        .fill(.white)
                                        .frame(width: 15, height: 15)
                                } else if row == 4 && (col == 0 || col == 1 || col == 2) {
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
                                        .fill(.white)
                                        .frame(width: 15, height: 15)
                                } else if row == 4 && (col == 0 || col == 1 || col == 2) {
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
                                        .fill(.white)
                                        .frame(width: 15, height: 15)
                                } else if row == 4 && (col == 0 || col == 1 || col == 2) {
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
                                        .fill(.white)
                                        .frame(width: 15, height: 15)
                                } else if row == 4 && (col == 0 || col == 1 || col == 2) {
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

            


        }
        .padding(.horizontal)
    }
}


