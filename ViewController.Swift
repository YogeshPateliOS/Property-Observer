import UIKit

struct UserModel: Equatable{
    var name: String = ""
    
    init(name: String){
        self.name = name
    }
}


class ViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        tableView.dataSource = self
        return tableView
    }()
    
    var arrData: [UserModel] = []{
        didSet{
            if (self.arrData != oldValue){
                tableView.reloadData()
            }
        }
        willSet(newValue){
            self.arrData = newValue
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let addUser = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addUserClick))
        self.navigationItem.rightBarButtonItem = addUser
    }
    
    @objc
    func addUserClick(){
        let alertVC = UIAlertController(title: "Add User", message: nil, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_) in
            let name = alertVC.textFields?.first?.text ?? "No User"
            self.arrData.append(UserModel(name: name))
        }))
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertVC.addTextField { (Selftextfield) in
            Selftextfield.placeholder = "Enter username"
        }
        self.navigationController?.present(alertVC, animated: true)
    }

}

extension ViewController: UITableViewDataSource{
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = arrData[indexPath.row].name
        return cell!
    }
}


