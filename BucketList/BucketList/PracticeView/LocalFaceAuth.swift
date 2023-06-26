//
//  LocalFaceAuth.swift
//  BucketList
//
//  Created by Venkatesh Nyamagoudar on 6/3/23.
//

import SwiftUI
import LocalAuthentication

struct LocalFaceAuth: View {
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear {
            authenticate()
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            //can use biometrics
            let reason = "We need to use your data to unlock "
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {result, error in
                switch result {
                case true :
                    //checking the biometrics - success case
                    isUnlocked = true
                case false:
                    //checking the biometrics - fail case
                    break
                }
            }
        } else {
            // no biometrics
        }
    }
}

struct LocalFaceAuth_Previews: PreviewProvider {
    static var previews: some View {
        LocalFaceAuth()
    }
}
