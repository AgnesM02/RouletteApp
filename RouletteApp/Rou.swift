//
//  Rou.swift
//  RouletteApp
//
//  Created by User15 on 2023/3/1.
//

import AVKit
import SwiftUI

let wid: CGFloat = 60
let high: CGFloat = 45
let chipDiameter: CGFloat = 35

struct Number{
  let value: String
  let redOrBlack: Color
}

struct Rou: View {

    @State private var lattice = [
      Number(value: "0", redOrBlack: .green),
      Number(value: "1", redOrBlack: .red),
      Number(value: "2", redOrBlack: .black),
      Number(value: "3", redOrBlack: .red),
      Number(value: "4", redOrBlack: .black),
      Number(value: "5", redOrBlack: .red),
      Number(value: "6", redOrBlack: .black),
      Number(value: "7", redOrBlack: .red),
      Number(value: "8", redOrBlack: .black),
      Number(value: "9", redOrBlack: .red),
      Number(value: "10", redOrBlack: .black),
      Number(value: "11", redOrBlack: .black),
      Number(value: "12", redOrBlack: .red),
      Number(value: "13", redOrBlack: .black),
      Number(value: "14", redOrBlack: .red),
      Number(value: "15", redOrBlack: .black),
      Number(value: "16", redOrBlack: .red),
      Number(value: "17", redOrBlack: .black),
      Number(value: "18", redOrBlack: .red),
      Number(value: "19", redOrBlack: .red),
      Number(value: "20", redOrBlack: .black),
      Number(value: "21", redOrBlack: .red),
      Number(value: "22", redOrBlack: .black),
      Number(value: "23", redOrBlack: .red),
      Number(value: "24", redOrBlack: .black),
      Number(value: "25", redOrBlack: .red),
      Number(value: "26", redOrBlack: .black),
      Number(value: "27", redOrBlack: .red),
      Number(value: "28", redOrBlack: .black),
      Number(value: "29", redOrBlack: .black),
      Number(value: "30", redOrBlack: .red),
      Number(value: "31", redOrBlack: .black),
      Number(value: "32", redOrBlack: .red),
      Number(value: "33", redOrBlack: .black),
      Number(value: "34", redOrBlack: .red),
      Number(value: "35", redOrBlack: .black),
      Number(value: "36", redOrBlack: .red),
      Number(value: "00", redOrBlack: .green),
      Number(value: "2to1", redOrBlack: .black),
      Number(value: "2to1", redOrBlack: .black),
      Number(value: "2to1", redOrBlack: .black),
      Number(value: "1st 12", redOrBlack: .black),
      Number(value: "2nd 12", redOrBlack: .black),
      Number(value: "3rd 12", redOrBlack: .black),
      Number(value: "1-18", redOrBlack: .black),
      Number(value: "19-36", redOrBlack: .black),
      Number(value: "RED", redOrBlack: .red),
      Number(value: "BlACK", redOrBlack: .black),
      Number(value: "EVEN", redOrBlack: .black),
      Number(value: "ODD", redOrBlack: .black)
    ]
    @State private var money = 50000
    @State private var bet = 0
    @State private var number = 0
    @State private var numbersQueue = [Int](repeating: 0, count: 10)
    @State private var numberstimes = 0
    @State private var chips = [Int](repeating: 0, count: 50)
    @State private var chipsTotal = 0
    @State private var chipsLast = [Int](repeating: 0, count: 50)
    @State private var chipsLastColor = [Int](repeating: 0, count: 50)
    @State private var chipColor = ["redChip","orangeChip"]
    @State private var chipValue = [100,500]
    @State private var chipChoose = 20
    @State private var resetOrNot = true
    @State private var showGameover = false

