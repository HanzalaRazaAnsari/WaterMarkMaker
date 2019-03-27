//
//  ViewController.swift
//  WaterMark Maker
//
//  Created by Mac on 10/15/18.
//  Copyright © 2018 com.lss.pk. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos
extension UIView {
    
    /// Create snapshot
    ///
    /// - parameter rect: The `CGRect` of the portion of the view to return. If `nil` (or omitted),
    ///                   return snapshot of the whole view.
    ///
    /// - returns: Returns `UIImage` of the specified portion of the view.
    
    func snapshot(of rect: CGRect? = nil) -> UIImage? {
        // snapshot entire view
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let wholeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // if no `rect` provided, return image of whole view
        
        guard let image = wholeImage, let rect = rect else { return wholeImage }
        
        // otherwise, grab specified `rect` of image
        
        let scale = image.scale
        let scaledRect = CGRect(x: rect.origin.x * scale, y: rect.origin.y * scale, width: rect.size.width * scale, height: rect.size.height * scale)
        guard let cgImage = image.cgImage?.cropping(to: scaledRect) else { return nil }
        return UIImage(cgImage: cgImage, scale: scale, orientation: .up)
    }
    
}

class ViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource ,UIImagePickerControllerDelegate , UINavigationControllerDelegate , UITextFieldDelegate{

    @IBOutlet weak var waterMarkLabel: UILabel!
    @IBOutlet weak var addImageOutlet: UIButton!
    @IBOutlet weak var addTextfieldOutlet: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageCollection: UICollectionView!
    @IBOutlet weak var movableTextfield: UITextField!
    @IBOutlet weak var saveButtonOutlet: UIBarButtonItem!
    
    var galleryImage = [UIImage]()
    var imagesArray = [UIImageView]()
    @IBAction func saveImage(_ sender: UIBarButtonItem) {
        for item in galleryImage{
        let image = UIImageView(image: item)
            self.imagesArray.append(image)


        }
        
//        waterMarkLabel.center = location
//        var anotherArray = [UIImageView]()
//
//        for item1 in imagesArray{
//            let label1 = UILabel()
//            label1.text = waterMarkLabel.text
////            label1.center = location
////            waterMarkLabel.frame(forAlignmentRect: )
//            item1.addSubview(label1)
//            anotherArray.append(item1)
//
//        }
//        print(galleryImage.count)
//        for item2 in anotherArray{
//
//
//            item2.frame = CGRect(x: 0, y: 0, width: imageView.bounds.width , height: imageView.bounds.height)
//            let rect = CGRect(x: location.x - waterMarkLabel.frame.width/2, y: location.y, width: waterMarkLabel.frame.width, height: waterMarkLabel.frame.height)
////            waterMarkLabel.backgroundColor = UIColor.clear
            waterMarkLabel.layer.borderColor = UIColor.black.cgColor
            waterMarkLabel.layer.borderWidth = 2.0;
////            waterMarkLabel.frame(forAlignmentRect: rect)
////            waterMarkLabel.bounds = waterMarkLabel.frame(forAlignmentRect: rect)
//
////            waterMarkLabel.center = labelPoint
//            waterMarkLabel.center = location
//
////            print("Here it is \(transitio
//            UIGraphicsBeginImageContextWithOptions(imageView.frame.size, false, 0);
//
//            item2.layer.render(in: UIGraphicsGetCurrentContext()!)
////            var point = CGRect(origin: location, size:waterMarkLabel.bounds.size)
//            waterMarkLabel.layer.render(in: UIGraphicsGetCurrentContext()!)
//           let imageWithLabel = UIGraphicsGetImageFromCurrentImageContext() // here is final image
////
//            UIGraphicsEndImageContext();
////
//
//
//            UIImageWriteToSavedPhotosAlbum(imageWithLabel! , self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        for item in galleryImage{
            self.imageView.image = item
              UIImageWriteToSavedPhotosAlbum(  self.view.snapshot(of: CGRect(x: 0.0, y: 64.0, width: 375.0, height: 506))!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
            
        }

        
        
 
        
//        }
        
        
        
        
        saveButtonOutlet.isEnabled = false

    }
    
    
    
//    let gestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
//    someDraggableView.addGestureRecognizer(gestureRecognizer)
    func handlePan(gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began {
            print("Hanzala")
            // When the drag is first recognized, you can get the starting coordinates here
        }
        
        if gestureRecognizer.state == .changed {
            let translation = gestureRecognizer.translation(in: self.view)
            // Translation has both .x and .y values
            print("Raza")
        }
    }
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("handlePan:"))
        imageView.addGestureRecognizer(gestureRecognizer)

        location = recognizer.location(in: self.imageView)
