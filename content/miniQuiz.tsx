import { useState } from 'react'

type Question = {
	question: string
	options: Option[]
}

type Option = {
	id: number
	text: string
	isCorrect: boolean
}

interface QuizProps {
	questions: Question[]
}

export default function Quiz({ questions }: QuizProps) {
	const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0)
	const [selectedOption, setSelectedOption] = useState<Option | null>(null)
	const [score, setScore] = useState(0)
	const [showScore, setShowScore] = useState(false)

	const handleOptionClick = (option: Option) => {
		if (selectedOption !== null) return

		setSelectedOption(option)

		if (option.isCorrect) {
			setScore(score + 1)
		}

		setTimeout(() => {
			if (currentQuestionIndex + 1 < questions.length) {
				setCurrentQuestionIndex(currentQuestionIndex + 1)
				setSelectedOption(null)
			} else {
				setShowScore(true)
			}
		}, 1500)
	}

	const currentQuestion = questions[currentQuestionIndex]

	return (
		<div className="quiz mx-auto mt-10 rounded-xl border border-gray-200 bg-white p-6 font-sans shadow-md">
			{showScore ? (
				<div className="mx-auto mt-10 max-w-md text-center">
					<h2 className="mb-4 text-2xl font-bold">Quiz Completed!</h2>
					<p className="text-lg">
						Your Score: {score} / {questions.length}
					</p>
				</div>
			) : (
				<>
					<h2 className="mb-4 text-sm text-gray-500">
						Question {currentQuestionIndex + 1} of {questions.length}
					</h2>
					<p className="mb-5 text-xl font-semibold">
						{currentQuestion?.question}
					</p>

					<div className="flex flex-col gap-4">
						{currentQuestion?.options.map((option, idx) => {
							let baseStyle =
								'cursor-pointer rounded-lg border text-left border-gray-300 bg-gray-50 px-5 py-3 text-base transition-colors duration-150 select-none '
							const correctOption = currentQuestion?.options.find(
								(option) => option.isCorrect,
							)

							if (selectedOption !== null) {
								if (option === correctOption) {
									baseStyle += 'bg-green-300 border-green-500'
								} else if (
									option === selectedOption &&
									option !== correctOption
								) {
									baseStyle += 'bg-red-300 border-red-500'
								} else {
									baseStyle += 'bg-gray-100'
								}
							} else {
								baseStyle += 'hover:bg-gray-200'
							}

							return (
								<button
									key={idx}
									className={baseStyle}
									onClick={() => handleOptionClick(option)}
									disabled={selectedOption !== null}
								>
									{option.text}
								</button>
							)
						})}
					</div>
				</>
			)}
		</div>
	)
}
