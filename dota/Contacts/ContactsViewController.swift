import UIKit
import ContactsUI

class ContactsViewController: UIViewController, CNContactPickerDelegate {

    @IBOutlet weak var phoneNumberLabel: UILabel!

    fileprivate func presentContactPickerViewController() {
        let picker = CNContactPickerViewController()
        picker.delegate = self
        picker.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count > 0")
        picker.predicateForSelectionOfContact = NSPredicate(format: "phoneNumbers.@count == 1")
        picker.predicateForSelectionOfProperty = NSPredicate(format: "key == 'phoneNumbers'")
        picker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        present(picker, animated: true, completion: nil)
    }

    @IBAction func selectNumber(_ sender: Any) {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            presentContactPickerViewController()
        case .notDetermined:
            // TODO: Ask for permission
            let store = CNContactStore()
            store.requestAccess(for: .contacts) { [weak self] (granted, error) in
                if let error = error {
                    // TODO: Do shomething
                    print(error)
                    return
                }

                if granted {
                    self?.presentContactPickerViewController()
                }
            }
        case .denied:
            // TODO: Goto app's setting
            print("DENIED!!!!!")
            askToGotoAppSettings()
        case .restricted:
            // TODO: Ask your mom
            break
        }
    }

    fileprivate func askToGotoAppSettings() {
        let alertController = UIAlertController (title: "Title", message: "Go to Settings?", preferredStyle: .alert)

        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)") // Prints true
                    })
                } else {
                    UIApplication.shared.openURL(settingsUrl)
                }
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        phoneNumberLabel.text = contact.phoneNumbers.first?.value.stringValue
    }

    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
        guard let phoneNumber = contactProperty.value as? CNPhoneNumber else {
            phoneNumberLabel.text = "ที่เลือกมาไม่ใช่ CNPhoneNumber"
            return
        }

        phoneNumberLabel.text = phoneNumber.stringValue
    }

    @IBAction func swapViewController(_ sender: Any) {
        UIApplication.shared.keyWindow?.rootViewController = UIViewController()
    }

}
