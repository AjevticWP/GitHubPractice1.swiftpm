import SwiftUI

@main
struct MyApp: App {
    
    @State private var showApp = false
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                if showApp {
                    ContentView()
                        .transition(.opacity)
                } else {
                    Image(systemName: "sailboat")
                        .resizable()
                        .frame(width:200, height:200)
                        .transition(.scale(scale:2))
                }
            }
            .animation(.easeInOut(duration:0.5), value: showApp)
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        showApp = true
                    }
                }
            }
        }
    }
}
