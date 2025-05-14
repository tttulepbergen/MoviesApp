import SwiftUI

struct AuthFlowView: View {
    @ObservedObject var viewModel: AuthViewModel
    @Binding var showRegistration: Bool

    var body: some View {
        if viewModel.isLoggedIn {
            Text("Redirecting...")
        } else {
            if showRegistration {
                RegistrationView(viewModel: viewModel, showRegistration: $showRegistration)
            } else {
                LoginView(viewModel: viewModel, showRegistration: $showRegistration)
            }
        }
    }
}

