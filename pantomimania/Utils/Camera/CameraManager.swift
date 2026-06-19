//
//  CameraManager.swift
//  POC-photos
//
//  Created by Vinicius Rodrigues de Castro on 01/06/26.
//

import AVFoundation
import UIKit
import Combine

@Observable class CameraManager: NSObject, AVCapturePhotoCaptureDelegate {
    private let session = AVCaptureSession()
    private let output = AVCapturePhotoOutput()
    private var previewLayer: AVCaptureVideoPreviewLayer?
    
    var capturedImage: UIImage?
    
    func startSession() {
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
              let input = try? AVCaptureDeviceInput(device: device),
              session.canAddInput(input),
              session.canAddOutput(output) else { return }
        
        previewLayer = getPreviewLayer()
        
        session.beginConfiguration()
        session.addInput(input)
        session.addOutput(output)
        session.commitConfiguration()
        session.startRunning()
    }
    
    func stopSession() {
        session.stopRunning()
        
        session.beginConfiguration()
        session.inputs.forEach { session.removeInput($0)}
        session.outputs.forEach { session.removeOutput($0)}
        session.commitConfiguration()
        
        previewLayer = nil
        capturedImage = nil
    }
    
    func getPreviewLayer() -> AVCaptureVideoPreviewLayer {
        if let layer = previewLayer {
            return layer
        } else {
            let layer = AVCaptureVideoPreviewLayer(session: session)
            layer.videoGravity = .resizeAspectFill
            previewLayer = layer
            return layer
        }
    }
    
    func takePhoto() {
        let settings = AVCapturePhotoSettings()
        output.capturePhoto(with: settings, delegate: self)
    }
}

extension CameraManager {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else { return }
        
        let orientation = UIDevice.current.orientation
        var imageOut: UIImage = UIImage()
        
        switch orientation {
        case .portrait:
            imageOut = UIImage(cgImage: cropImage(image: image.cgImage!), scale: 1.0, orientation: .right)
//            print("portrait")
        case .landscapeLeft:
            imageOut = UIImage(cgImage: cropImage(image: image.cgImage!), scale: 1.0, orientation: .down)
//            print("landscapeLeft")
        case .landscapeRight:
            imageOut = UIImage(cgImage: cropImage(image: image.cgImage!), scale: 1.0, orientation: .up)
//            print("landscapeRight")
        case .portraitUpsideDown:
            imageOut = UIImage(cgImage: cropImage(image: image.cgImage!), scale: 1.0, orientation: .left)
//            print("portraitUpsideDown")
        case .faceUp, .faceDown:
            imageOut = UIImage(cgImage: cropImage(image: image.cgImage!), scale: 1.0, orientation: .right)
//            print("faceUp, faceDown")
        default:
            imageOut = UIImage(cgImage: cropImage(image: image.cgImage!), scale: 1.0, orientation: .up)
//            print("default")
        }
        
        self.capturedImage = imageOut
    }
    
    func cropImage(image: CGImage) -> CGImage {
        let sideLength = min(
            image.width,
            image.height
        ) // Em teoria, como o app é pra ser sempre modo landscape, é pra sempre ser a altua
        
        let targetHeigth = sideLength
        let targetWidth = sideLength * 4 / 3
        
        let xOffset = (image.width - targetWidth) / 2
        let yOffset = (image.height - targetHeigth) / 2
        
        let cropRect = CGRect(
            x: xOffset,
            y: yOffset,
            width: targetWidth,
            height: targetHeigth
        ).integral
        
        let sourceCGImage = image
        return sourceCGImage.cropping(
            to: cropRect
        )!
    }
}



