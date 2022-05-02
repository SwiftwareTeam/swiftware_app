//
//  SwiftUIView.swift
//  Stress analyzer
//
//  Created by Sonia Soyeon Lee on 4/28/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Content_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    var body: some View {
        VStack {
            Meter()
            
            HStack(spacing: 25) {
                Button(action)
            }
        }
    }
}

struct Meter : View {
    let colors = [Color("Color"),Color("Color1")]
    var body: some View {
        ZStack {
            ZStack {
                Circle()
                    .trim(from: 0, to: 0.5)
                    .stroke(Color.black.opacity(0.1), lineWidth: 55)
                    .frame(width: 280, height: 280)
                
                Circle()
                    .trim(from: 0, to: 0.09)
                    .stroke(AngularGradient(gradient: .init(colors: self.colors), center: .center, angle: .init(degrees: 180)), lineWidth: 55)
                    .frame(width: 280, height: 280)
            }
            .rotationEffect(.init(degrees: 180))
            
            ZStack(alignment: .bottom) {
                self.colors[0]
                .frame(width: 2, height: 95)
                
                Circle()
                    .fill(self.colors[0])
                    .frame(width: 15, height: 15)
            }
            .offset(y: -35)
            .rotationEffect(.init(degrees: -90))
        }
        .padding(.bottom, -140)
    }
}
