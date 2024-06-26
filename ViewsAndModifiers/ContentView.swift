//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Shing Huey on 04/06/2024.
//

import SwiftUI

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(.rect(cornerRadius: 10))
    }
}
struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}
extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}
struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
        //            .foregroundStyle(.white)
            .background(.blue)
            .clipShape(.capsule)
    }
}
struct ContentView: View {
    @State private var animationAmount = 1.0
    
    var body: some View {
        //        GridStack(rows: 4, columns: 4) { row, col in
        //            HStack {
        //                Image(systemName: "\(row * 4 + col).circle")
        //                Text("R\(row) C\(col)")
        //            }
        //        }
        
        Button("Tap Me") {
            animationAmount += 1
        }
        .padding(50)
        .background(.mint)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .scaleEffect(animationAmount)
        //          .animation(.easeInOut(duration: 2), value: animationAmount)
        //        .animation(
        //            .easeInOut(duration: 2)
        //            .delay(1),
        //            value: animationAmount
        //        )
        //        .animation(
        //            .easeInOut(duration: 1)
        //                .repeatCount(3, autoreverses: true),
        //            value: animationAmount
        //        )
        .overlay(
            Circle()
                .stroke(.mint)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(
                    .easeOut(duration: 1)
                    .repeatForever(autoreverses: false),
                    value: animationAmount
                )
        )        .animation(
            .easeInOut(duration: 1)
            .repeatForever(autoreverses: true),
            value: animationAmount
        )
        .onAppear {
            animationAmount = 2
        }

        
    }
}

#Preview {
    ContentView()
}
