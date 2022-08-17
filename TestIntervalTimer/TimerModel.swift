import Foundation
import Combine

class TimerModel: ObservableObject{
    @Published var count: Int = 0
    @Published var timer: AnyCancellable!

    // タイマーの開始
    func start(_ timeRemaining: Int = 10){
        print("start Timer")

        count = timeRemaining
        // TimerPublisherが存在しているときは念の為処理をキャンセル
        if let _timer = timer{
            _timer.cancel()
        }

        // every -> 繰り返し頻度
        // on -> タイマー処理が走るLoopを指定
        // in: -> 入力処理モードの設定 .defalut:操作系の入力と同様に処理をするらしい : .common それ以外
        // .defalutを指定していると処理が遅くなることがある
        timer = Timer.publish(every: 1, on: .main, in: .common)
            // 繰り返し処理の実行
            .autoconnect()
            //　 レシーバーが動くスレッドを指定しているのだと思われる
            //  .main -> メインスレッド(UI)　, .global() -> 別スレッド
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: ({_ in
                // 設定した時間ごとに呼ばれる
                self.count -= 1
        }))
    }

    // タイマーの停止
    func stop(){
        print("stop Timer")
        timer?.cancel()
        timer = nil
    }
}
