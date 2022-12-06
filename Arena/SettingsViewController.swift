//
//  SettingsViewController.swift
//  Arena
//
//  Created by Aram Baali on 11/10/22.
//

import Foundation
import AVFoundation
import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct ColorComponents {
    var r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat
}

extension UIColor {
    func getComponents() -> ColorComponents {
        if (cgColor.numberOfComponents == 2) {
          let cc = cgColor.components!
          return ColorComponents(r:cc[0], g:cc[0], b:cc[0], a:cc[1])
        }
        else {
          let cc = cgColor.components!
          return ColorComponents(r:cc[0], g:cc[1], b:cc[2], a:cc[3])
        }
    }

    func interpolateRGBColorTo(end: UIColor, fraction: CGFloat) -> UIColor {
        var f = max(0, fraction)
        f = min(1, fraction)

        let c1 = self.getComponents()
        let c2 = end.getComponents()

        let r = c1.r + (c2.r - c1.r) * f
        let g = c1.g + (c2.g - c1.g) * f
        let b = c1.b + (c2.b - c1.b) * f
        let a = c1.a + (c2.a - c1.a) * f

        return UIColor.init(red: r, green: g, blue: b, alpha: a)
    }
}

public var masterPride: UIColor = UIColor.white

class SettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var soundEffectSwitch: UISwitch!
    @IBOutlet weak var stayLoggedInSwitch: UISwitch!
    @IBOutlet weak var profilePicImage: UIImageView!
    let picker = UIImagePickerController()
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var displayName: UITextField!
    @IBOutlet weak var phone: UITextField!
    let kUserSoundEffectsID = "soundEffectsID"
    let kUserLoggedInID = "loggedInID"
    let kUserFullNameID = "fullNameID"
    let kUserPhoneID = "phoneID"
    let defaults = UserDefaults.standard
    @IBOutlet weak var prideSlider: UISlider!
    
    var pride: UIColor! {
        didSet {
            view.backgroundColor = pride
            masterPride = pride
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        profilePicImage.addGestureRecognizer(tapGR)
        profilePicImage.isUserInteractionEnabled = true
        let retrievedSoundEffect = self.defaults.string(forKey: kUserSoundEffectsID)
        if retrievedSoundEffect == "On" {
            soundEffectSwitch.setOn(true, animated: false)
        } else {
            soundEffectSwitch.setOn(false, animated: false)
        }
        let retrievedLoggedIn = self.defaults.string(forKey: kUserLoggedInID)
        if retrievedLoggedIn == "On" {
            stayLoggedInSwitch.setOn(true, animated: false)
        } else {
            stayLoggedInSwitch.setOn(false, animated: false)
        }
        displayName.text = self.defaults.string(forKey: kUserFullNameID)
        phone.text = self.defaults.string(forKey: kUserPhoneID)
        
    }
    
    @IBAction func soundEffectSwitchClicked(_ sender: UISwitch) {
        if sender.isOn {
            defaults.set("On", forKey: kUserSoundEffectsID)
        } else {
            defaults.set("Off", forKey: kUserSoundEffectsID)
        }
    }
    
    @IBAction func stayLoggedInSwitchClicked(_ sender: UISwitch) {
        if sender.isOn {
            defaults.set("On", forKey: kUserLoggedInID)
        } else {
            defaults.set("Off", forKey: kUserLoggedInID)
        }
    }
    
    @IBAction func updateButton(_ sender: Any) {
        defaults.set(displayName.text, forKey: kUserFullNameID)
        defaults.set(phone.text, forKey: kUserPhoneID)
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true)
        } catch {
            print("error logging out")
        }
    }
    
    // Handles when the profile picture is tapped
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        // Give option between camera roll or camera
            if sender.state == .ended {
                let controller = UIAlertController(
                    title: "Select Profile Picture",
                    message: "",
                    preferredStyle: .actionSheet)
                
                let LibraryAction = UIAlertAction(
                    title: "Photo Library",
                    style: .default,
                    handler: {
                        (action) in
                        self.picker.allowsEditing = false
                        self.picker.sourceType = .photoLibrary
                        self.present(self.picker, animated: true)
                    })
                controller.addAction(LibraryAction)
                
                let cameraAction = UIAlertAction(
                    title: "Camera",
                    style: .default,
                    handler: {
                        (action) in
                        self.picker.allowsEditing = false
                        self.picker.sourceType = .camera
                        self.picker.cameraCaptureMode = .photo
                        self.present(self.picker, animated: true)
                    })
                controller.addAction(cameraAction)
                
                let cancelAction = UIAlertAction(
                    title: "Cancel",
                    style: .cancel,
                    handler: {
                        (action) in return
                    })
                controller.addAction(cancelAction)
                
                present(controller, animated: true)
            }
    }
    
    // When an item is selected from the picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info [.originalImage] as! UIImage
        // Change profile pic image
        profilePicImage.image = chosenImage
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    @IBAction func prideSliderValueChanged(_ sender: Any) {
        let ratio = CGFloat(prideSlider.value / 100)
        let colorWhite = UIColor.white
        let colorBurnt = UIColor(red: (190 / 255), green: (90 / 255), blue: 0.000, alpha: 1.00)
        pride = colorWhite.interpolateRGBColorTo(end: colorBurnt, fraction: ratio)
    }
}
