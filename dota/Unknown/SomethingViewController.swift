import UIKit.UITableViewController

class SomethingViewController: UITableViewController {

    var longBody: Something!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160

        longBody = Something(imageName: "", title: "this is long body title :) 🐶", body: "This is very very very longggggggggggg body :) 🌹🐭🐵 Naja.............................................................")

        let somethingNib = UINib(nibName: "SomethingCell", bundle: Bundle(for: SomethingCell.self))
        tableView.register(somethingNib, forCellReuseIdentifier: "SomethingCell")
        tableView.register(R.nib.anotherCell)

        tableView.separatorStyle = .none
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    fileprivate func generateSomethingCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SomethingCell", for: indexPath) as! SomethingCell
        cell.configureWith(SomethingViewModel(original: longBody))
        return cell
    }

    fileprivate func generateAnotherCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.anotherCell, for: indexPath)!
        return cell
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return generateSomethingCell(tableView, indexPath)
        default:
            return generateAnotherCell(tableView, indexPath)
        }
    }
}
