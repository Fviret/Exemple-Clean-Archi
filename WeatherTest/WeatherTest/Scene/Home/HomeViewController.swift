//
//  HomeViewController.swift
//  WeatherTest


import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displaySomething(viewModel: Home.Something.ViewModel)
}

class HomeViewController: UIViewController, HomeDisplayLogic {
    @IBOutlet weak var labelHome: UILabel!
    @IBOutlet weak var homeBtn: UIButton!
    var interactor: HomeBusinessLogic?
    var router: (HomeRoutingLogic & HomeDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let presenter = HomePresenter(viewController: self)
        let interactor = HomeInteractor(presenter: presenter)
        let router = HomeRouter(viewController: self, dataStore: interactor)
        self.interactor = interactor
        self.router = router
        
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelHome.text = "Application Météo test, en utilisant l Api openweathermap.org, un appel api toutes les 10 secondes avec des villes choisies, une progress bar qui va evoluer toute les 10 secondes, un message d attente qui va changer toute les 6 secondes, un activity loader tant que le process n est pas fini. quand le process est fini la progress bar laisse place à un bouton pour relancer le processus. "
        homeBtn.setTitle("let's go test", for: .normal)
        
        
        doSomething()
    }
    
    // MARK: Do something
    
    func doSomething() {
        let request = Home.Something.Request()
        interactor?.doSomething(request: request) 
    }
    
    func displaySomething(viewModel: Home.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
    
    
    @IBAction func actionBtn(_ sender: Any) {
        router?.routeToWheather()
    }
}