//        var a = recognizer.location(ofTouch: recognizer.la, in: <#T##UIView?#>)
        print(location)
        
        let translation = recognizer.translation(in: self.imageView)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.imageView)
//        print(translation)
    }

    
    @IBAction func addImage(_ sender: Any) {

        let vc = BSImagePickerViewController()
        vc.maxNumberOfSelections = 40

        bs_presentImagePickerController(vc, animated: true,
                                        select: { (asset: PHAsset) -> Void in
                                            print("Selected: \(asset)")
        }, deselect: { (asset: PHAsset) -> Void in
            print("Deselected: \(asset)")
        }, cancel: { (assets: [PHAsset]) -> Void in
            print("Cancel: \(assets)")
        }, finish: { (assets: [PHAsset]) -> Void in

            for item in assets{
                
                let image =  self.getAssetThumbnail(asset: item)
//                let a = self.getAssetThumbnail(asset: <#T##PHAsset#>)
                
                self.galleryImage.append(image)
            }
            print("Gallery Image",self.galleryImage.count)
            DispatchQueue.main.async {
                self.imageCollection.reloadData()
                self.imageView.image = self.galleryImage.first

            }
        }, completion: nil)
       
        
        addImageOutlet.isHidden = true
        addTextfieldOutlet.isEnabled = true
        addTextfieldOutlet.isEnabled = true
        saveButtonOutlet.isEnabled = true

    }
 
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 375, height: 506), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        
        return thumbnail

    }
    

    override func viewWillAppear(_ animated: Bool) {
//          waterMarkLabel.sizeToFit()
    }
    @IBAction func addTextfield(_ sender: Any) {
        
        movableTextfield.isHidden = false
        addTextfieldOutlet.isEnabled = false
        self.performSegue(withIdentifier: "new", sender: self)
        
    }
    var location = CGPoint(x: 0, y: 0)

let appdelegate = UIApplication.shared.delegate as! AppDelegate
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        movableTextfield.delegate = self
        imageCollection.dataSource = self
        imageCollection.delegate = self
        movableTextfield.isHidden = true
        addTextfieldOutlet.isEnabled = false
        movableTextfield.center = CGPoint(x: 160, y: 330)
        self.movableTextfield.isHidden = true
        saveButtonOutlet.isEnabled = false
        
//        print("value \(translation)")
        
        
    }
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        if appdelegate.newData == ""{
            self.waterMarkLabel.text = ""
            
            
        }else {
            
            self.waterMarkLabel.text = appdelegate.newData
            self.waterMarkLabel.font = appdelegate.fontSize
            self.waterMarkLabel.textColor = appdelegate.fontColour
            self.waterMarkLabel.sizeToFit()
        }
    }
    
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your Watermarked image(s) has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.galleryImage.removeAll()
                self.addImageOutlet.isEnabled = true
                self.saveButtonOutlet.isEnabled = false
                self.addTextfieldOutlet.isEnabled = false
                
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: "ViewController")
//                var viewcontrollers = self.navigationController!.viewControllers
//                viewcontrollers.removeLast()
//                viewcontrollers.append(vc)
//                self.navigationControllers?.setViewControllers(viewcontrollers, animate: true)
//                self.addImageOutlet.isHidden = false
//            self.imageView.isHidden = true
                
//                let storyboard = UIStoryboard(name: "MyStoryboardName", bundle: nil)
//                self.window.rootViewController = storyboard.instantiateInitialViewController()
            }))
            present(ac, animated: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imageView.image = self.galleryImage[indexPath.row]
//        let selectedCell = collectionView.cellForItem(at: indexPath) as! ImageCell
//        imageView.image = selectedCell.collectionViewImage.image
//         waterMarkLabel.center = location
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return galleryImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.collectionViewImage.image = galleryImage[indexPath.item]
        return cell
}
 

    func captureView() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false,UIScreen.main.scale)//add this line
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        self.imageView.layer.render(in: context)
        let img: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return img
    }
//    func restartApplication () {
//        let viewController =
//        let navCtrl = UINavigationController(rootViewController: viewController)
//
//        guard
//            let window = UIApplication.shared.keyWindow,
//            let rootViewController = window.rootViewController
//            else {
//                return
//        }
//
//        navCtrl.view.frame = rootViewController.view.frame
//        navCtrl.view.layoutIfNeeded()
//
//        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
//            window.rootViewController = navCtrl
//        })
//
//    }
}


