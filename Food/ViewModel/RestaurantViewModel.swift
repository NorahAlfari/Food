//
//  Restaurant.swift
//  Food
//
//  Created by Norah Alfari on 01/06/1445 AH.
//

import Foundation

class RestaurantViewModel: ObservableObject{
    
    @Published var restaurnt: [RestaurantModel] = []
    
    init() {
        fetch()
    }
    
    func fetch(){
        let url = URL(string: "https://yysvzirbkgoxlixxujkf.supabase.co/rest/v1/restaurant?select=*")!
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
                self.restaurnt = try decoder.decode([RestaurantModel].self, from: data)
                print(self.restaurnt)//تطبع لي المعلومات
                print("---------------------------------------------")
            }
            catch{
                print("error\(error)")//عشان  يطلع لي الايرور
            }
        }

        task.resume()
    }
}
