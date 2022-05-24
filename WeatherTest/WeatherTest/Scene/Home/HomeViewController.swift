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
    
    /// button action
    //je met dans l onglet de documentation la raison pour laquelle il y a du code commenté ici c est que la detection de la connection de la device se fait unn temps apres la presentation de la screen donc on aurait du appuyer deux fois sur le bouton, mais la feature est fonctionnel quand il n y a pas de connexion.
    /// - Parameter sender: <#sender description#>
    @IBAction func actionBtn(_ sender: Any) {
//        if NetworkManager.manager.hasNetworkAccess {
        router?.routeToWheather()
//        }else {
//            let messageNetwork = UIAlertController(title: "No Connexion", message: "You are not connected", preferredStyle: .alert)
//            let ok = UIAlertAction(title: "OK", style: .cancel)
//            messageNetwork.addAction(ok)
//            self.present(messageNetwork, animated: true)
//        }
    }
}
