//
//  ContentView.swift
//  TestIntervalTimer
//
//  Created by 山本祐太 on 2022/08/17.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var timerController =  TimerModel()
    @State var intervalMinute = 0 // タイマー時間(分)
    @State var intervalSecond = 0
    @State private var progress = 0.0
    
    // デフォルト値の設定
    init() {
        _intervalMinute = State(initialValue: 2)
        _intervalSecond = State(initialValue: intervalMinute * 60)
    }
    // 画面表示設定
    var body: some View {
        VStack(alignment: .center) {
            Text("Interval")
                .font(
                    .system(
                        size: 50,
                        weight: .heavy,
                        design: .rounded
                    )
                )
            HStack(alignment: .center) {
                Button(action: {
                    if (intervalMinute > 1) {
                        intervalMinute -= 1
                    }
                }){
                    Text("↓")
                        .font(
                            .system(
                                size: 70,
                                weight: .heavy,
                                design: .rounded
                            )
                        )
                }
                    .frame(width: 60, height: 60)
                Text(String(intervalMinute))
                    .font(
                        .system(
                            size: 100,
                            weight: .heavy,
                            design: .rounded
                        )
                    )
                Text("min")
                    .font(
                        .system(
                            size: 80,
                            weight: .semibold,
                            design: .rounded
                        )
                    )
                Button(action: {
                    intervalMinute += 1
                }){
                    Text("↑")
                        .font(
                            .system(
                                size: 70,
                                weight: .heavy,
                                design: .rounded
                            )
                        )
                }
            }
            .padding(
                EdgeInsets(
                    top: 1,        // 上の余白
                    leading: 1,    // 左の余白
                    bottom: -30,     // 下の余白
                    trailing: 1    // 右の余白
                )
            )
            .offset(y: -30)
            Button(action: {
                if(timerController.timer == nil){
                    intervalSecond = intervalMinute * 60
                    timerController.start(Double(intervalSecond))
                }else{
                    timerController.stop()
                }
            }){
                Text("\((timerController.timer != nil) ? "Stop" : "(Re)Start")")
                    .font(
                        .system(
                            size: 70,
                            weight: .heavy,
                            design: .rounded
                        )
                    )
                    .foregroundColor(Color.white)
                    .frame(
                        minWidth: 300,
                        idealWidth: 350,
                        maxWidth: 350,
                        minHeight: 100,
                        idealHeight: 150,
                        maxHeight: 220,
                        alignment: .center)

            }
                .background(.blue)
                .cornerRadius(100)
                .overlay(
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(.indigo, lineWidth: 5.0)
                )
            VStack {
                Text("Remaining:")
                    .font(
                        .system(
                            size: 30,
                            weight: .heavy,
                            design: .rounded
                        )
                    )
                Text("\(timerController.countStr)")
                    .font(
                        .system(
                            size: 80,
                            weight: .heavy,
                            design: .rounded
                        )
                    )
                }
            .padding()
            VStack(alignment: .leading) {
                Text("Get Ready...")
                    .font(
                        .system(
                            size:25,
                            weight: .heavy,
                            design: .rounded
                        )
                    )
                    .padding(
                        EdgeInsets(
                            top: 1,        // 上の余白
                            leading: 1,    // 左の余白
                            bottom: 25,     // 下の余白
                            trailing: 1    // 右の余白
                        )
                    )
                ProgressView(
                    value: timerController.remaining,
                    total: Double(intervalSecond)
                )
                .accentColor(Color.green)
                .scaleEffect(x: 1, y: 15, anchor: .center)
            }
            .padding()
            .offset(y: -30)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
    }
}
