import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.text = "🔒 Locked"
        statusLabel.textColor = .red
    }

    @IBAction func tapUnlockButton(_ sender: Any) {
        authenticateUser()
    }
    

    func authenticateUser() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself to access data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        self?.statusLabel.text = "✅ Unlocked"
                        self?.statusLabel.textColor = .systemGreen
                    } else {
                        self?.statusLabel.text = "❌ Failed"
                    }
                }
            }
        } else {

            print("FaceID not available")
            self.statusLabel.text = "FaceID Unavailable"
        }
    }
}
