import SwiftUI

protocol HomeDisplayLogic {

}

struct HomeView: View {
    var interactor: HomeBusinessLogic?

    var body: some View {
        NavigationView {
            Text("Side Bar")
            Text("Main view")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
