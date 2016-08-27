//
//  Camera.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2016-06-12.
//  Copyright © 2016 Andy Cho. All rights reserved.
//

import AVFoundation

class Camera: NSObject {
    /// The last image captured from the camera
    private var cameraImage: UIImage?
    /// Keep a reference to the session so it doesn't get deallocated
    private var captureSession: AVCaptureSession?

    /**
     Create a Camera instance and start streaming from the front facing camera
     */
    override init() {
        super.init()
        setupCamera()
    }

    /**
     Get a snapshot from the front facing camera

     - returns: The most recent image from the camera, if one exists
     */
    func takePhoto() -> UIImage? {
        return cameraImage
    }

    // MARK: - Private methods

    /**
     Start streaming from the front facing camera
     */
    private func setupCamera() {
        guard let camera = getFrontFacingCamera() else {
            Logger.error("Front facing camera not found")
            return
        }
        guard let input = try? AVCaptureDeviceInput(device: camera) else {
            Logger.error("Could not get the input stream for the camera")
            return
        }
        let output = createCameraOutputStream()
        captureSession = createCaptureSession(input, output: output)
        captureSession?.startRunning()
    }

    /**
     Get the front facing camera, if one exists

     - returns: The front facing camera, an AVCaptureDevice, or `nil` if none exists.
     */
    private func getFrontFacingCamera() -> AVCaptureDevice? {
        let devices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        for device in devices {
            if device.position == AVCaptureDevicePosition.Front {
                return device as? AVCaptureDevice
            }
        }
        return nil
    }

    /**
     Create a stream for the camera output

     - returns: A camera output stream
     */
    private func createCameraOutputStream() -> AVCaptureVideoDataOutput {
        let queue = dispatch_queue_create("cameraQueue", nil)
        let output = AVCaptureVideoDataOutput()
        output.alwaysDiscardsLateVideoFrames = true
        output.setSampleBufferDelegate(self, queue: queue)

        let key = kCVPixelBufferPixelFormatTypeKey as NSString
        let value = NSNumber(unsignedInt: kCVPixelFormatType_32BGRA)
        let videoSettings = NSDictionary(object: value, forKey: key) as [NSObject: AnyObject]
        output.videoSettings = videoSettings

        return output
    }

    /**
     Create a photo capture session from the camera input and output streams

     - parameter input:  A camera input stream
     - parameter output: A camera output stream

     - returns: An AVCaptureSession that has not yet been started
     */
    private func createCaptureSession(input: AVCaptureDeviceInput, output: AVCaptureVideoDataOutput) -> AVCaptureSession {
        let captureSession = AVCaptureSession()
        captureSession.addInput(input)
        captureSession.addOutput(output)
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        captureSession.startRunning()
        return captureSession
    }

}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate

extension Camera: AVCaptureVideoDataOutputSampleBufferDelegate {

    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        cameraImage = createImageFromBuffer(imageBuffer)
    }

    /**
     Create a UIImage instance from a CVImageBuffer

     - parameter buffer: An instance of a CVImageBuffer

     - returns: An UIImage instance if one could be created, nil otherwise
     */
    private func createImageFromBuffer(buffer: CVImageBuffer) -> UIImage? {
        CVPixelBufferLockBaseAddress(buffer, 0)
        defer {
            CVPixelBufferUnlockBaseAddress(buffer, 0)
        }

        let baseAddress = CVPixelBufferGetBaseAddress(buffer)
        let bytesPerRow = CVPixelBufferGetBytesPerRow(buffer)
        let width = CVPixelBufferGetWidth(buffer)
        let height = CVPixelBufferGetHeight(buffer)
        let colorSpace = CGColorSpaceCreateDeviceRGB()

        let newContext = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace, CGBitmapInfo.ByteOrder32Little.rawValue | CGImageAlphaInfo.PremultipliedFirst.rawValue)
        guard let newImage = CGBitmapContextCreateImage(newContext) else {
            return nil
        }

        return UIImage(CGImage: newImage, scale: 1.0, orientation: getPhotoOrientation())
    }

    private func getPhotoOrientation() -> UIImageOrientation {
        switch UIDevice.currentDevice().orientation {
        case .LandscapeLeft:
            return .DownMirrored
        case .LandscapeRight:
            return .UpMirrored
        case .Portrait:
            return .LeftMirrored
        case .PortraitUpsideDown:
            return .RightMirrored
        default:
            return .RightMirrored
        }
    }

}
