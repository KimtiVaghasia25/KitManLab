//
//  LoginView.swift
//  KitmanAthletes
//
//  Created by Kimti Vaghasia on 16/08/2025.
//
import SwiftUI
import Foundation

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    TextField("UserName",
                              text: $viewModel.username
                    )
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.top, 20)
                    
                    Divider()
                    
                    SecureField( "Password",
                                 text: $viewModel.password
                    )
                    .padding(.top, 20)
                    
                    Divider()
                }
                .navigationDestination(isPresented: $viewModel.loginSuccess) {
    
                     AthletesListView(athleteListViewModel: AthleteListViewModel())
                     .navigationBarTitle(Text("Kitman Athletes"))
                     .navigationBarBackButtonHidden(true)
    
                }
                
                Spacer()
                
                Button(
                    action: viewModel.login,
                    label: {
                        Text("Login")
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .frame(maxWidth: .infinity, maxHeight: 60)
                            .foregroundColor(Color.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                )
                
            }
            .padding(30)
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
