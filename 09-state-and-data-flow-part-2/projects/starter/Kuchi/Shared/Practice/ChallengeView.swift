import SwiftUI

struct ChallengeView: View {
    let challengeTest: ChallengeTest
    
    @State var showAnswers = false
    @Binding var numberOfAnswered: Int
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.questionsPerSession) var questionsPerSession
    
    // 1
    @ViewBuilder
    var body: some View {
      // 2
      if verticalSizeClass == .compact {
        // 3
        VStack {
          // 4
          HStack {
            Button(action: {
              showAnswers = !showAnswers
            }) {
              QuestionView(
                question: challengeTest.challenge.question)
            }
            if showAnswers {
              Divider()
              ChoicesView(challengeTest: challengeTest)
            }
          }
          ScoreView(
            numberOfQuestions: questionsPerSession,
            numberOfAnswered: $numberOfAnswered
          )
        }
      } else {
        // 5
        VStack {
          Button(action: {
            showAnswers = !showAnswers
          }) {
            QuestionView(
              question: challengeTest.challenge.question)
              .frame(height: 300)
          }
          ScoreView(
            numberOfQuestions: questionsPerSession,
            numberOfAnswered: $numberOfAnswered
          )
          if showAnswers {
            Divider()
            ChoicesView(challengeTest: challengeTest)
              .frame(height: 300)
              .padding()
          }
        }
      }
    }
}


struct ChallengeView_Previews: PreviewProvider {
    static let challengeTest = ChallengeTest(
        challenge: Challenge(
            question: "おねがい　します",
            pronunciation: "Onegai shimasu",
            answer: "Please"
        ),
        answers: ["Thank you", "Hello", "Goodbye"]
    )
    @State static var numberOfAnswered: Int = 0
    static var previews: some View {
        return ChallengeView(challengeTest: challengeTest,
                            numberOfAnswered: $numberOfAnswered)
    }
}
