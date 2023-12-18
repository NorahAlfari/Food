//
//  OrderViewModel.swift
//  Food
//
//  Created by Norah Alfari on 03/06/1445 AH.
//

import Foundation

class OrderViewModel: ObservableObject{
    @Published var order: [OrderModel] = []
    
    init() {
        fetch()
    }
    
    func fetch(){
        let url = URL(string: "https://yysvzirbkgoxlixxujkf.supabase.co/rest/v1/MyOrder?select=*")!
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
                self.order = try decoder.decode([OrderModel].self, from: data)
                print(self.order)//تطبع لي المعلومات
                print("---------------------------------------------")
            }
            catch{
                print("error\(error)")//عشان  يطلع لي الايرور
            }
        }

        task.resume()
    }
    
    
    func addOrder(totalPrice: Int,createdAt:String){
        let url = URL(string: "https://yysvzirbkgoxlixxujkf.supabase.co/rest/v1/MyOrder")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // Set your headers here
        request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl5c3Z6aXJia2dveGxpeHh1amtmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI2NDEyMDUsImV4cCI6MjAxODIxNzIwNX0.lMSfr3k0gTctNAZpz7UbOuSDIbGDEmZ_ZFI_idZ7RHs", forHTTPHeaderField: "apikey")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl5c3Z6aXJia2dveGxpeHh1amtmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI2NDEyMDUsImV4cCI6MjAxODIxNzIwNX0.lMSfr3k0gTctNAZpz7UbOuSDIbGDEmZ_ZFI_idZ7RHs", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("return=minimal", forHTTPHeaderField: "Prefer")

        // Start of JSON data definition
        let jsonString = """
        {
           
            "totalPrice": "\(totalPrice)",
            "userID": "e54b02d6-6733-4ee1-a97f-7d131b4296ba",
            "createdAt": "\(createdAt)"
        }
        """

        
        let jsonData = jsonString.data(using: .utf8)!
           request.httpBody = jsonData

           let session = URLSession.shared

           let task = session.dataTask(with: request) { data, response, error in
               if let error = error {
                   print("Error: \(error)")
                   return
               }

               if let httpResponse = response as? HTTPURLResponse {
                   if (200..<300).contains(httpResponse.statusCode) {
                       print("Order added to backend successfully!")
                   } else {
                       print("HTTP Status Code: \(httpResponse.statusCode)")
                       // Optionally, handle the error appropriately
                   }
               }
           }

           task.resume()
       }
    
}
