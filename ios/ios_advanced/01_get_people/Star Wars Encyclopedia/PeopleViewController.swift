//
//  ViewController.swift
//  Star Wars Encyclopedia
//
//  Created by Yung Kim on 7/14/16.
//  Copyright © 2016 Yung Kim. All rights reserved.
//

import UIKit

class PeopleViewController: UITableViewController {
    
    // Specify the url that we will be sending the GET Request to
    var url = NSURL(string: "http://swapi.co/api/people/")
    var next_url: String = ""
    
    // Hardcoded data for now
//    var people = ["Luke Skywalker", "Leia Organa", "Han Solo", "C-3PO", "R2-D2"]
    var people: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        print(next_url)
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the count of people
        return people.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Create a generic cell
        let cell = UITableViewCell()
        // set the default cell label to the corresponding element in the people array
        cell.textLabel?.text = people[indexPath.row]
        // return the cell so that it can be rendered
        return cell
    }
    func getData() {
        
        // Create an NSURLSession to handle the request tasks
        let session = NSURLSession.sharedSession()
        // Create a "data task" which will request some data from a URL and then run a completion handler after it is done
        print(url!)

        let task = session.dataTaskWithURL(url!, completionHandler: {
            data, response, error in
            // We get data, response, and error back. Data contains the JSON data, Response contains the headers and other information about the response, and Error contains an error if one occured
            // A "Do-Try-Catch" block involves a try statement with some catch block for catching any errors thrown by the try statement.
            do {
                // Try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                    print(jsonResult)
                    
                    if let results = jsonResult["results"] {
                        // coercing the results object as an NSArray and then storing that in resultsArray
                        let resultsArray = results as! NSArray

                        for i in 1...resultsArray.count {
                            let person = resultsArray[i-1].valueForKey("name")!
                            self.people.append(person as! String)
                        }
                        print(jsonResult["next"])
                        self.tableView.reloadData()
                        
                    }
                }
                
            } catch {
                print("Something went wrong")
            }
        })
        // Actually "execute" the task. This is the line that actually makes the request that we set up above
        task.resume()

    }
    
}