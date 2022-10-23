import UIKit

class SecondViewController: UIViewController {
    var updatingData: String = ""

    @IBOutlet var dataTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Переход между сценами и сохранение данных с использованием свойства

    @IBAction func saveDataWithProperty(_ sender: UIButton) {
        self.navigationController?.viewControllers.forEach { viewController in
            (viewController as? ViewController)?.updatedDate = dataTextField.text ?? ""
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTextFieldData(withText: updatingData)
    }

    private func updateTextFieldData(withText text: String) {
        dataTextField.text = text
    }

    // MARK: - Переход между сценами и сохранение данных с использованием segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toFirstScreen":
            prepareFirstScreen(segue)
        default:
            break
        }
    }

    private func prepareFirstScreen(_ segue: UIStoryboardSegue) {
        guard let destinationController = segue.destination as? ViewController else {
            return
        }
        destinationController.updatedDate = dataTextField.text ?? ""
    }
}
