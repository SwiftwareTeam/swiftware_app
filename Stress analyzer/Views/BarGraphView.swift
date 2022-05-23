//
//  SwiftUIView.swift
//  Stress analyzer
//
//  Created by Sonia Soyeon Lee on 5/7/22.
//

import SwiftUI

struct BarGraphView: View {
    @State var pickerSelectedItem = 0
    
    @State var dataPoints: [[CGFloat]] = [
        [50, 100, 150, 160, 180],
        [180, 160, 150, 100, 50],
        [90, 150, 180, 70, 110],
    ]
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .white
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color(#colorLiteral(red: 0.5843137255, green: 0.5176470588, blue: 1, alpha: 1)))], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.5843137255, green: 0.5176470588, blue: 1).edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Question")
                        .font(.system(size: 20))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.bottom, 10)
                    
                    Picker(selection: $pickerSelectedItem, label: Text("")) {
                        Text("Pre").tag(0)
                        Text("Post").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal, 70)
                    
                    HStack (spacing: 16){
                        BarView(value: dataPoints[pickerSelectedItem][0], label: "SD")
                        BarView(value: dataPoints[pickerSelectedItem][1], label: "DL")
                        BarView(value: dataPoints[pickerSelectedItem][2], label: "N")
                        BarView(value: dataPoints[pickerSelectedItem][3], label: "AL")
                        BarView(value: dataPoints[pickerSelectedItem][4], label: "SA")

                       
                    }
                    .padding(.top, 30)
                        .animation(.default)
                }
                .padding(.bottom, 60)
                
            }
            
        }
        .navigationTitle("General Statistics")
    }
}

struct BarView: View {
    
    var value: CGFloat = 0
    var label: String = ""
    
    var body: some View {
        VStack {
            ZStack (alignment: .bottom){
                Capsule().frame(width: 30, height: 200)
                    .foregroundColor(Color(red: 0.421328014, green: 0.3741274484, blue: 0.7422206918))
                Capsule().frame(width: 30, height: value)
                    .foregroundColor(.white)
            }
            Text(label)
                .padding(.top, 10)
                .foregroundColor(.white)
                .font(.system(size: 15))
        }

    }
}

struct BarGraphView_Previews: PreviewProvider {
    static var previews: some View {
        BarGraphView()
    }
}
