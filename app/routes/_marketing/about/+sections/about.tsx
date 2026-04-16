import { motion } from 'motion/react'

export default function About() {
	return (
		<section className="container pt-36 sm:py-36 sm:pt-48">
			<motion.div
				className="flex gap-24"
				initial={{ opacity: 0.0, y: 80 }}
				whileInView={{ opacity: 1, y: 0 }}
				transition={{
					delay: 0.1,
					duration: 0.8,
					ease: 'easeInOut',
				}}
				viewport={{ once: true }}
			>
				<div className="flex flex-1/2 flex-col gap-4">
					<h2>
						About <span className="highlight">Foodemy</span>
					</h2>
					<p>
						Foodemy is an online education platform dedicated to advancing the
						field of food technology. Our team of six passionate founders met
						during their MTech studies in Food Technology at{' '}
						<a href="https://niftem.ac.in/">NIFTEM</a>, and founded FOODEMY in
						2019 with the goal of helping students and professionals in the
						industry gain practical skills, knowledge, and real-world
						experience. We have a dedicated network of over a dozen talented
						professionals who help us keep the wheels turning and make Foodemy a
						success.
					</p>
					<p>
						We started out by creating a YouTube channel that provided learning
						resources for GATE Food Technology. Since then, we have expanded our
						offerings to include fyGATE, an online GATE coaching program for
						food technology students that has helped many individuals succeed in
						their exams
					</p>
				</div>
				<div className="relative hidden w-full flex-1/2 rounded-2xl shadow-xl lg:flex">
					<img
						src="resources/images?src=/img/aboutUs/about-us.jpg&format=webp&w=1200&h=800&fit=cover"
						alt="About Foodemy"
						className="absolute z-10 h-full w-full -translate-x-8 translate-y-8 rounded-2xl object-cover"
					/>
					<div className="h-full w-full rounded-2xl bg-black">
						<div className="bg-primary absolute right-0 bottom-0 left-0 h-20 rounded-b-2xl"></div>
					</div>
				</div>
			</motion.div>
		</section>
	)
}
