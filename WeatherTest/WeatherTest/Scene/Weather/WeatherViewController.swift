//
//  WeatherViewController.swift
//  WeatherTest


import UIKit

protocol WeatherDisplayLogic: AnyObject {
    func displaySomething(viewModel: Weather.Something.ViewModel)
}

class WeatherViewController: UIViewController, WeatherDisplayLogic {
    var interactor: WeatherBusinessLogic?
    var router: (WeatherRoutingLogic & WeatherDataPassing)?
    
    
    //mes outlets
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var repeatBtn: UIButton!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var ProgressBar: UIProgressView!
    @IBOutlet weak var ProgressLbl: UILabel!
    
    //tools
    var timer: Timer?
    var cityWeathers = [WeatherData]()
    var Citys = ["Rennes", "Paris", "Nantes", "Bordeaux", "Lyon"]
    
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let presenter = WeatherPresenter(viewController: self)
        let interactor = WeatherInteractor(presenter: presenter)
        let router = WeatherRouter(viewController: self, dataStore: interactor)
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        loader.startAnimating()
        updateUI(fill: false)
        messageLbl.text = ""
        ProgressBar.setProgress(0.0, animated: true)
        ProgressLbl.text = ""
        repeatBtn.setTitle("Recommencer", for: .normal)
        tableview.register(UINib(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherTableViewCell")
        showWeather()
    }
    
    // MARK: Do something
    
    func showWeather() {
        var runCount = 0
       
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if runCount % 10 == 0 && runCount < 41{
                self.getWeather(city: self.Citys[runCount / 10])
                self.displayProgress(progression: runCount)
            }
            if runCount % 10 == 0 && runCount > 40{
                self.displayProgress(progression: runCount)
            }
            if runCount % 6 == 0 {
                self.displayWaitingMessage(runCount: runCount)
            }
            runCount += 1
            if runCount == 60 {
                self.updateUI(fill : true)
                timer.invalidate()
                self.tableview.reloadData()
            }
        }
    }
    
    func displayProgress(progression: Int) {
        var progressCalc: Float = 0.0
        progressCalc = Float((1.0 * Float(progression)) / 60.0)
        ProgressBar.setProgress(progressCalc, animated: true)
        ProgressLbl.text = "\(Float(progression) * 1.9) %"
        
    }
    
    func displayWaitingMessage(runCount: Int){
        switch runCount {
        case 0, 18, 36, 54:
            self.messageLbl.text = "Nous téléchargeons les données…"
        case 6, 24, 42:
            self.messageLbl.text = "C’est presque fini…"
        case 12, 30, 48:
            self.messageLbl.text = "Plus que quelques secondes avant d’avoir le résultat…"
        default:
            break
        }
    }
    
    func updateUI(fill : Bool) {
        ProgressBar.isHidden = fill
        ProgressLbl.isHidden = fill
        messageLbl.isHidden = fill
        repeatBtn.isHidden = !fill
        repeatBtn.isEnabled = fill
        loader.isHidden = fill
        
    }
    
    func getWeather(city: String) {
        let request = Weather.Something.Request(city: city)
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: Weather.Something.ViewModel) {

        cityWeathers += viewModel.responseToController
//        print(cityWeathers.first?.weather.first?.main)
    }
    
    @IBAction func actionBtn(_ sender: Any) {
//        if NetworkManager.manager.hasNetworkAccess {
        showWeather()
        cityWeathers.removeAll()
        updateUI(fill: false)
        tableview.reloadData()
        ProgressBar.setProgress(0.0, animated: true)
//        }else{
//            let messageNetwork = UIAlertController(title: "No Connexion", message: "You are not connected", preferredStyle: .alert)
//            let ok = UIAlertAction(title: "OK", style: .cancel)
//            messageNetwork.addAction(ok)
//            self.present(messageNetwork, animated: true)
//        }
    }
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityWeathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
        let monIndex = cityWeathers[indexPath.row]
        let name = monIndex.name
        let temperature = monIndex.main.temp
        let picto = monIndex.weather.first?.main ?? "moon.circle.fill"
        cell.setup(with: name, temperature: temperature, picto: picto)
        return cell
    }
}
