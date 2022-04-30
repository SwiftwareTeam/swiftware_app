
// Sample Survey and Survey Response
let question1 = Question(id: 1, shortWording: "feeling okay?", fullWording: "How are you feeling today?")
let question2 = Question(id: 2, shortWording: "feeling down?", fullWording: "Are you feeling down today?")

let answer1 = Answer(id: 1, label: "no", value: 1)
let answer2 = Answer(id: 2, label: "yes", value: 2)

let survey = Survey(id: 1, name: "Big Five", group: "I feel ___", questions: [1: question1], answers: [1: answer1, 2: answer2])

let surveyResponse = SurveyResponse(uid: "shawn", surveyID: 1, responseType: "new", responses: [1: nil, 2: 2])