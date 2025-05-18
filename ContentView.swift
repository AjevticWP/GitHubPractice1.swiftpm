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

class FoodListData: ObservableObject {
    @Published var dairyList: [String] = []
    @Published var fruitList: [String] = []
    @Published var meatList: [String] = []
    @Published var condimentList: [String] = []
}


struct ContentView: View {
    @StateObject var foodData = FoodListData() // Create shared data
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                NavigationLink(destination: ScreenOne().environmentObject(foodData)) {
                    CircleButton(label: "Dairy")
                }
                NavigationLink(destination: ScreenTwo().environmentObject(foodData)) {
                    CircleButton(label: "Fruit/Veggies")
                }
                NavigationLink(destination: ScreenThree().environmentObject(foodData)) {
                    CircleButton(label: "Meat")
                }
                NavigationLink(destination: ScreenFour().environmentObject(foodData)) {
                    CircleButton(label: "Condiments")
                }
            }
            .navigationTitle("Select Food Group")
            .font(.largeTitle)
            .padding()
        }
    }
}


struct CircleButton: View {
    let label: String
    
    var body: some View {
        Text(label)
            .font(.headline)
            .foregroundColor(.green)
            .frame(width: 100, height: 100)
            .background(Color.blue)
            .clipShape(Circle())
    }
}

// Differnet Screens

struct ScreenOne: View {
    @EnvironmentObject var foodData: FoodListData // Access shared data
    @State private var enteredText = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Dairy List:")
                .font(.largeTitle)
            
            // Built-in items
            Text("Milk - 7 Days In Counting")
            Text("Slided Cheese - 10 Days In Counting")
            Text("Yogurt - 11 Days In Counting")
            
            // User-added items
            ForEach(foodData.dairyList, id: \.self) { item in
                Text(item)
            }
            
            TextField("Enter Dairy Product", text: $enteredText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 250, height: 50)
            
            Button("Add to List") {
                if !enteredText.isEmpty {
                    foodData.dairyList.append(enteredText)
                    enteredText = ""
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Spacer()
        }
        .padding()
    }
}


struct ScreenTwo: View {
    @EnvironmentObject var foodData: FoodListData
    @State private var enteredText = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Fruit/Veggies List:")
                .font(.largeTitle)
            
            Text("Strawberries - 4 Days In Counting")
            Text("Carrots - 21 Days In Counting")
            Text("Cucumbers - 7 Days In Counting")
            
            ForEach(foodData.fruitList, id: \.self) { item in
                Text(item)
            }
            
            TextField("Enter Fruit/Veggie Product", text: $enteredText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 250)
            
            Button("Add to List") {
                if !enteredText.isEmpty {
                    foodData.fruitList.append(enteredText)
                    enteredText = ""
                }
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Spacer()
        }
        .padding()
    }
}


struct ScreenThree: View {
    @EnvironmentObject var foodData: FoodListData
    @State private var enteredText = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Meat List:")
                .font(.largeTitle)
            
            Text("Ground Beef - 4 Days In Counting")
            Text("Bacon - 7 Days In Counting")
            Text("Deli Meat - 4 Days In Counting")
            
            ForEach(foodData.meatList, id: \.self) { item in
                Text(item)
            }
            
            TextField("Enter Meat Product", text: $enteredText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 250)
            
            Button("Add to List") {
                if !enteredText.isEmpty {
                    foodData.meatList.append(enteredText)
                    enteredText = ""
                }
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Spacer()
        }
        .padding()
    }
}


struct ScreenFour: View {
    @EnvironmentObject var foodData: FoodListData
    @State private var enteredText = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Condiments List:")
                .font(.largeTitle)
            
            Text("Ketchup - 180 Days In Counting")
            Text("Mustard - 360 Days In Counting")
            Text("Pesto - 7 Days In Counting")
            
            ForEach(foodData.condimentList, id: \.self) { item in
                Text(item)
            }
            
            TextField("Enter Condiment Product", text: $enteredText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 250)
            
            Button("Add to List") {
                if !enteredText.isEmpty {
                    foodData.condimentList.append(enteredText)
                    enteredText = ""
                }
            }
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Spacer()
        }
        .padding()
    }
}


// Preview for content view

#Preview {
    ContentView()
}




