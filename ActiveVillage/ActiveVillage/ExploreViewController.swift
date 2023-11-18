//
//  ExploreViewController.swift
//  ActiveVillage
//
//  Created by Christie beaubrun on 11/18/23.
//

import UIKit
import Foundation
import Nuke

struct Exercise: Codable {
    var name: String
    var imageURL: String

    // Ensure these keys match with the JSON response keys
    private enum CodingKeys: String, CodingKey {
        case name
        case imageURL = "image_url" // Example if the JSON key is "image_url"
    }
}


class ExploreViewController: UIViewController, UITableViewDataSource 
{
    var exercises: [Exercise] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        let exercise = exercises[indexPath.row]
        cell.textLabel?.text = exercise.name
        // You may need to download the image from exercise.imageURL asynchronously
        return cell
    }
    

    @IBOutlet weak var exploreTableView: UITableView!
    @IBOutlet weak var exploreImage: UIImageView!
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        exploreTableView.dataSource = self
        fetchDataFromAPI()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func fetchDataFromAPI() {
        // Replace "YOUR_PIXABAY_API_KEY" with your actual Pixabay API key
        let pixabayAPIKey = "40755370-d182d9127fd67f94758cfa5c3"
        let query = "fitness"
        
        let requestURLString = "https://pixabay.com/api/videos/?key=\(pixabayAPIKey)&q=\(query)"
        
        let request = NSMutableURLRequest(url: NSURL(string: requestURLString)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received.")
                return
            }
            
            do {
                // Decode the JSON response
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                // Process the JSON response (handle videos)
                if let videos = json?["hits"] as? [[String: Any]] {
                    var videoURLs: [String] = []
                    for video in videos {
                        if let videoURL = video["videos"] as? [String: Any],
                           let largeURL = videoURL["large"] as? String {
                            videoURLs.append(largeURL)
                        }
                    }
                    
                    // Use the video URLs as needed (update UI, etc.)
                    self.handleVideoURLs(videoURLs)
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        dataTask.resume()
    }

    // Example method to handle video URLs (update UI, etc.)
    func handleVideoURLs(_ videoURLs: [String]) {
        // Add your logic to handle the video URLs (e.g., update UI with videos)
        print("Video URLs: \(videoURLs)")
    }

}
