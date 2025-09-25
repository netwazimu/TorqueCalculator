import UIKit

final class ViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var modeSegment: UISegmentedControl!
    @IBOutlet weak var input1Label: UILabel!
    @IBOutlet weak var input2Label: UILabel!
    @IBOutlet weak var input1Field: UITextField!
    @IBOutlet weak var input2Field: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!

    // gravity constant
    private let g: Double = 9.81

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        updateModeUI()
        addDoneButtonOnKeyboard()
    }

    // MARK: - UI
    private func configureUI() {
        view.backgroundColor = UIColor.systemBackground
        calculateButton.layer.cornerRadius = 10
        calculateButton.layer.shadowColor = UIColor.black.cgColor
        calculateButton.layer.shadowOpacity = 0.12
        calculateButton.layer.shadowRadius = 4
        calculateButton.layer.shadowOffset = CGSize(width: 0, height: 2)

        input1Field.keyboardType = .decimalPad
        input2Field.keyboardType = .decimalPad
        resultLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 17, weight: .medium)
        resultLabel.text = ""

        input1Field.accessibilityIdentifier = "input1"
        input2Field.accessibilityIdentifier = "input2"
    }

    private func addDoneButtonOnKeyboard() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        toolbar.items = [flex, done]
        input1Field.inputAccessoryView = toolbar
        input2Field.inputAccessoryView = toolbar
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: - Actions
    @IBAction func modeChanged(_ sender: UISegmentedControl) {
        updateModeUI()
        resultLabel.text = ""
    }

    private func updateModeUI() {
        if modeSegment.selectedSegmentIndex == 0 {
            input1Label.text = "Mass (kg)"
            input2Label.text = "Distance (m)"
            input1Field.placeholder = "e.g. 10"
            input2Field.placeholder = "e.g. 0.5"
            calculateButton.setTitle("Calculate Torque", for: .normal)
        } else {
            input1Label.text = "Torque (Nm)"
            input2Label.text = "Distance (m)"
            input1Field.placeholder = "e.g. 5"
            input2Field.placeholder = "e.g. 0.5"
            calculateButton.setTitle("Calculate Mass", for: .normal)
        }
    }

    @IBAction func calculateTapped(_ sender: UIButton) {
        dismissKeyboard()

        let s1 = input1Field.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let s2 = input2Field.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        guard let v1 = Double(s1), let v2 = Double(s2) else {
            showError("Please enter valid numeric values for both fields.")
            return
        }

        guard v2 != 0 else {
            showError("Distance must be non-zero.")
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

    private func showError(_ message: String) {
        resultLabel.text = "⚠️ " + message
    }
}
