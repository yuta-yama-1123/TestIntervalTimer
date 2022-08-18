import Foundation
import Combine
import AVFoundation
import UIKit

class TimerModel: ObservableObject{
    @Published var count: Double = 0.00
    @Published var timer: AnyCancellable!
    @Published var countStr: String = ""
    let interval: Double = 0.05
    var soundFlg: Bool = false
    
    private let shining_star = try!  AVAudioPlayer(data: NSDataAsset(name: "shining_star")!.data)

    private func shiningStar() {
        shining_star.stop()//追加①
        shining_star.currentTime = 0.0//追加②
        shining_star.play()
    }

    private func stopShiningStar() {
        shining_star.stop()//追加①
        shining_star.currentTime = 0.0//追加②
    }
    
    // タイマーの開始
    func start(_ timeRemaining: Double = 10.00){
        count = timeRemaining
        // TimerPublisherが存在しているときは念の為処理をキャンセル
        if let _timer = timer{
            _timer.cancel()
        }

        timer = Timer
            .publish(
                every: interval,
                on: .main,
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
                        if (self.count < 0) {
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
