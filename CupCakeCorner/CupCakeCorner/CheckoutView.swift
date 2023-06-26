//
//  CheckoutView.swift
//  CupCakeCorner
//
//  Created by Venkatesh Nyamagoudar on 5/31/23.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var showingNetworkAlert = false
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string:"https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) {
                    image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height:230)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order"){
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") {
                
            }
        } message: {
            Text(confirmationMessage)
        }
        .alert("No Internet Connection", isPresented: $showingNetworkAlert) {
            Button("OK") {
            }
        } message: {
            Text("Please check your network connectiopn")
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            print("Checkout failed.")
            showingNetworkAlert = true
        }
    }
    
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}


//
//static func sendEmail(to email: String, subject: String, body: String, completion: @escaping (Result<Void, Error>) -> Void) {
//    let apiKey = "YOUR_SENDGRID_API_KEY"
//    let urlString = "https://api.sendgrid.com/v3/mail/send"
//    let url = URL(string: urlString)!
//    var request = URLRequest(url: url)
//    request.httpMethod = "POST"
//    request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
//    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//    let parameters: [String: Any] = [
//        "personalizations": [
//            [
//                "to": [
//                    ["email": email]
//                ]
//            ]
//        ],
//        "from": [
//            "email": "YOUR_SENDER_EMAIL",
//            "name": "YOUR_SENDER_NAME"
//        ],
//        "subject": subject,
//        "content": [
//            [
//                "type": "text/plain",
//                "value": body
//            ]
//        ]
//    ]
//    request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
//
//    URLSession.shared.dataTask(with: request) { (_, response, error) in
//        if let error = error {
//            completion(.failure(error))
//        } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 202 {
//            completion(.success(()))
//        } else {
//            completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
//        }
//    }.resume()
//}
//
