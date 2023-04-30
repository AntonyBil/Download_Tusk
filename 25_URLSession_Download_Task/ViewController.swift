//
//  ViewController.swift
//  25_URLSession_Download_Task
//
//  Created by apple on 30.04.2023.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var downloadImageView: UIImageView!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var progresLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func downloadButtonTapped(_ sender: UIButton) {
        
        progresLabel.isHidden = false
        let urlString = "https://d17fnq9dkz9hgj.cloudfront.net/breed-uploads/2018/08/rottweiler-card-small.jpg?bust=1535568036"
        guard let url = URL(string: urlString) else {
            print("This is an invalid URL")
            return
        }
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        session.downloadTask(with: url).resume()
    }
}

extension ViewController: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let data = try? Data(contentsOf: location) else {
            print("The data could not be loaded")
            return
        }
        let image = UIImage(data: data)
        downloadImageView.image = image
        downloadImageView.contentMode = .scaleAspectFit
        progresLabel.isHidden = true
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progres = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        
        progressBar.progress = progres
        progresLabel.text = "\(progres * 100)%"
        print("The progres is: \(progres)")
    }
    
    
}
