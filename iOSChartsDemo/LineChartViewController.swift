//
//  LineChartViewController.swift
//  iOSChartsDemo
//
//  Created by sandra on 2018/6/10.
//  Copyright © 2018年 Appcoda. All rights reserved.
//

import Foundation
import Charts

class LineChartViewController: UIViewController {
    
    var unitsSold: [Double]!
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        unitsSold = [50.0, 10.0, 20.0, 25.0, 30.0, 15.0, 40.0]
        setChart(values: unitsSold)
    }
    
    func setChart(values: [Double]) {
        var lineDataEntries: [ChartDataEntry] = []
        
        for i in 0..<values.count {
            let lineDataEntry = ChartDataEntry(x: Double(i), y: values[i])
            lineDataEntries.append(lineDataEntry)
        }

        let line = LineChartDataSet(values: lineDataEntries, label: "Units Sold")
        let data = LineChartData()
        
        data.addDataSet(line)
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.data = data
    }
}
