//
//  ViewController.swift
//  imageFilters
//
//  Created by Neil Clavin on 04/11/2017.
//  Copyright © 2017 Neil Clavin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var originalImage: UIImageView!
    
    @IBAction func filterTapped(_ sender: Any) {
        RGB()
        //Blend()
        
    }
    
    
    @IBOutlet weak var stateSwitch: UISwitch!
    
    @IBOutlet weak var stateSwitchG: UISwitch!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func originalTapped(_ sender: Any) {
        Original()
    }
    
    
    var context = CIContext(options: nil)
    var startingImage : UIImage = UIImage()
    
    // RGB default values
    var rValue = 1
    var gValue = 1
    var bValue = 1
    var aValue = 1
    
    
    func saveOriginal () {
        // capturing original
        startingImage = originalImage.image!
        var inputImage = CIImage(image: originalImage.image!)!
        let options:[String : AnyObject] = [CIDetectorImageOrientation:1 as AnyObject]
        let filters = inputImage.autoAdjustmentFilters(options: options)
        
        for filter: CIFilter in filters {
            filter.setValue(inputImage, forKey: kCIInputImageKey)
            inputImage =  filter.outputImage!
        }
        let cgImage = context.createCGImage(inputImage, from: inputImage.extent)
        self.originalImage.image =  UIImage(cgImage: cgImage!)
        
    }
    
    func Tint() {
        //let templateImage = originalImage.imageWithRenderingMode(UIImageRenderingModeAlwaysTemplate)
        let templateImage = originalImage.image!.withRenderingMode(.alwaysTemplate)
        originalImage.image = templateImage
        originalImage.tintColor = UIColor.red
        
        //originalImage.image = startingImage
    }
    
    func RGB() {
        // filter logic
       
       Original()
        
        let currentFilter = CIFilter(name: "CIColorMatrix")
        
        var r = CGFloat(rValue)
        print(r)
        
        var g = CGFloat(gValue)
        print("G:\(g)G")
        let b:CGFloat = 1
        let a:CGFloat = 1.0
        //tintColor.getRed(&r, green:&g, blue:&b, alpha:&a)
        
        currentFilter!.setValue(CIImage(image: originalImage.image!), forKey: "inputImage")
        currentFilter!.setValue(CIVector(x:r, y:0, z:0, w:0), forKey:"inputRVector")
        currentFilter!.setValue(CIVector(x:0, y:g, z:0, w:0), forKey:"inputGVector")
        currentFilter!.setValue(CIVector(x:0, y:0, z:b, w:0), forKey:"inputBVector")
        currentFilter!.setValue(CIVector(x:0, y:0, z:0, w:a), forKey:"inputAVector")
      
        let output = currentFilter!.outputImage
        let cgimg = context.createCGImage(output!,from: output!.extent)
        let processedImage = UIImage(cgImage: cgimg!)
        originalImage.image = processedImage
    }
    
    func rChannel() {
        rValue = 1
    }
    
    func Blend() {
        // filter logic
        
        let currentFilter = CIFilter(name: "CIScreenBlendMode")
        
        
        currentFilter!.setValue(CIImage(image: originalImage.image!), forKey: kCIInputImageKey)
        let output = currentFilter!.outputImage
        let cgimg = context.createCGImage(output!,from: output!.extent)
        let processedImage = UIImage(cgImage: cgimg!)
        originalImage.image = processedImage
    }
    
    
    
    func Noir() {
        
        
        
        
        // filter logic
        
        let currentFilter = CIFilter(name: "CIPhotoEffectNoir")
        
       
        currentFilter!.setValue(CIImage(image: originalImage.image!), forKey: kCIInputImageKey)
        let output = currentFilter!.outputImage
        let cgimg = context.createCGImage(output!,from: output!.extent)
        let processedImage = UIImage(cgImage: cgimg!)
        originalImage.image = processedImage
    }
    
    func Original(){
        originalImage.image = startingImage
    }
    
    
    
    @objc func stateChanged(switchState: UISwitch) {
        if switchState.isOn {
            
            rValue = 1
            textField.text = "1"
        } else {
            
            rValue = 0
            textField.text = "0"
        }
        RGB()
    }
    
    
    @objc func stateChangedG(switchStateG: UISwitch) {
        if switchStateG.isOn {

            gValue = 1
            //textField.text = "1"
        } else {

            gValue = 0
            //textField.text = "0"
        }
        RGB()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveOriginal ()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set up switch state
         stateSwitch.addTarget(self, action: #selector(stateChanged), for: UIControlEvents.valueChanged)
        stateSwitchG.addTarget(self, action: #selector(stateChangedG), for: UIControlEvents.valueChanged)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

