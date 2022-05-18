//
//  SchoolViewModel.swift
//  SummerSchool
//
//  Created by Juan Carlos Sánchez Gutiérrez on 17/05/22.
//

import Foundation

class SchoolViewModel: ObservableObject {
    
    @Published var availableGroups: [Group] = []
    
    func getGroups() {
        
        guard let url = URL(string: "http://192.168.1.71:8080/disponiblidad") else {fatalError()}
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, resp, error) in
            
            if let error = error {
                print("Error took place \(error)")
                return
            }
            guard let data = data else {
                print("No hubo datos")
                return
            }
            
            do {
                
                let finalResponse = try JSONDecoder().decode(GroupsResponse.self, from: data)
                DispatchQueue.main.async {
                    self.availableGroups =  finalResponse
                }
                
            } catch let jerror {
                print(jerror)
            }
            
        }
        dataTask.resume()
        
    }
    
    func enrollStudent(body: Student,subject: String, completion: @escaping (CompletionResult) -> () ) {
        
        guard let url = URL(string: "http://192.168.1.71:8080/alumnos?curso=\(subject)") else {fatalError()}
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try! JSONEncoder().encode(body)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, resp, error) in
            
            if let error = error {
                print("Error took place \(error)")
                return
            }
            guard let data = data else {
                print("No hubo datos")
                return
            }
            
            do {
                let httpResponse = resp as? HTTPURLResponse
                if httpResponse?.statusCode == 201 {
                    let finalResponse = try JSONDecoder().decode(Student.self, from: data)
                    DispatchQueue.main.async {
                        print(finalResponse.matricula)
                        completion(CompletionResult(errorStatus: true, errorMessage: ""))
                    }
                } else {
                    let finalResponse = try JSONDecoder().decode(PostResponse.self, from: data)
                    DispatchQueue.main.async {
                        print(finalResponse.mensaje)
                        completion(CompletionResult(errorStatus: false, errorMessage: finalResponse.mensaje))
                    }
                }
                
            } catch let jerror {
                print(jerror)
                completion(CompletionResult(errorStatus: false, errorMessage: "Error con servidor"))
            }
            
        }
        dataTask.resume()
        
    }
    
    
    
}
