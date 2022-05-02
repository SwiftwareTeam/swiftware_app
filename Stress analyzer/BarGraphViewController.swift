//
//  BarGraphViewController.swift
//  Stress analyzer
//
//  Created by Sonia Soyeon Lee on 5/2/22.
//

import UIKit
import Charts

class BarGraphViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        questionLabel.text = "I see myself as kind"
        createChart(percentages: percentages)

    }
    
    @IBOutlet var questionLabel: UILabel!
    
    var percentages = [10.0, 25.0, 15.0, 20.0, 30.0]
    
    private func createChart(percentages: [Double]) {
        // create bar chart
        let barChart = BarChartView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        
        
        
        // configure axis
        let xAxis = barChart.xAxis
        let leftAxis = barChart.leftAxis
        
        // add labels?
        let labels = ["Strongly \nDisagree", "Disagree \na Little", "Neither", "Agree \na Little", "Strongly \nAgree"]

        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:labels)
        //Also, you probably we want to add:

        barChart.xAxis.granularity = 1
        
        // configure legend
        let legend = barChart.legend
        // supply data
        var entries = [BarChartDataEntry]()
        for x in 0..<5 {
            entries.append(
                BarChartDataEntry(
                    x: Double(x),
                    y: percentages[x]
                )
            )
        }
        let set = BarChartDataSet(entries: entries, label: "Percentages")
        set.colors = ChartColorTemplates.pastel()
        let data = BarChartData(dataSet: set)
        
        barChart.data = data
        
        view.addSubview(barChart)
        barChart.center = view.center
    }


}
