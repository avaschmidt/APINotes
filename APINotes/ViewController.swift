import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var windOutlet: UILabel!
    
    @IBOutlet weak var maxTempOutlet: UILabel!
    
    @IBOutlet weak var minTempOutlet: UILabel!
    
   @IBOutlet weak var humidityOutlet: UILabel!
    
    @IBOutlet weak var sunsetOutlet: UILabel!
    
    @IBOutlet weak var sunriseOutlet: UILabel!
    
    @IBOutlet weak var tempOutlet: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeather()
    }
    
    func getWeather(){
        // creating an object of the URL session class so we can make an API call
        let session = URLSession.shared
        
        
        // making an API call for the weather in Crystal Lake Illinois
        // API Key = f32dd81585c694f7094fb8da758b55b4
        // URL = https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
        // you must remove the s from the https
        // remeber to add stuff to the info section
        //convert to imperial with &units=imperial
        let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=42.2&lon=-88.3&appid=f32dd81585c694f7094fb8da758b55b4&units=imperial")!
        
        // URLRequest is our variable we created (ie. weatherURL)
        // completionHandler is what we want it to do once it has the URL
        let dataTask = session.dataTask(with: weatherURL) { data, response, error in
            if let e = error{
                print("Error! \(e)")
            }
            else{
                if let d = data{
                    // getting the json object from the API
                    if let jsonObj = try? JSONSerialization.jsonObject(with: d, options: .fragmentsAllowed) as? NSDictionary{
                        print(jsonObj)
                        if let mainDictionary = jsonObj.value(forKey: "main") as? NSDictionary{
                            print(mainDictionary)
                            if let theTemp =  mainDictionary.value(forKey: "temp"){
                                print(theTemp)
                                
                                // happening on the main thread
                                DispatchQueue.main.async {
                                    self.tempOutlet.text = "The temp is \(theTemp) degrees F"
                                }
                                
                            }
                            if let humid =  mainDictionary.value(forKey: "humidity"){
                                print(humid)
                                
                                // happening on the main thread
                                DispatchQueue.main.async {
                                    self.humidityOutlet.text = "The humidity is \(humid)%"
                                }
                                
                            }
                            
                            if let theMin =  mainDictionary.value(forKey: "temp_min"){
                                print(theMin)
                                
                                // happening on the main thread
                                DispatchQueue.main.async {
                                    self.minTempOutlet.text = "The minimum temp is \(theMin) degrees F"
                                }
                                
                            }
                            
                            if let theMax =  mainDictionary.value(forKey: "temp_max"){
                                print(theMax)
                                
                                // happening on the main thread
                                DispatchQueue.main.async {
                                    self.maxTempOutlet.text = "The maximum temp is \(theMax) degrees F"
                                }
                                
                            }

                            
                        }
                        if let sysDictionary = jsonObj.value(forKey: "sys") as? NSDictionary{
                            if let sunrise = sysDictionary.value(forKey: "sunrise") as? Int{
                                print(sunrise)
                                // converting to date
                                let timeIntervalRise = TimeInterval(sunrise)
                                let date = Date(timeIntervalSince1970: timeIntervalRise)
                                print(date)
                                //creating a formatter to convert the date to time
                                let formatter = DateFormatter()
                                formatter.dateStyle = .none
                                formatter.timeStyle = .short
                                let dateString = formatter.string(from: date)
                                print(dateString)
                                DispatchQueue.main.async {
                                    self.sunriseOutlet.text = "The sunrise time is \(dateString)"
                                }
                                
                            }
                            if let sunset = sysDictionary.value(forKey: "sunset") as? Int{
                                print(sunset)
                                let timeIntervalSet = TimeInterval(sunset)
                                let date = Date(timeIntervalSince1970: timeIntervalSet)
                                print(date)
                                //creating a formatter to convert the date to time
                                let formatter = DateFormatter()
                                formatter.dateStyle = .none
                                formatter.timeStyle = .short
                                let dateString = formatter.string(from: date)
                                print(dateString)
                                DispatchQueue.main.async {
                                    self.sunsetOutlet.text = "The sunset time is \(dateString)"
                                }
                                
                            }
                            
                            
                        }
                        if let windDictionary = jsonObj.value(forKey: "wind") as? NSDictionary{
                            if let windSpeed = windDictionary.value(forKey: "speed") as? Int{
                                print(windSpeed)
                                    // happening on the main thread
                                    DispatchQueue.main.async {
                                        self.windOutlet.text = "The wind speed is \(windSpeed) mph"
                                    }
                            }
                        }
                        else{
                            print("Can't convert to JSON")
                        }
                    }
                    else{
                        print("Could't get data")
                    }
                }
            }
            
            
        }
        
        // constantly calling for the data
        dataTask.resume()
        
        
    }
    
}
