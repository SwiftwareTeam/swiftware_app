//
//  GaugeView.swift
//  Stress Analyzer
//
//  Created by Sonia Soyeon Lee on 5/15/22.
//
//
//import SwiftUI
//
//struct GaugeView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//struct GaugeView_Previews: PreviewProvider {
//    static var previews: some View {
//        GaugeView()
//    }
//}

//
//  SwiftUIView.swift
//  Stress analyzer
//
//  Created by Sonia Soyeon Lee on 5/9/22.
//

import SwiftUI

struct GaugeView: View {
    
    var body: some View {
        Home()
    }
}

struct GaugeView_Previews: PreviewProvider {
    static var previews: some View {
        GaugeView()
    }
}

struct Home: View {
    
    let colors = [Color("Blue1"), Color("Blue2"), Color("Blue3"), Color("Blue4"), Color("Blue5")]
    
    @State var progress: CGFloat = 0
    
    var body: some View {
        
        VStack {
            
            Text("Question")
                .font(.system(size: 20, weight: .heavy, design: .default))
                .foregroundColor(.white)
                .padding(.vertical, 50)
            
            Meter(progress: self.$progress)
                .onAppear {
                    withAnimation(Animation.default.speed(0.45)) {
                        self.progress = 50
                    }
                }
            
            
            Text ("Response")
                .font(.system(size: 15, weight: .medium, design: .default))
                .foregroundColor(.white)
                .padding(.vertical, 35)
            
            /*
            HStack(spacing: 25) {

                Button(action: {
                    withAnimation(Animation.default.speed(0.55)) {
                        if self.progress != 100 {
                            self.progress += 10
                        }
                    }
                    
                }) {
                    
                    Text("Update")
                        .padding(.vertical, 10)
                        .frame(width: (UIScreen.main.bounds.width - 5) / 2)
                }
                .background(Capsule().stroke(LinearGradient(gradient: .init(colors: self.colors), startPoint: .leading, endPoint: .trailing), lineWidth: 2))
                                
                Button(action: {
                    withAnimation(Animation.default.speed(0.55)) {
                        self.progress = 0
                    }
                    
                }) {
                    Text("Reset")
                        .padding(.vertical, 10)
                        .frame(width: (UIScreen.main.bounds.width - 5) / 2)
                }
                .background(Capsule().stroke(LinearGradient(gradient: .init(colors: self.colors), startPoint: .leading, endPoint: .trailing), lineWidth: 2))
            }
            .padding(.top, 55)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.5843137255, green: 0.5176470588, blue: 1, alpha: 1)))
                 */
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.5843137255, green: 0.5176470588, blue: 1, alpha: 1)))
    }
    
    
                 
}

struct Meter: View {
    
    let colors = [Color("Blue1"), Color("Blue5")]
    @Binding var progress: CGFloat
    
    var body: some View {
        ZStack {
            ZStack {
                Circle()
                    .trim(from: 0, to: 0.5)
                    .stroke(Color.black.opacity(0.1), lineWidth: 55)
                    .frame(width:280, height: 280)
                Circle()
                    .trim(from: 0, to: self.setProgress())
                    .stroke(AngularGradient(gradient: .init(colors: self.colors), center: .center, angle: .init(degrees: 180)), lineWidth: 55)
                    .frame(width:280, height: 280)
            }
            .rotationEffect(.init(degrees: 180))
            
            ZStack(alignment: .bottom) {
                Color.white
                    .frame(width:2, height:95)
                
                Circle()
                    .fill(.white)
                    .frame(width:15, height: 15)
            }
            .offset(y: -35)
            .rotationEffect(.init(degrees: -90))
            .rotationEffect(.init(degrees: self.setArrow()))
        }
        .padding(.bottom, -140)
        
    }
    
    func setProgress()->CGFloat {
        let temp = self.progress / 2
        return temp * 0.01
    }
    
    func setArrow()->Double {
        let temp = self.progress / 100
        return Double(temp * 180)
    }
}
