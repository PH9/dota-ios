import UIKit

class SomethingCell: UITableViewCell {

    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!

    var value: SomethingViewModel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureWith(_ value: SomethingViewModel) {
//        self.value = value

        leftImageView.image = value.image
        titleLabel.text = value.title
        bodyLabel.text = value.body
    }
}
