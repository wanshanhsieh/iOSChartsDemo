//
//  ChartsViewController.swift
//  iOSChartsDemo
//
//  Created by Joyce Echessa on 6/12/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit
import Charts

class ChartsViewController: UIViewController {

    var months: [String]!
    
    @IBOutlet weak var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        months = ["Jan", "Feb", "Mar"]
        let unitsSold = [50.0, 10.0, 20.0]
        setChart(dataPoints: months, values: unitsSold)
    }

    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        var colors: [UIColor] = []
        var LegendEntries: [LegendEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
            
            let red = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
            
            let legendEntry = LegendEntry.init(label: dataPoints[i], form: .default, formSize: 14.0, formLineWidth: CGFloat.nan, formLineDashPhase: CGFloat.nan, formLineDashLengths: nil, formColor: colors[i])
            LegendEntries.append(legendEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Units Sold")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        
        pieChartDataSet.colors = colors
        pieChartView.chartDescription?.text = ""
        pieChartView.legend.setCustom(entries: LegendEntries)
        pieChartView.data = pieChartData
    }
}
