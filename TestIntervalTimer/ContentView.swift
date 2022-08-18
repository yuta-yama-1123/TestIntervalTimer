//
//  ContentView.swift
//  TestIntervalTimer
//
//  Created by 山本祐太 on 2022/08/17.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var timerContorller =  TimerModel()
    var body: some View {
        VStack(alignment: .center) {
            Button(action: {
                if(timerContorller.timer == nil){
                    timerContorller.start(5.00)
                }else{
                    timerContorller.stop()
                }
            }){
                Text("\((timerContorller.timer != nil) ? "Stop Timer" : "Start Timer")")
                    .font(
                        .system(
                            size: 100,
                            weight: .heavy,
                            design: .rounded
                        )
                    )
            }
            Text("\(timerContorller.countStr)")
                .font(
                    .system(
                        size: 100,
                        weight: .heavy,
                        design: .rounded
                    )
                )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
    }
}
