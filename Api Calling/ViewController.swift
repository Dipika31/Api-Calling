//
//  ViewController.swift
//  Api Calling
//
//  Created by Choudhary Dipika on 17/03/23.
//

import UIKit
import Alamofire

struct GetApi: Codable
{
    var userId : Int
    var id : Int
    var title : String
    var body : String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    var arr : [GetApi] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
      getData() 
    }
    
//    func getData()
//    {
//        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
//        var ur = URLRequest(url: url!)
//        ur.httpMethod = "GET"  
//
//        URLSession.shared.dataTask(with: ur) { data, response, error in
//            do
//            {
//                if error == nil
//                {
//                    self.arr = try JSONDecoder().decode([GetApi].self, from: data!)
//                    print(self.arr)
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
//                }
//            }
//            catch
//            {
//                print(error.localizedDescription)
//            }
//        }.resume()
//    }
    
    func getData()
    {
        AF.request("https://jsonplaceholder.typicode.com/posts", method: .get).responseData { respo in
            switch respo.result
            {
            case .success(let data):
                do
                {
                    if data == respo.value
                    {
                        self.arr = try JSONDecoder().decode([GetApi].self, from: data)
                        print(self.arr)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
                catch
                {
                    print(error.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.label1.text = "\(arr[indexPath.row].userId)"
        cell.label2.text = arr[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

