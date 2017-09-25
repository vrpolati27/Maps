//
//  GalleryViewController.swift
//  Maps
//
//  Created by Vinay Reddy Polati on 9/22/17.
//  Copyright © 2017 m1m2Solutions. All rights reserved.
//

import UIKit;

class GalleryViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    var activityIndicator:UIActivityIndicatorView?;
    @IBAction func editButtonAction(_ sender: Any) {
        let ac = UIAlertController(title: "Edit your profile picture", message: " Select from below if you want to import from gallery or take new picture", preferredStyle: .alert);
        ac.addAction(UIAlertAction(title: "Import from Gallery", style: .default, handler: { (action) in
            print("user has decided to import a photo from Gallery.");
            /* seque to Gallery ViewController.*/
            let ipc = UIImagePickerController();
            ipc.delegate = self;
            ipc.sourceType = .photoLibrary;
            ipc.allowsEditing = true;
            ac.dismiss(animated: true, completion: nil);
            self.present(ipc, animated: true, completion: nil);
        })   )
        
        
        ac.addAction(UIAlertAction(title: "cancel", style: .destructive, handler: { (action) in
            print("user has decided not to Edit profile picture");
            ac.self.dismiss(animated: true, completion: nil);
        })   )
        
        self.present(ac, animated: true, completion: nil);
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.profileImageView.image = image;
        } else {
            print(" Error retrieving image. ");
        }
        self.dismiss(animated: true, completion: nil);
    }
    
    
    
    @IBAction func freezeAction(_ sender: Any) {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50) );
        activityIndicator?.center = self.view.center;
        activityIndicator?.hidesWhenStopped = true;
        activityIndicator?.activityIndicatorViewStyle = .gray;
        view.addSubview(activityIndicator!);
        
        activityIndicator?.startAnimating();
        UIApplication.shared.beginIgnoringInteractionEvents();
   /*     for c1 in 1...18{
            print("I am in For loop. \(c1)");
        }
        activityIndicator?.stopAnimating();
        UIApplication.shared.endIgnoringInteractionEvents(); */
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
