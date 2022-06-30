//
//  WeatherViewController.swift
//  WeatherTest


import UIKit

// MARK: Protocol Interactor

protocol WeatherDisplayLogic: AnyObject {
    func displaySomething(viewModel: Weather.Something.ViewModel)
    func displayMessage(message : String)
    func displayProgress(progressionBar: Float, progressionLbl: String)
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
    @IBOutlet weak var addBtn: UIButton!
    
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
        addBtn.setTitle("Ajouter une ville", for: .normal)
        showWeather()
    }
    
    // MARK: Do something
    
    func showWeather() {
        var runCount = 0
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if runCount % 10 == 0 && runCount < 41{
                self.getWeather(city: self.Citys[runCount / 10])
                self.interactor?.displayProgress(progression: runCount)
            }
            if runCount % 10 == 0 && runCount > 40{
                self.interactor?.displayProgress(progression: runCount)
            }
            if runCount % 6 == 0 {
                self.interactor?.displayWaitingMessage(runCount: runCount)
            }
            runCount += 1
            if runCount == 60 {
                self.updateUI(fill : true)
                timer.invalidate()
                self.tableview.reloadData()
            }
        }
    }
    
    func displayProgress(progressionBar: Float, progressionLbl: String) {
        ProgressBar.setProgress(progressionBar, animated: true)
        ProgressLbl.text = progressionLbl
    }
    
    func updateUI(fill : Bool) {
        ProgressBar.isHidden = fill
        ProgressLbl.isHidden = fill
        messageLbl.isHidden = fill
        addBtn.isHidden = !fill
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
    }
    
    func displayMessage(message: String) {
        self.messageLbl.text = message
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Ajouter une ville", message: "Commencer avec une Majuscule et sans fautes.", preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = "Nom de la Ville (ex : Annecy)"
            field.keyboardType = .default
            field.text = ""
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Ajouter", style: .default) { [self]_ in
            guard let field = alert.textFields else { return }
            let cityText = field[0].text
         
            getWeather(city: cityText!)
            tableview.reloadData()
//            self.addCity(city: text.first!)
        })
        present(alert, animated: true)
        
    }
    
    @objc func addCity(city: String) {
        getWeather(city: city)
    }
    
    @IBAction func actionBtn(_ sender: Any) {
        showWeather()
        cityWeathers.removeAll()
        updateUI(fill: false)
        tableview.reloadData()
        ProgressBar.setProgress(0.0, animated: true)
    }
    
    @IBAction func actionAddBtn(_ sender: Any) {
        showAlert()
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
