

import UIKit
import Parse

var hashtagNameText = ""
var currentHashtagObject :PFObject = PFObject(className: "Hashtag")

class setHashtagViewController: UIViewController {

    @IBOutlet weak var hashtagTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func setHashtagButton(sender: AnyObject) {
        hashtagNameText = hashtagTextField.text
        
        let query = PFQuery(className: "Hashtag")
        query.whereKey("hashtagName", equalTo: hashtagNameText)
        query.getFirstObjectInBackgroundWithBlock{
            (object :PFObject?, error: NSError?) -> Void in
            
            if object == nil{
                //NEW Hashtag
                println("new #")
                //println(object)
                //Create a new hashtag objecty
                currentHashtagObject["hashtagName"] = hashtagNameText
                currentHashtagObject.saveInBackgroundWithBlock{(success: Bool, error: NSError?) -> Void in
                    if(success){
                        println("New hashtag Saved")
                    } else{
                        println("failed to save a new hashtag =(")
                        println(error)
                    }
                    
                }
            }else{
                println("# already Exitsts")
               // println(object)
                currentHashtagObject = object!
               
                
            }
        }
        
    }
        
}
