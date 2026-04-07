import { motion } from 'motion/react'

export default function WhatIsFygate() {
	return (
		<section className="w-full shadow-xl inset-shadow-2xs">
			<motion.div
				initial={{ opacity: 0.0, x: -80 }}
				whileInView={{ opacity: 1, x: 0 }}
				transition={{
					delay: 0.3,
					duration: 0.8,
					ease: 'easeInOut',
				}}
				viewport={{ once: true }}
				className="container flex items-center gap-24 py-24"
			>
				<div className="hidden flex-1/2 overflow-hidden lg:block">
					<img
						src={'/img/about-img.jpg'}
						alt="Hero Image"
						className="h-full w-full object-cover"
					/>
				</div>
				<div className="relative flex flex-1/2 flex-col gap-4">
					<h2 className="">
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
