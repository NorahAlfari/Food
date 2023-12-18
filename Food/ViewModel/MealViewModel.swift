//
//  MealViewModel.swift
//  Food
//
//  Created by Norah Alfari on 01/06/1445 AH.
//

import Foundation

class MealViewModel: ObservableObject{
    
    @Published var meal: [MealModel] = []
    
    
    init() {
        fetch(restaurantId: UUID())
        
    }
   
    
    func fetch(restaurantId: UUID){
        let url = URL(string: "https://yysvzirbkgoxlixxujkf.supabase.co/rest/v1/meal?restaurant=eq.\(restaurantId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // Set your headers here
        request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl5c3Z6aXJia2dveGxpeHh1amtmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI2NDEyMDUsImV4cCI6MjAxODIxNzIwNX0.lMSfr3k0gTctNAZpz7UbOuSDIbGDEmZ_ZFI_idZ7RHs", forHTTPHeaderField: "apikey")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl5c3Z6aXJia2dveGxpeHh1amtmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI2NDEyMDUsImV4cCI6MjAxODIxNzIwNX0.lMSfr3k0gTctNAZpz7UbOuSDIbGDEmZ_ZFI_idZ7RHs", forHTTPHeaderField: "Authorization")

        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error with fetching data: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }

            guard let data = data else{
                print("no data recived")
                return
            }
            
            print(data)
            
            let  decoder = JSONDecoder()// تفك الترميز الي سوفت
            
            do{
                self.meal = try decoder.decode([MealModel].self, from: data)
                print(self.meal)//تطبع لي المعلومات
                print("---------------------------------------------")
            }
            catch{
                print("error\(error)")//عشان  يطلع لي الايرور
            }
        }

        task.resume()
    }
    
    func updateData(id: UUID,isorder: Bool){
        let url = URL(string: "https://yysvzirbkgoxlixxujkf.supabase.co/rest/v1/meal?id=eq.\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"

        // Set your headers here
        request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl5c3Z6aXJia2dveGxpeHh1amtmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI2NDEyMDUsImV4cCI6MjAxODIxNzIwNX0.lMSfr3k0gTctNAZpz7UbOuSDIbGDEmZ_ZFI_idZ7RHs", forHTTPHeaderField: "apikey")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl5c3Z6aXJia2dveGxpeHh1amtmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI2NDEyMDUsImV4cCI6MjAxODIxNzIwNX0.lMSfr3k0gTctNAZpz7UbOuSDIbGDEmZ_ZFI_idZ7RHs", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("return=minimal", forHTTPHeaderField: "Prefer")

        // JSON body with the update for column c1
        let jsonString = """
        {
            "isOrder": "\(isorder)"
        }
        """

        // Converting JSON String to Data
        let jsonData = jsonString.data(using: .utf8)!
        request.httpBody = jsonData

        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error with fetching data: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error: Did not receive a valid HTTP response")
                return
            }

            if (200...299).contains(httpResponse.statusCode) {
                print("Update successful with status code: \(httpResponse.statusCode)")
            } else {
                print("Update failed with status code: \(httpResponse.statusCode)")
            }
        }

        task.resume()
    }
    
  

    
}
