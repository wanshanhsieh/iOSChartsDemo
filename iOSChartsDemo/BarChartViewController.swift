//
//  BarChartViewController.swift
//  iOSChartsDemo
//
//  Created by Joyce Echessa on 6/12/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit
import Charts

class BarChartViewController: UIViewController {

    var months: [String]!
    
    @IBOutlet weak var barChartView: BarChartView!
    // weak var axisFormatDelegate: IAxisValueFormatter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let unitsSold = [50.0, 10.0, 20.0, 30.0, 25.0, 15.0]
        setChart(dataPoints: months, values: unitsSold)
    }

    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "Please provide data for the chart"
        
        /* for x axis */
        let formato:BarChartFormatter = BarChartFormatter()
        let xaxis:XAxis = XAxis()
        formato.setArray(source: months)
        
        /* for chart data */
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i], data:dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
            formato.stringForValue(Double(i), axis: xaxis)
        }
        
        /* for chart data */
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        barChartView.chartDescription?.text = ""
        
        /* for x axis */
        xaxis.setLabelCount(dataPoints.count, force: true) // not working
        xaxis.granularityEnabled = false // not working
        xaxis.valueFormatter = formato
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.valueFormatter = xaxis.valueFormatter

        /* animation */
        barChartView.animate(xAxisDuration: 2.0)
        barChartView.animate(yAxisDuration: 2.0)
    }
}

@objc(BarChartFormatter)
public class BarChartFormatter: NSObject, IAxisValueFormatter {
    var months: [String]! = []
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return months[Int(value)]
    }
    
    public func setArray(source: [String]) {
        months = source
    }
}
