import { motion } from 'motion/react'

export default function AnimatedClock({ className }: { className?: string }) {
	return (
		<motion.svg
			xmlns="http://www.w3.org/2000/svg"
			width="24"
			height="24"
			viewBox="0 0 24 24"
			fill="none"
			stroke="currentColor"
			strokeWidth="2"
			strokeLinecap="round"
			strokeLinejoin="round"
			className={className}
			whileInView={'animate'}
		>
			<motion.path
				d="M12,12L16,12"
				variants={{
					animate: { rotate: [0, 360], originX: 0, originY: 0 },
				}}
				transition={{ duration: 2, ease: 'linear' }}
			/>
			<motion.path
				d="M12,6L12,12"
				variants={{
					animate: { rotate: [0, 360], originY: 1, originX: 0.5 },
				}}
				transition={{ duration: 1, repeat: 2, ease: 'linear' }}
			/>
			<motion.circle cx="12" cy="12" r="10" />
			<defs></defs>
		</motion.svg>
	)
}
