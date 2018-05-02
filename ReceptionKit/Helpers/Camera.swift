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
    fileprivate var cameraImage: UIImage?
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
        captureSession = createCaptureSession(input: input, output: output)
        captureSession?.startRunning()
    }

    /**
     Get the front facing camera, if one exists

     - returns: The front facing camera, an AVCaptureDevice, or `nil` if none exists.
     */
    private func getFrontFacingCamera() -> AVCaptureDevice? {
        return AVCaptureDevice.devices(for: AVMediaType.video)
            .compactMap { device in
                if device.position == AVCaptureDevice.Position.front {
                    return device
                }
                return nil
            }
            .first
    }

    /**
     Create a stream for the camera output

     - returns: A camera output stream
     */
    private func createCameraOutputStream() -> AVCaptureVideoDataOutput {
        let queue = DispatchQueue(label: "cameraQueue", attributes: [])
        let output = AVCaptureVideoDataOutput()
        output.alwaysDiscardsLateVideoFrames = true
        output.setSampleBufferDelegate(self, queue: queue)

        let key = kCVPixelBufferPixelFormatTypeKey as NSString
        let value = NSNumber(value: kCVPixelFormatType_32BGRA as UInt32)
        output.videoSettings = [key as String: value]

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
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        captureSession.startRunning()
        return captureSession
    }

}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate

extension Camera: AVCaptureVideoDataOutputSampleBufferDelegate {

    func captureOutput(_ captureOutput: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
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
    private func createImageFromBuffer(_ buffer: CVImageBuffer) -> UIImage? {
        let noOption = CVPixelBufferLockFlags(rawValue: CVOptionFlags(0))

        CVPixelBufferLockBaseAddress(buffer, noOption)
        defer {
            CVPixelBufferUnlockBaseAddress(buffer, noOption)
        }

        let baseAddress = CVPixelBufferGetBaseAddress(buffer)
        let bytesPerRow = CVPixelBufferGetBytesPerRow(buffer)
        let width = CVPixelBufferGetWidth(buffer)
        let height = CVPixelBufferGetHeight(buffer)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue

        let newContext = CGContext(
            data: baseAddress,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: bytesPerRow,
            space: colorSpace,
            bitmapInfo: bitmapInfo)
        guard let newImage = newContext?.makeImage() else {
            return nil
        }

        return UIImage(cgImage: newImage, scale: 1.0, orientation: getPhotoOrientation())
    }

    private func getPhotoOrientation() -> UIImageOrientation {
        switch UIDevice.current.orientation {
        case .landscapeLeft:
            return .downMirrored
        case .landscapeRight:
            return .upMirrored
        case .portrait:
            return .leftMirrored
        case .portraitUpsideDown:
            return .rightMirrored
        default:
            return .rightMirrored
        }
    }

}
