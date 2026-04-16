import { motion, useReducedMotion } from 'motion/react'

export default function VisionMission() {
	const prefersReducedMotion = useReducedMotion()

	const sectionVariants = {
		hidden: { opacity: 0.0, y: 80 },
		show: {
			transition: {
				duration: prefersReducedMotion ? 0 : 0.8,
				ease: 'easeInOut' as const,
			},
			opacity: 1,
			y: 0,
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
				<div className="hidden h-96 flex-1/2 overflow-hidden rounded-2xl shadow-xl grayscale transition-all duration-300 group-hover:grayscale-0 sm:flex">
					<img
						src="/resources/images?src=/img/aboutUs/vision-mission.jpg&format=webp&w=1200&h=800&fit=cover"
						alt="Vision and Mission"
						className="h-full w-full object-cover transition duration-300 hover:scale-105"
					/>
				</div>
				<div className="text-secondary-foreground flex flex-1/2 flex-col gap-12">
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
				</div>
			</motion.div>
		</section>
	)
}
