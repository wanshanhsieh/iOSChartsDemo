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
        var legendEntries: [LegendEntry] = []

        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i])
            dataEntries.append(dataEntry)
            
            let red = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
            
            let legendEntry = LegendEntry.init(label: dataPoints[i], form: .default, formSize: 20.0, formLineWidth: CGFloat.nan, formLineDashPhase: CGFloat.nan, formLineDashLengths: nil, formColor: colors[i])
            legendEntries.append(legendEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Units Sold")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        
        // setPieChartDataConfig(pieChartData: pieChartData) // show percentage of data
        
        /* pie chart data */
        pieChartDataSet.colors = colors
        pieChartView.chartDescription?.text = ""
        pieChartView.data = pieChartData
        
        /* pie chart legend */
        setPieChartLegend(Legend: legendEntries)
        
    }
    
    /* show % of data */
    func setPieChartDataConfig(pieChartData: PieChartData){
        pieChartData.setValueFormatter(DigitValueFormatter())
        pieChartData.setValueTextColor(UIColor.gray)
        pieChartData.setValueFont(UIFont.systemFont(ofSize: 10))
    }
    
    /* show pie chart legend */
    func setPieChartLegend(Legend: [LegendEntry]) {
        pieChartView.legend.horizontalAlignment = .center
        pieChartView.legend.verticalAlignment = .bottom
        pieChartView.legend.font = UIFont.systemFont(ofSize: 14)
        pieChartView.legend.setCustom(entries: Legend)
    }
    
}

@objc (DigitValueFormatter)
public class DigitValueFormatter: NSObject, IValueFormatter {

    public func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        let valueWithoutDecimalPart = String(format: "%.2f%%", value)
        return valueWithoutDecimalPart
    }
}

