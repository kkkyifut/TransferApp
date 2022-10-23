import UIKit

class ViewController: UIViewController, DataUpdateProtocol {
    var updatedDate = "Test Data"
    @IBOutlet var dataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabel(withText: updatedDate)
    }
    
    // MARK: - Переход между сценами и сохранение данных с использованием свойства
    
    @IBAction func editDataWithProperty(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        
        editScreen.updatingData = dataLabel.text ?? ""
        
        self.navigationController?.pushViewController(editScreen, animated: true)
    }
    
    private func updateLabel(withText text: String) {
        dataLabel.text = text
    }
    
    // MARK: - Переход между сценами и сохранение данных с использованием segue
    
    @IBAction func unwindToFirstScreen(_ segue: UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toEditScreen":
            prepareEditScreen(segue)
        default:
            break
        }
    }
    
    private func prepareEditScreen(_ segue: UIStoryboardSegue) {
        guard let destinationController = segue.destination as? SecondViewController else {
            return
        }
        destinationController.updatingData = dataLabel.text ?? ""
    }
    
    // MARK: - Переход между сценами и сохранение данных с помощью делегирования
    
    @IBAction func editDataWithDelegate(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        editScreen.updatingData = dataLabel.text ?? ""
        editScreen.handleUpdatedDataDelegate = self
        self.navigationController?.pushViewController(editScreen, animated: true)
    }
    
    func onDataUpdate(data: String) {
        updatedDate = data
        updateLabel(withText: data)
    }
    // MARK: - Переход между сценами и сохранение данных с помощью замыкания

    @IBAction func editDataWithClosure(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        editScreen.updatingData = dataLabel.text ?? ""
        editScreen.completionHandler = {[ unowned self ] updatedValue in
            updatedDate = updatedValue
            updateLabel(withText: updatedValue)
        }
        self.navigationController?.pushViewController(editScreen, animated: true)
    }
    
}
