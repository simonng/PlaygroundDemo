//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

let containerView = UIView(frame: CGRectMake(0, 0, 640, 1136))
containerView.backgroundColor = UIColor.purpleColor()
let backgroundImage = [#Image(imageLiteral: "train-cross.png")#]

let backgroundImageView = UIImageView(image: backgroundImage)
containerView.addSubview(backgroundImageView)

XCPlaygroundPage.currentPage.liveView = containerView

let weatherLabel = UILabel(frame: CGRectMake(0, 0, 100, 30))
weatherLabel.text = "31℃"
weatherLabel.textColor = UIColor.whiteColor()
weatherLabel.font = UIFont(name: "Georgia", size: 150.0)
weatherLabel.sizeToFit()
containerView.addSubview(weatherLabel)

let weatherIconLabel = UILabel(frame: CGRectMake(0, 200, 150, 150))
weatherIconLabel.text = "🌤"
weatherIconLabel.font = UIFont.systemFontOfSize(150.0)
containerView.addSubview(weatherIconLabel)

let weatherAPI = "http://api.openweathermap.org/data/2.5/weather?q=hk&appid=44db6a862fba0b067b1930da0d769e98&units=metric"

if let url = NSURL(string: weatherAPI) {
    let session = NSURLSession.sharedSession()
    let dataTask = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
        
        guard let data = data else {
            return
        }
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            let main = json["main"] as! [String: AnyObject]
            if let temperature = main["temp"] {
                
                NSOperationQueue.mainQueue().addOperationWithBlock() {
                    weatherLabel.text = "\(temperature)℃"
                    weatherLabel.sizeToFit()
                }
            }
        } catch {
            print("Failed to get weather data!")
        }
        
    })
    
    dataTask.resume()
}

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
