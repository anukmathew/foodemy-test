import { motion } from 'motion/react'
import { Img } from 'openimg/react'

export default function Introduction() {
	return (
		<section className="container pt-36 pb-12 sm:pt-48 sm:pb-36">
			<motion.div
				className="flex items-center gap-24"
				initial={{ opacity: 0.0, y: 80 }}
				whileInView={{ opacity: 1, y: 0 }}
				transition={{
					delay: 0.1,
					duration: 0.8,
					ease: 'easeInOut',
				}}
				viewport={{ once: true }}
			>
				<div className="hidden flex-1/2 overflow-hidden rounded-2xl lg:block">
					<Img
						src={'/img/courses/introduction.jpg'}
						width={1200}
						height={800}
						alt="Hero Image"
						className="h-full w-full object-cover"
					/>
				</div>
				<div className="relative flex flex-1/2 flex-col gap-4">
					<h2>
						<span className="highlight">fyGATE</span> course
					</h2>
					<p>
						fyGATE is not just another coaching program; it's your personalized
						accelerator towards GATE success. Designed exclusively for food
						technology students, fyGATE empowers you with the tools and guidance
						needed to conquer the GATE exam and secure admission to your dream
						institute.
					</p>
					<p>
						Our top-notch coaching program provides high-quality video lectures,
						crisp study materials, and practice questions. Benefit from
						mentorship by subject experts, doubt clearance sessions, and mock
						tests. Join fyGATE and join the ranks of successful students in
						premier institutes.
					</p>
					<img
						src="/img/foodemy_monogram_outline.svg"
						className="absolute left-0 -z-10 h-96 translate-x-96 opacity-20"
						alt="Foodemy Monogram Outline"
					/>
				</div>
			</motion.div>
		</section>
	)
}
