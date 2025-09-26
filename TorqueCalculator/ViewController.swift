import UIKit

final class ViewController: UIViewController {
    @IBOutlet weak var modeSegment: UISegmentedControl!
    @IBOutlet weak var input1Label: UILabel!
    @IBOutlet weak var input2Label: UILabel!
    @IBOutlet weak var input1Field: UITextField!
    @IBOutlet weak var input2Field: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!

    private let g: Double = 9.81

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        updateModeUI()
    }

    private func configureUI() {
        calculateButton.layer.cornerRadius = 10
        input1Field.keyboardType = .decimalPad
        input2Field.keyboardType = .decimalPad
        resultLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 17, weight: .medium)
    }

    @IBAction func modeChanged(_ sender: UISegmentedControl) {
        updateModeUI()
        resultLabel.text = ""
    }

    private func updateModeUI() {
        if modeSegment.selectedSegmentIndex == 0 {
            input1Label.text = "Mass (kg)"
            input2Label.text = "Distance (m)"
            calculateButton.setTitle("Calculate Torque", for: .normal)
        } else {
            input1Label.text = "Torque (Nm)"
            input2Label.text = "Distance (m)"
            calculateButton.setTitle("Calculate Mass", for: .normal)
        }
    }

    @IBAction func calculateTapped(_ sender: UIButton) {
        view.endEditing(true)
        let s1 = input1Field.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let s2 = input2Field.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        guard let v1 = Double(s1), let v2 = Double(s2) else {
            resultLabel.text = "⚠️ Enter valid numbers."
            return
        }
        guard v2 != 0 else {
            resultLabel.text = "⚠️ Distance must be non-zero."
            return
        }

        if modeSegment.selectedSegmentIndex == 0 {
            let torque = v1 * g * v2
            resultLabel.text = String(format: "Required Torque: %.3f Nm", torque)
        } else {
            let mass = v1 / (g * v2)
            resultLabel.text = String(format: "Liftable Mass: %.3f kg", mass)
        }
    }
}