    func spin (){
      if(chips[number] >= 1){
        money = money + chips[number] * 36
      }

      if(number != 37 && number % 3 == 1 && chips[38] >= 1){
        money = money + chips[38] * 3
      }else if(number % 3 == 2 && chips[39] >= 1){
        money = money + chips[39] * 3
      }else if(number != 0 && number % 3 == 0 && chips[40] >= 1){
        money = money + chips[40] * 3
      }

      if(number != 0 && (number-1) / 12 == 0 && chips[41] >= 1){
        money = money + chips[41] * 3
      }else if((number-1) / 12 == 1 && chips[42] >= 1){
        money = money + chips[42] * 3
      }else if((number-1) / 12 == 2 && chips[43] >= 1){
        money = money + chips[43] * 3
      }

      if(number != 0 && (number-1) / 18 == 0 && chips[44] >= 1){
        money = money + chips[44] * 2
      }else if((number-1) / 18 == 1 && chips[45] >= 1){
        money = money + chips[45] * 2
      }

      if(lattice[number].redOrBlack == .red && chips[46] >= 1){
        money = money + chips[46] * 2
      }else if(lattice[number].redOrBlack == .black && chips[47] >= 1){
        money = money + chips[47] * 2
      }

      if(number != 0 && number % 2 == 0 && chips[48] >= 1){
        money = money + chips[48] * 2
      }else if(number != 37 && number % 2 == 1 && chips[49] >= 1){
        money = money + chips[49] * 2
      }
      chipsLast = chips
      chips = [Int](repeating: 0, count: 50)

      for i in 1...9{
        numbersQueue[10-i] = numbersQueue[9-i]
      }
      numbersQueue[0] = number
      if(numberstimes<9){
        numberstimes += 1
      }

      resetOrNot = true

      if(money <= 0){
        showGameover = true
      }

    }
    func betting(i: Int){
      if(chipChoose < 2 && chipChoose >= 0){
        if((money >= 500 && chipChoose == 1) || (money > 0 && chipChoose == 0))
        {
          money = money - chipValue[chipChoose]
          bet = bet + chipValue[chipChoose]
          chips[i] += chipValue[chipChoose]
          chipsLastColor[i] = chipChoose
        }
      }
    }


    @Binding var ShowThirdView: Bool

