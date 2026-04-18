import { motion, useReducedMotion } from 'motion/react'
import { Icon } from '#app/components/ui/icon.tsx'
import PricingCard from '../+components/pricingCard'
import { type loader } from '../courses._courses'
import XEvsXL from './xe-vs-xl'

export default function AllCourses({
	data,
}: {
	data: Awaited<ReturnType<typeof loader>>
}) {
	const allCourses = data.allCourses

	const prefersReducedMotion = useReducedMotion()

	const cardVariants = {
		hidden: prefersReducedMotion
			? { opacity: 1, y: 0, scale: 1 }
			: { opacity: 0, y: 24, scale: 0.98 },
		show: (staggerIndex: number) => ({
			opacity: 1,
			y: 0,
			scale: 1,
			transition: {
				duration: prefersReducedMotion ? 0 : 0.5,
				delay: prefersReducedMotion ? 0 : staggerIndex * 0.08,
			},
		}),
	}

	return (
		<section className="relative py-12 sm:py-36">
			{/* Dreamy Sky Pink Glow */}
			<div
				className="absolute inset-0 z-0"
				style={{
					backgroundImage: `
        radial-gradient(circle at 30% 70%, rgba(173, 216, 230, 0.35), transparent 60%),
        radial-gradient(circle at 70% 30%, rgba(255, 182, 193, 0.4), transparent 60%)`,
				}}
			/>
			<motion.div
				className="container flex w-full flex-col items-center gap-24 bg-[#fefcff]"
				initial={{ opacity: 0.0, y: -80 }}
				whileInView={{ opacity: 1, y: 0 }}
				transition={{
					delay: 0.1,
					duration: 0.8,
					ease: 'easeInOut',
				}}
				viewport={{ once: true }}
			>
				<div className="flex flex-col gap-4">
					<h2>
						All <span className="highlight">courses</span>
					</h2>
					<div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
						{allCourses
							.sort((a, b) => a.sortOrder - b.sortOrder)
							.map((course, index) => (
								<PricingCard
									key={course.slug}
									course={course}
									variants={cardVariants}
									staggerIndex={index % 3}
								/>
							))}
						<motion.div
							className="z-20 flex flex-col items-center justify-center gap-6 rounded-xl border border-dashed border-gray-500 p-6 shadow-lg"
							variants={cardVariants}
							custom={allCourses.length % 3}
							initial="hidden"
							whileInView="show"
							viewport={{ once: true, amount: 0.2 }}
						>
							<div className="flex flex-col items-center gap-4 text-center">
								<span className="text-4xl font-bold">😕</span>
								<h3 className="text-primary-foreground font-display font-bold lg:text-lg xl:text-xl">
									Can't decide which one to choose?
								</h3>
								<p className="text-secondary text-center text-sm">
									Just go through the table below — it’s designed to help you
									decide on your own.
								</p>

								<motion.div
									animate={{ y: [0, 10, 0], scaleX: [1, 0.95, 1] }}
									transition={{
										duration: 0.8,
										ease: 'easeInOut',
										repeat: Infinity, // Keep wiggling forever
										repeatDelay: 1, // Optional: add delay between wiggles
									}}
									className="inline-block"
								>
									<Icon
										name="arrow-down-double-fill"
										size="lg"
										className="text-primary-foreground"
									/>
								</motion.div>
							</div>
						</motion.div>
					</div>
				</div>
				<XEvsXL />
			</motion.div>
		</section>
	)
}
