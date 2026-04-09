import { motion } from 'motion/react'
import { useEffect, useMemo, useState } from 'react'
import { cn } from '#app/utils/misc.tsx'

type TypewriterWord = {
	text: string
	className?: string
}

type TypewriterTimingProps = {
	typingSpeedMs?: number
	deletingSpeedMs?: number
	pauseBeforeDeleteMs?: number
	pauseBeforeNextWordMs?: number
}

function useTypewriterLoop(
	words: TypewriterWord[],
	{
		typingSpeedMs = 100,
		deletingSpeedMs = 50,
		pauseBeforeDeleteMs = 3000,
		pauseBeforeNextWordMs = 250,
	}: TypewriterTimingProps,
) {
	const [wordIndex, setWordIndex] = useState(0)
	const [charIndex, setCharIndex] = useState(0)
	const [isDeleting, setIsDeleting] = useState(false)

	const currentWord = words[wordIndex] ?? { text: '', className: '' }

	useEffect(() => {
		if (!words.length) return

		const fullText = currentWord.text
		let timeoutMs = typingSpeedMs

		if (!isDeleting && charIndex < fullText.length) {
			timeoutMs = typingSpeedMs
		} else if (!isDeleting && charIndex === fullText.length) {
			timeoutMs = pauseBeforeDeleteMs
		} else if (isDeleting && charIndex > 0) {
			timeoutMs = deletingSpeedMs
		} else {
			timeoutMs = pauseBeforeNextWordMs
		}

		const timeout = window.setTimeout(() => {
			if (!isDeleting && charIndex < fullText.length) {
				setCharIndex((value) => value + 1)
				return
			}

			if (!isDeleting && charIndex === fullText.length) {
				setIsDeleting(true)
				return
			}

			if (isDeleting && charIndex > 0) {
				setCharIndex((value) => value - 1)
				return
			}

			setIsDeleting(false)
			setWordIndex((value) => (value + 1) % words.length)
		}, timeoutMs)

		return () => window.clearTimeout(timeout)
	}, [
		words,
		currentWord.text,
		charIndex,
		isDeleting,
		typingSpeedMs,
		deletingSpeedMs,
		pauseBeforeDeleteMs,
		pauseBeforeNextWordMs,
	])

	const visibleText = useMemo(
		() => currentWord.text.slice(0, charIndex),
		[currentWord.text, charIndex],
	)

	return { visibleText, currentWord }
}

// export const TypewriterEffect = ({
// 	words,
// 	className,
// 	cursorClassName,
// 	typingSpeedMs,
// 	deletingSpeedMs,
// 	pauseBeforeDeleteMs,
// 	pauseBeforeNextWordMs,
// }: {
// 	words: TypewriterWord[]
// 	className?: string
// 	cursorClassName?: string
// } & TypewriterTimingProps) => {
// 	const { visibleText, currentWord } = useTypewriterLoop(words, {
// 		typingSpeedMs,
// 		deletingSpeedMs,
// 		pauseBeforeDeleteMs,
// 		pauseBeforeNextWordMs,
// 	})

// 	return (
// 		<div
// 			className={cn(
// 				'text-center text-base font-bold sm:text-xl md:text-3xl lg:text-5xl',
// 				className,
// 			)}
// 		>
// 			<span
// 				className={cn(
// 					'inline-block text-black dark:text-white',
// 					currentWord.className,
// 				)}
// 			>
// 				{visibleText}
// 			</span>
// 			<motion.span
// 				initial={{
// 					opacity: 0,
// 				}}
// 				animate={{
// 					opacity: 1,
// 				}}
// 				transition={{
// 					duration: 0.8,
// 					repeat: Infinity,
// 					repeatType: 'reverse',
// 				}}
// 				className={cn(
// 					'inline-block h-10 w-[4px] rounded-sm bg-blue-500 md:h-16',
// 					cursorClassName,
// 				)}
// 			></motion.span>
// 		</div>
// 	)
// }

export const TypewriterEffectSmooth = ({
	words,
	className,
	cursorClassName,
	typingSpeedMs,
	deletingSpeedMs,
	pauseBeforeDeleteMs,
	pauseBeforeNextWordMs,
}: {
	words: TypewriterWord[]
	className?: string
	cursorClassName?: string
} & TypewriterTimingProps) => {
	const { visibleText, currentWord } = useTypewriterLoop(words, {
		typingSpeedMs,
		deletingSpeedMs,
		pauseBeforeDeleteMs,
		pauseBeforeNextWordMs,
	})

	return (
		<div className="inline-block">
			<div className={cn('flex items-end space-x-1', className)}>
				<div
					className={cn(
						'text-primary-foreground min-h-10 text-3xl leading-tight font-black font-bold md:min-h-16 md:text-6xl',
						currentWord.className,
					)}
					style={{ whiteSpace: 'nowrap' }}
				>
					{visibleText || '\u200B'}
				</div>
				<motion.span
					initial={{
						opacity: 0,
					}}
					animate={{
						opacity: 1,
					}}
					transition={{
						duration: 0.5,

						repeat: Infinity,
						repeatType: 'reverse',
					}}
					className={cn(
						'bg-primary block h-10 w-[4px] rounded-sm md:h-16',
						cursorClassName,
					)}
				></motion.span>
			</div>
		</div>
	)
}
