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
    }
    
    
    @IBAction func originalTapped(_ sender: Any) {
        Original()
    }
    
    
    var context = CIContext(options: nil)
    var startingImage : UIImage = UIImage()
    
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
        
        let currentFilter = CIFilter(name: "CIColorMatrix")
        
        let r:CGFloat = 1
        let g:CGFloat = 0
        let b:CGFloat = 0
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveOriginal ()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

