import { motion } from 'motion/react'

export default function WhatIsFygate() {
	return (
		<section className="bg-background w-full shadow-xl inset-shadow-2xs">
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
				<div className="relative hidden flex-1/2 lg:block">
					{/* <div className="bg-primary-foreground absolute inset-0 -translate-x-6 -translate-y-6 rounded-2xl"></div> */}
					<div className="relative overflow-hidden rounded-2xl">
						<img
							src={
								'/resources/images?src=/img/index/about-img.webp&format=webp'
							}
							alt="Hero Image"
							className="h-full w-full object-cover"
						/>
						<div className="from-primary-foreground to-primary-foreground absolute right-4 bottom-4 left-4 rounded-xl border border-white/40 bg-linear-to-br via-white/20 px-4 py-3 backdrop-blur-sm">
							<p className="text-muted font-serif text-sm font-semibold">
								This is more than prep. It's a plan. A path. And if you're
								serious about GATE, we're serious about getting you there.
							</p>
							<p className="text-muted/80 text-right text-xs">
								- The fyGATE Promise
							</p>
						</div>
					</div>
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
