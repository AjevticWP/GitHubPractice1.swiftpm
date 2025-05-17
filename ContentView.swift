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
                    Image("DuraVita Logo")
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
import SwiftUI

struct ContentView: View {
    
    @State private var enteredText = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                NavigationLink(destination: ScreenOne()) {
                    CircleButton(label: "Dairy")
                }
                NavigationLink(destination: ScreenTwo()) {
                    CircleButton(label: "Fruit/Veggies")
                }
                NavigationLink(destination: ScreenThree()) {
                    CircleButton(label: "Meat")
                }
                NavigationLink(destination: ScreenFour()) {
                    CircleButton(label: "Condiments")
                }
            }
            .navigationTitle("Select Food Group")
        }
    }
}

struct CircleButton: View {
    let label: String
    
    var body: some View {
        Text(label)
            .font(.headline)
            .foregroundColor(.white)
            .frame(width: 100, height: 100)
            .background(Color.black)
            .clipShape(Circle())
    }
}

// Differnet Screens

struct ScreenOne: View {
    var body: some View {
        Text("Dairy List:")
            .font(.largeTitle)
            .padding()
        Text("Milk - 7 Days In counting")
            .padding()
        Text("Slided Cheese - 10 Days In Counting")
            .padding()
        Text("Yogurt - 11 Days In Counting")
            .padding()
       TextField("Enter In Dairy Product", text: $enteredText)
        //TextField() have user enter in half & half = 7 days
    }
}

struct ScreenTwo: View {
    var body: some View {
        Text("Fruit/Veggies List:")
            .font(.largeTitle)
            .padding()
        Text("Strawberries - 4 Days In Counting")
            .padding()
        Text("Carrots - 21 Days In Counting")
            .padding()
        Text("Cucumbers - 7 Days In Counting")
            .padding()
        //TextField() have user enter in Apples = 28 days
    }
}

struct ScreenThree: View {
    var body: some View {
        Text("Meat List:")
            .font(.largeTitle)
            .padding()
        Text("Ground Beef - 4 Days In Counting")
            .padding()
        Text("Bacon - 7 Days I Counting")
            .padding()
        Text("Deli Meat - 4 Days In Counting")
            .padding()
        // TextField () have user enter in cooked chicken = 4 days
    }
}

struct ScreenFour: View {
    var body: some View {
        Text("Condiments List:")
            .font(.largeTitle)
        Text("Ketchup - 180 Days In Counting")
            .padding()
        Text("Mustard - 360 Days In Counting")
            .padding()
        Text("Pesto - 7 Days In Counting")
            .padding()
        // Text Field () Have user enter int Jam = 180 Days 
    }
}

// Preview for content view

#Preview {
    ContentView()
}


