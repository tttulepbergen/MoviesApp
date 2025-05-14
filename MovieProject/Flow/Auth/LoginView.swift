import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: AuthViewModel
    @Binding var showRegistration: Bool
    
    let accentColor = Color.red
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 32) {
                Spacer()
                

                VStack(spacing: 16) {
                    Image(systemName: "film")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.white.opacity(0.8))
                        .shadow(radius: 8)
                    
                    Text("Welcome Back")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                }
                .padding(.bottom, 32)
                
                VStack(spacing: 20) {
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
                    
                    Button("Login") {
                        viewModel.login()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
                .padding(.horizontal, 32)
                
                VStack(spacing: 16) {
                    Button("Forgot Password?") {
                        viewModel.sendPasswordReset(email: viewModel.email)
                    }
                    .foregroundColor(.white.opacity(0.8))
                    
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(.white.opacity(0.8))
                        Button("Sign Up") {
                            showRegistration = true
                        }
                        .foregroundColor(accentColor)
                    }
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
