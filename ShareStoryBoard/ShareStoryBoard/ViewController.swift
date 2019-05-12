//
//  ViewController.swift
//  ShareStoryBoard
//
//  Created by 助永悠輝 on 2019/05/12.
//  Copyright © 2019 助永悠輝. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var image: UIImageView!
    @IBAction func callAPIButton(_ sender: UIButton) {
        let imageUrl = "https://3.bp.blogspot.com/-xldWJgF1gGk/W8hD-3zNpFI/AAAAAAABPhM/itwOYZLlTNMyN7EKL2yv2-rxzAYoLYASQCLcBGAs/s800/pet_dog_birthday_cake.png"
        let urlString: String = "http://wikipedia.simpleapi.net/api"
        getImage(urlString: imageUrl)
        callAPI(urlString: urlString)
    }

    public enum HTTPMethod: String{
        case options = "OPTIONS"
        case get     = "GET"
        case head    = "HEAD"
        case post    = "POST"
        case put     = "PUT"
        case patch   = "PATCH"
        case delete  = "DELETE"
        case trace   = "TRACE"
        case connect = "CONNECT"
    }
    
    struct Wiki: Codable{
        var title: String
        var body: String
    }
    func callAPI(urlString: String) {
        let parameters: Parameters = ["keyword": "Wiki", "output": "json"]
        Alamofire.request(urlString, method: .get, parameters: parameters).response {
            response in
            guard let data = response.data else {
                return
            }
            do {
                let json = try? JSONDecoder().decode([Wiki].self, from: data)
                self.textField.text = json![0].body
            } catch {
                print(error)
            }
        }
        
    }
    
    func getImage(urlString: String) {
        let url = URL(string: urlString)
        do {
            let data = try Data(contentsOf: url!)
            image.image = UIImage(data: data)
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

