import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var massTextField: UITextField!
    @IBOutlet weak var distanceTextField: UITextField!
    @IBOutlet weak var torqueTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!

    let g = 9.81

    @IBAction func calculateTorque(_ sender: UIButton) {
        guard let mass = Double(massTextField.text ?? ""),
              let distance = Double(distanceTextField.text ?? "") else {
            resultLabel.text = "Invalid input."
            return
        }
        let torque = mass * g * distance
        resultLabel.text = String(format: "Torque: %.2f Nm", torque)
    }

    @IBAction func calculateMass(_ sender: UIButton) {
        guard let torque = Double(torqueTextField.text ?? ""),
              let distance = Double(distanceTextField.text ?? ""),
              distance != 0 else {
            resultLabel.text = "Invalid input."
            return
        }
        let mass = torque / (g * distance)
        resultLabel.text = String(format: "Mass: %.2f kg", mass)
    }
}
