import { motion, useReducedMotion } from 'motion/react'

export default function VisionMission() {
	const prefersReducedMotion = useReducedMotion()

	const sectionVariants = {
		hidden: {},
		show: {
			transition: {
				delayChildren: prefersReducedMotion ? 0 : 0.1,
				staggerChildren: prefersReducedMotion ? 0 : 0.12,
			},
		},
	}

	const imageVariants = {
		hidden: prefersReducedMotion
			? { opacity: 1, x: 0 }
			: { opacity: 0, x: -40 },
		show: {
			opacity: 1,
			x: 0,
			transition: {
				duration: prefersReducedMotion ? 0 : 0.8,
				ease: 'easeInOut' as const,
			},
		},
	}

	const textVariants = {
		hidden: prefersReducedMotion ? { opacity: 1, x: 0 } : { opacity: 0, x: 40 },
		show: {
			opacity: 1,
			x: 0,
			transition: {
				duration: prefersReducedMotion ? 0 : 0.8,
				ease: 'easeInOut' as const,
			},
		},
	}

	return (
		<section className="bg-primary/10 group">
			<motion.div
				className="container mt-12 flex items-center gap-24 py-12 sm:py-18 md:py-24"
				initial="hidden"
				whileInView="show"
				viewport={{ once: true, amount: 0.25 }}
				variants={sectionVariants}
			>
				<motion.div
					className="hidden h-96 flex-1/2 overflow-hidden rounded-2xl shadow-xl grayscale transition-all duration-300 group-hover:grayscale-0 sm:flex"
					variants={imageVariants}
				>
					<img
						src="/img/aboutUs/vision.webp"
						alt="Vision and Mission"
						className="h-full w-full object-cover transition duration-300 hover:scale-105"
					/>
				</motion.div>
				<motion.div
					className="text-secondary-foreground flex flex-1/2 flex-col gap-12"
					variants={textVariants}
				>
					<div className="flex flex-col gap-2">
						<div className="flex items-center gap-2">
							<div className="bg-destructive h-8 w-1"></div>
							<h3 className="text-destructive text-xl font-semibold">
								Our vision
							</h3>
						</div>
						<p>
							To be the go-to platform for students and professionals seeking to
							advance their skills and knowledge in food technology.
						</p>
					</div>
					<div className="flex flex-col gap-2">
						<div className="flex items-center gap-2">
							<div className="bg-destructive h-8 w-1"></div>
							<h3 className="text-destructive text-xl font-semibold">
								Our mission
							</h3>
						</div>
						<p>
							To empower students and professionals in the food technology
							industry with the knowledge, skills, and resources they need to
							succeed.
						</p>
					</div>
				</motion.div>
			</motion.div>
		</section>
	)
}
