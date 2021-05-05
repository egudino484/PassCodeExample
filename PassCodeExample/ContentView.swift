//
//  ContentView.swift
//  PassCodeExample
//
//  Created by Edison Gudiño on 5/5/21.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
   @State private var showingAlert = false
   @State var message = ""
   var body: some View {
      
      VStack{
         Button(action: {
            authenticateUser()
         } , label: {
            Text("Use Touch ID or Passcode")
         })
      }
      .alert(isPresented: $showingAlert) {
         Alert(title: Text("Local Auth"), message: Text("\(message)"), dismissButton: .default(Text("Got it!")))
      }
      
   }
   
   
   func authenticateUser() {
      let authenticationContext = LAContext()
      var error: NSError?
      let reasonString = "Unlock App."
      
      // Check if the device can evaluate the policy.
      if authenticationContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthentication, error: &error) {
         
         authenticationContext.evaluatePolicy( .deviceOwnerAuthentication, localizedReason: reasonString, reply: { (success, evalPolicyError) in
            
            if success {
               showingAlert = true
               message = "Success"
            } else {
               // Handle evaluation failure or cancel
               showingAlert = true
               message = "Incorrect Passcode"
            }
         })
         
      } else {
         showingAlert = true
         message = "Passcode not set"
      }
   }
}

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      ContentView()
   }
}
