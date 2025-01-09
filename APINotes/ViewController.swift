import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tempOutlet: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    func getWeather(){
        // creating an object of the URL session class so we can make an API call
        let session = URLSession.shared
        
        
        // making an API call for the weather in Crystal Lake Illinois
        // API Key = f32dd81585c694f7094fb8da758b55b4
        // URL = https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
        let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=42.2&lon=-88.3&appid=f32dd81585c694f7094fb8da758b55b4")!
        
        // URLRequest is our variable we created (ie. weatherURL)
        // completionHandler is what we want it to do once it has the URL
        let dataTest = session.dataTask(with: weatherURL) { data, response, error in
            if let e = error{
                print("Error! \(e)")
            }
            else{
                if let d = data{
                    if let jsonObj = JSONSerialization.jsonObject(with: d, options: .)
                }
            }
        }
    }
    
    

}

