//
//  ContentView.swift
//  Project2
//
//  Created by User on 22.01.2024.
//

import SwiftUI

struct ContentView: View {
    @State var anotherColor = AnotherColor()
    var body: some View {
        VStack {
            Text("Traffic Lights")
            HStack {
//                Squares()
//                Squares()
//                Squares()
                
//                Circles()
//                Circles()
//                Circles()
                
                Squares(anotherColor: anotherColor)
            }
        }
        Button("Change color", action: {
            switch anotherColor.color {
            case .red: anotherColor.color = .yellow
            case .yellow: anotherColor.color = .green
            case .green: anotherColor.color = .red
            }
        }).padding(.all, 5)
    }
}

enum TrafficLight {
    case red
    case yellow
    case green
}

class AnotherColor: ObservableObject {
    @Published var color: TrafficLight = .red
}

struct Square: View {
    var body: some View {
        Rectangle().frame(width: 35,height:35)
    }
}

//struct Squares: View {
//    var body: some View {
//        VStack {
//            Square().foregroundColor(.red)
//            Square().foregroundColor(.yellow)
//            Square().foregroundColor(.green)
//        }
//    }
//}

struct Squares: View {
    @ObservedObject var anotherColor = AnotherColor()
    var body: some View {
        switch anotherColor.color {
        case .red: VStack {
            Square().foregroundColor(.red)
            Square().foregroundColor(.white)
            Square().foregroundColor(.white)
        }
        case .green: VStack {
            Square().foregroundColor(.white)
            Square().foregroundColor(.white)
            Square().foregroundColor(.green)
        }
        case .yellow: VStack {
            Square().foregroundColor(.white)
            Square().foregroundColor(.yellow)
            Square().foregroundColor(.white)
        }
        }
    }
}

struct  OneCircle: View {
    var body: some View {
        Circle().frame(width:35, height:35)
    }
}

struct Circles: View {
    var body: some View {
        VStack {
            OneCircle().foregroundColor(.red)
            OneCircle().foregroundColor(.yellow)
            OneCircle().foregroundColor(.green)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(anotherColor: AnotherColor())
    }
}
