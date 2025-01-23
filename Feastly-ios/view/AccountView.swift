//
//  AccountView.swift
//  Feastly-ios
//
//  Created by Pranav on 22/01/25.
//

import SwiftUI

struct AccountView: View {
    @State private var username: String = UserDefaults.standard.string(forKey: "username") ?? ""
    @State private var email: String = UserDefaults.standard.string(forKey: "email") ?? ""
    @State private var password: String = UserDefaults.standard.string(forKey: "password") ?? ""
    @State private var agreeToTerms: Bool = UserDefaults.standard.bool(forKey: "agreeToTerms")
    
    @State private var birthday: Date = UserDefaults.standard.object(forKey: "birthday") as? Date ?? Date()
    
    var body: some View {
        NavigationStack {
            Form {
                //personal details
                Section(header: Text("Personal details")) {
                    TextField("username", text: $username)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                    
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    DatePicker("Birthday", selection: $birthday, displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle())
                    
                }
                
                // Section for account security
                Section {
                    SecureField("Password", text: $password)
                } header: {
                    Text("Security")
                }
                
                //agree to terms
                Section{
                    Toggle("Agree to Terms and Conditions", isOn: $agreeToTerms)
                }
                
                //submit form
                Section {
                    Button(action: {
                        // Handle form submission
                        print("Form Submitted: Username: \(username), Email: \(email), Agree: \(agreeToTerms)")
                        saveToUserDefaults()
                    }) {
                        Text("Save Account")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .disabled(!agreeToTerms || username.isEmpty || email.isEmpty || password.isEmpty)
                }
                

            }
            .navigationTitle("Create Account 👤")

        }
        
        
    }
    private func saveToUserDefaults() {
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(password, forKey: "password")
        UserDefaults.standard.set(agreeToTerms, forKey: "agreeToTerms")
        UserDefaults.standard.set(birthday,forKey: "birthday")
    }
}

#Preview {
//    NavigationStack{
        AccountView()
//    }
   
}
