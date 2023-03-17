//
//  Home.swift
//  RouletteApp
//
//  Created by User15 on 2023/3/1.
//

import AVKit
import SwiftUI

struct Home: View {
    @State private var name = ""
    @State private var number = ""
    @State private var email = ""
    @State private var money = ""

    @State private var done = false

    @Binding var Home: Bool
    @State private var ShowSecondView = false

    var body: some View {
        ZStack {
            Image("bg1")
                .resizable()
                .ignoresSafeArea()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)

            ScrollView(.vertical)
            {

                VStack
                {
                    Text("Welcome to")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Spacer().frame(height :10)

                    Text("European")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Spacer().frame(height :10)

                    Text("Roulette")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }

            Spacer().frame(height :30)

            Group
            {
                HStack
                {
                    Text("Full Name            :")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    TextField("your name", text: $name)
                        .foregroundColor(.white)
                }

                HStack
                {
                    Text("Mobile Number :")
                       .foregroundColor(.white)
                       .fontWeight(.bold)
                    TextField("number", text: $number)
                        .foregroundColor(.white)
                }

                HStack
                {
                     Text("E-Mail Address :")
                       .foregroundColor(.white)
                       .fontWeight(.bold)
                TextField("email address", text: $email)
                    .foregroundColor(.white)
                }
            Spacer().frame(height :20)

            Button(action: {
                self.done = true
                    }) {
                Text("Register")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(width: 300, alignment: .center)
                }
                .actionSheet(isPresented: $done)
                {
                ActionSheet(title: Text("COMPLETE"),
                message: Text("WELCOME " + name + "!"),
                    buttons: [.default(Text("OK"))])
                    }.buttonStyle(PlainButtonStyle())
                      }

            Spacer().frame(height :50)

                VStack{
                Text("First Time Play?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                    Spacer().frame(height : 5)
                Link("Go Check Here!",
                        destination: URL(string: "https://www.roulettestar.com/guide/how-to-play/")!)
                    .font(.title)
                    .foregroundColor(.white)
                }
    }
    }
}
}


    struct Home_Previews: PreviewProvider {
        static var previews: some View {
            Home(Home: .constant(true))
                .previewLayout(.fixed(width: 852, height: 393))
        }
    }
