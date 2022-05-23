//
//  SwiftUIView.swift
//  Stress analyzer
//
//  Created by Sonia Soyeon Lee on 5/7/22.
//

import SwiftUI

struct BarGraphView: View {
    @EnvironmentObject var analyticsViewModel: AnalyticsViewModel
    @EnvironmentObject var surveyViewModel: SurveyViewModel
    @State var defaultQuestion: Int = 1
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
                    VStack {
                        Text("Select a Question").foregroundColor(.white).fontWeight(.bold)
                        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                            .fill(.white)
                            .frame(width: 180, height: 30)
                            .overlay {
                                Picker(selection: $defaultQuestion, label: Text("")) {
                                    ForEach(surveyViewModel.surveys[1]?.questions.map { $0.key }.sorted() ?? [1], id: \.self) { id in
                                        Text("Question \(id)")
                                    }
                                }
                                .pickerStyle(.menu)
                                    .padding(.horizontal, 70)
                        }
                    }.padding(.bottom, 10)

                    Text(surveyViewModel.surveys[1]?.questions[defaultQuestion]?.fullWording ?? "Loading...")
                        .font(.system(size: 20))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(30)

//                    ForEach(analyticsViewModel.getMeasureValues(surveyID: 1, questionID: defaultQuestion), id: \.self) { item in
//                        Text("\(item)")
//                    }

                    HStack (spacing: 16){
                        if analyticsViewModel.getMeasureValues(surveyID: 1, questionID: defaultQuestion).count > 0 {
                            BarView(value: CGFloat(analyticsViewModel.getMeasureValues(surveyID: 1,
                                                                                       questionID: defaultQuestion)[0]
                                                   * 2.0),
                                    label: "SD")
                            BarView(value: CGFloat(analyticsViewModel.getMeasureValues(surveyID: 1,
                                                                                       questionID: defaultQuestion)[1]
                                                   * 2.0),
                                    label: "DL")
                            BarView(value: CGFloat(analyticsViewModel.getMeasureValues(surveyID: 1,
                                                                                       questionID: defaultQuestion)[2]
                                                   * 2.0),
                                    label: "N")
                            BarView(value: CGFloat(analyticsViewModel.getMeasureValues(surveyID: 1,
                                                                                       questionID: defaultQuestion)[3]
                                                   * 2.0),
                                    label: "AL")
                            BarView(value: CGFloat(analyticsViewModel.getMeasureValues(surveyID: 1,
                                                                                       questionID: defaultQuestion)[4]
                                                   * 2.0),
                                    label: "SA")
                            //                        BarView(value: dataPoints[pickerSelectedItem][1], label: "DL")
                            //                        BarView(value: dataPoints[pickerSelectedItem][2], label: "N")
                            //                        BarView(value: dataPoints[pickerSelectedItem][3], label: "AL")
                            //                        BarView(value: dataPoints[pickerSelectedItem][4], label: "SA")
                        }
                    }
                    .padding(.top, 30)
                        .animation(.default)
                    Spacer()
                }
                .padding(.bottom, 60)
                
            }
            .task {
                await analyticsViewModel.getAvgResponseRate(surveyID: 1)
                await surveyViewModel.getSurveys()
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
            .environmentObject(AnalyticsViewModel())
            .environmentObject(SurveyViewModel())
    }
}
