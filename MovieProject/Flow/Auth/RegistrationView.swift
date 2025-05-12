//
//  MovieProjectApp.swift
//  MovieProject
//
//  Created by Polina Stelmakh on 09.05.2025.
//  Rewrited by Aisha Suanbekova on 10.05.2025

import SwiftUI

struct RegistrationView: View {
    @ObservedObject var viewModel: AuthViewModel
    @Binding var showRegistration: Bool
    
    @State private var confirmPassword = ""
    
    let accentColor = Color.red
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 32) {
                Spacer()
                
                // Logo and Title
                VStack(spacing: 16) {
                    Image(systemName: "person.crop.circle.badge.plus")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.white.opacity(0.8))
                        .shadow(radius: 8)
                    
                    Text("Create Account")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                }
                .padding(.bottom, 32)
                
                // Registration Form
                VStack(spacing: 20) {
                    TextField("Name", text: $viewModel.name)
                        .autocapitalization(.words)
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                    SecureField("Confirm Password", text: $confirmPassword)
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                    Button("Register") {
                        viewModel.register(confirmPassword: confirmPassword)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
                .padding(.horizontal, 32)
                
                // Sign In Option
                HStack {
                    Text("Already have an account?")
                        .foregroundColor(.white.opacity(0.8))
                    Button("Sign In") {
                        showRegistration = false
                    }
                    .foregroundColor(accentColor)
                }
                
                Spacer()
            }
            .padding()
            .alert(isPresented: $viewModel.showError) {
                Alert(title: Text("Notice"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
} 
