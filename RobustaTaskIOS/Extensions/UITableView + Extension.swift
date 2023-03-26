import UIKit

extension UITableView{
    func register<Cell: UITableViewCell>(_ cellType: Cell.Type) {
        register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellReuseIdentifier: String(describing: Cell.self))
    }
    func dequeueCell<Cell: UITableViewCell>() -> Cell {
        return self.dequeueReusableCell(withIdentifier: String(describing: Cell.self)) as! Cell
    }
}
