import UIKit
import os.log
import ZXingObjC

class BarcodeScannerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var barcodeImageView: UIImageView!
    @IBOutlet weak var barcodeValueLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        barcodeImageView.isUserInteractionEnabled = true

        let tapToSelectPhoto = UITapGestureRecognizer(target: self, action: #selector(BarcodeScannerViewController.selectPhotoFromLibrary))
        barcodeImageView.addGestureRecognizer(tapToSelectPhoto)
    }

    @objc func selectPhotoFromLibrary() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }

        barcodeImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
}
