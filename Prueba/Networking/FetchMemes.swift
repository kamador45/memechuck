//
//  FetchMemes.swift
//  Prueba
//
//  Created by Kevin Amador Rios on 9/27/22.
//

import Foundation

class FetchMemes: ObservableObject {
    
    @Published var memesArray = [MemesModel]()
    
    //Define GCD
    let queue = DispatchQueue.global()
    @Published var isDownloading: Bool = false
    var debugInfo: Int = 0
    let request = URLSession.shared
    
    init() {
        
    }
    
    //FetchMemes
    func fetchMemes(completion:@escaping(MemesModel?) -> Void) {
        
        //Define url
        guard let url = URL(string: "https://api.chucknorris.io/jokes/random") else {return}
        
        queue.async {
            DispatchQueue.concurrentPerform(iterations: 15) { incr in
                //debug
                self.debugInfo += 1
                //Networking request to APIS
                self.request.dataTask(with: url) { data, response, error in
                    if let err = error {
                        print(err.localizedDescription)
                    } else {
                        do {
                            guard let data = data else {return}
                            
                            let json = try? JSONDecoder().decode(MemesModel.self, from: data)
                        
                            DispatchQueue.main.async {
                                completion(json)
                            }
                            
                            DispatchQueue.main.async {
                                self.isDownloading.toggle()
                            }
                            print("Debugin ===>\(json) \(self.debugInfo) \(incr)")
                            
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }.resume()
            }
        }
    }
    
}
