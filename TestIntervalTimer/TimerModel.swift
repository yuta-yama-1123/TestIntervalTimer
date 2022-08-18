import Foundation
import Combine
import AVFoundation
import UIKit

class TimerModel: ObservableObject{
    @Published var count: Double = 0.00
    @Published var timer: AnyCancellable!
    @Published var countStr: String = "0.00"
    @Published var timeLimit: Double = 0.00
    @Published var remaining: Double = 0.00
    let interval: Double = 0.05 // タイマー処理ループ間隔
    var soundFlg: Bool = false
    @Published var progress: Double = 0.0
    
    // アラーム音声ファイル読み込み
    private let shining_star = try!  AVAudioPlayer(data: NSDataAsset(name: "shining_star")!.data)

    // 音声ファイル再生
    private func shiningStar() {
        shining_star.stop()             // 停止
        shining_star.currentTime = 0.0  // 頭出し※最初から再生するため
        shining_star.play()             // 再生
    }
    // 音声ファイル再生停止
    private func stopShiningStar() {
        shining_star.stop()             // 停止
        shining_star.currentTime = 0.0  // 頭出し※最初から再生するため
    }
    private func calcProgress() {
        progress = ( (timeLimit - count) / timeLimit )
        print(timeLimit)
        print(count)
        print(progress)
    }
    // タイマー処理の開始
    func start(_ timeRemaining: Double = 10.00){
        count = timeRemaining   // 残り時間（秒）の取得
        timeLimit = timeRemaining
        // TimerPublisherが存在しているときは念の為処理をキャンセル
        if let _timer = timer{
            _timer.cancel()
        }
        // タイマー定義
        timer = Timer
            .publish(
                every: interval, // タイマー処理実行間隔
                on: .main,       // 実行場所(.main:メインスレッドでの実行)
                in: .common
            )
            .autoconnect() // 繰り返し処理の実行
            .receive(
                on: DispatchQueue.main
            )
            .sink(
                receiveValue: (
                    {_ in
                        // 設定した時間ごとに呼ばれる
                        self.count -= self.interval
                        self.countStr = String(format: "%.1f", self.count)
                        self.remaining += self.interval
                        if (self.count < 0.05) {
                            self.shiningStar()
                            self.timer?.cancel()
                        }
                    }
                )
            )
    }

    // タイマーの停止
    func stop(){
        timer?.cancel()
        timer = nil
        stopShiningStar()
    }
}