    var body: some View
    {
        ZStack {
            Image("bgapp")
                .resizable()
                .ignoresSafeArea()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            VStack(alignment: .center)
            {
                VStack(spacing: 10)
                {
                Text("You Have: \(money)                            ")
                  .font(.title2)
                  .fixedSize()
                  .foregroundColor(.white)
                  .frame(width: 10)

                Text("BET: \(bet)")
                    .font(.title2)
                    .fixedSize()
                    .foregroundColor(.white)
                    .frame(width: 10)
                }


              HStack(alignment: .center)
              {
                VStack (alignment: .center, spacing: 80)
                {
                    
                  VStack (alignment: .center, spacing: 10)
                  {
                    ForEach(0...1, id: \.self){ i in   //chips
                      Button {
                        chipChoose = i
                      } label: {
                        ZStack{
                          Image(chipColor[i])
                            .resizable()
                            .frame(width: 45, height: 45)
                          Text("\(chipValue[i])")
                            .font(.caption)
                            .foregroundColor(.white)
                        }
                      }
                    }
                  } //money&chips
                  VStack(alignment: .center, spacing: 100)
                  {
                    VStack (alignment: .center, spacing: 35)
                    {
                      Button {
                        bet = 0
                        for i in 0...49{
                          money += chips[i]
                        }
                        chips = [Int](repeating: 0, count: 50)
                        resetOrNot = true
                      }label: {
                        Image("clear")
                          .resizable()
                          .frame(width: 90, height: 50, alignment: .center)

                      }      //clear button
                      Button {
                        for i in 0...49{
                          chipsTotal += chips[i]
                        }
                        if(chipsTotal != 0){
                          bet = 0
                          number = Int.random(in: 0..<38)
                          spin()
                        }
                        chipsTotal = 0
                      }label: {
                        Image("spin")
                          .resizable()
                          .frame(width: 60, height: 50, alignment: .center)

                      }.sheet(isPresented: $showGameover){
                        gameover(money: $money ,showGameover: $showGameover)
                      }
                    }   //button set
                  }
                }
                VStack(alignment: .center, spacing: 50){
                  HStack(alignment: .center, spacing: 0){
                    VStack (alignment: .center, spacing: 0){   //1-18...
                      ForEach(44...49, id: \.self){ i in
                        Button {
                          betting(i: i)
                        } label: {
                          ZStack{
                            Text(lattice[i].value)
                              .font(.headline)
                              .frame(width: wid, height: 2*high, alignment: .center)
                              .border(Color.white, width: 2)
                              .foregroundColor(lattice[i].redOrBlack)
                            if(chips[i] > 0){
                              Image(chipColor[chipsLastColor[i]])
                                .resizable()
                                .frame(width: chipDiameter, height: chipDiameter)
                              Text("\(chips[i])")
                                .font(.caption)
                                .foregroundColor(Color.white)
                            }
                          }
                        }
                      }
                    }
                    VStack (alignment: .center, spacing: 0){   //1st12...
                      ForEach(41...43, id: \.self){ i in
                        Button {
                          betting(i: i)
                        } label: {
                          ZStack{
                            Text(lattice[i].value)
                              .font(.headline)
                              .frame(width: wid, height: 4*high, alignment: .center)
                              .border(Color.white, width: 2)
                              .foregroundColor(Color.white)
                            if(chips[i] > 0){
                              Image(chipColor[chipsLastColor[i]])
                                .resizable()
                                .frame(width: chipDiameter, height: chipDiameter)
                              Text("\(chips[i])")
                                .font(.caption)
                                .foregroundColor(Color.white)
                            }
                          }
                        }
                      }
                    }
                    VStack (alignment: .center, spacing: 0){   //數字
                      HStack(alignment: .center, spacing: 0){
                        ForEach(0...1, id: \.self){ i in   //0,00
                          Button {
                            betting(i: i*37)
                          } label: {
                            ZStack{
                              Text(lattice[i*37].value)
                                .font(.headline)
                                .frame(width: wid*3/2, height: high, alignment: .center)
                                .border(Color.white, width: 2)
                                .foregroundColor(Color.white)
                              if(chips[i*37] > 0){
                                Image(chipColor[chipsLastColor[i*37]])
                                  .resizable()
                                  .frame(width: chipDiameter, height: chipDiameter)
                                Text("\(chips[i*37])")
                                  .font(.caption)
                                  .foregroundColor(Color.white)

                              }
                            }
                          }
                        }
                      }
                      ForEach(0...11, id: \.self){ i in   //1-36
                        HStack(alignment: .center, spacing: 0){
                          ForEach(3*i+1...3*i+3, id: \.self){ j in
                            Button {
                              betting(i: j)
                            } label: {
                              ZStack{
                                Text(lattice[j].value)
                                  .font(.headline)
                                  .frame(width: wid, height: high)
                                  .background(lattice[j].redOrBlack)
                                  .border(Color.white, width: 2)
                                if(chips[j] > 0){
                                  Image(chipColor[chipsLastColor[j]])
                                    .resizable()
                                    .frame(width: chipDiameter, height: chipDiameter)
                                  Text("\(chips[j])")
                                    .font(.caption)
                                    .foregroundColor(Color.white)
                                }
                              }
                            }
                          }
                        }
                      }
                        
                      HStack(alignment: .center, spacing: 0){   //2to1
                        ForEach(38...40,id: \.self){ i in
                          Button {
                            betting(i: i)
                          } label: {
                            ZStack{
                              Text("2to1")
                                .font(.headline)
                                .frame(width: wid, height: high, alignment: .center)
                                .border(Color.white, width: 2)
                                .foregroundColor(Color.white)
                              if(chips[i] > 0){
                                Image(chipColor[chipsLastColor[i]])
                                  .resizable()
                                  .frame(width: chipDiameter, height: chipDiameter)
                                Text("\(chips[i])")
                                  .font(.caption)
                                  .foregroundColor(Color.white)
                                  .rotationEffect(.degrees(90))

                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
            }
        }
    }
    }
}

struct gameover: View {
        @Binding var money: Int
        @Binding var showGameover: Bool

        var body: some View {
            ZStack {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
              Image("youlose")
                .resizable()
                .frame(width: 200, height: 200)
              Button {
                money = 50000
                showGameover = false
              } label: {
                Image("restart")
                    .resizable()
                    .frame(width: 100, height: 100)
              }
            }
        }
    }
}

struct Rou_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Rou(ShowThirdView: .constant(true))
            
        }
    }
}
