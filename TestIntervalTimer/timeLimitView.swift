//
//  TimeLimitView.swift
//  TestIntervalTimer
//
//  Created by 山本祐太 on 2022/08/17.
//

import SwiftUI

struct TimeLimitView: View {
    @State var timeLimit = "nothing"
    var body: some View {
        Text(timeLimit)
            .font(
                .system(
                    size: 50,
                    weight: .heavy,
                    design: .rounded
                )
            )
    }
}

struct TimeLimitView_Previews: PreviewProvider {
    static var previews: some View {
        TimeLimitView()
    }
}
