import { motion } from 'motion/react'
import AccentBar from '#app/components/ui/accent-bar.tsx'
import { Img } from 'openimg/react'

function AboutValueItem({
	title,
	description,
}: {
	title: string
	description: string
}) {
	return (
		<div className="flex flex-col gap-2">
			<div className="flex items-center gap-1">
				<AccentBar color="destructive" />
				<h3 className="text-destructive font-semibold">{title}</h3>
			</div>
			<p>{description}</p>
		</div>
	)
}

export default function AboutFoodemy() {
	return (
		<section className="bg-primary/10 w-full py-24">
			<motion.div
				initial={{ opacity: 0.0, y: -80 }}
				whileInView={{ opacity: 1, y: 0 }}
				transition={{
					delay: 0.3,
					duration: 0.8,
					ease: 'easeInOut',
				}}
				viewport={{ once: true }}
				className="container grid gap-12 lg:grid-cols-2"
			>
				<div>
					<div className="mb-4 flex">
						{/* <AccentBar /> */}
						<h2>
							About <span className="highlight">Foodemy</span>
						</h2>
					</div>
					<p>
						Foodemy is an online education platform dedicated to advancing the
						field of food technology. Our team of six passionate founders met
						during their MTech studies in Food Technology at{' '}
						<a href="https://niftem.ac.in/" className="border-secondary">
							NIFTEM
						</a>
						, and founded Foodemy in 2019 with the goal of helping students and
						professionals in the industry gain practical skills, knowledge, and
						real-world experience.
					</p>
					<div className="mt-12 flex flex-col gap-8">
						<AboutValueItem
							title="Our vision"
							description="To be the go-to platform for students and professionals seeking to advance their skills and knowledge in food technology."
						/>
						<AboutValueItem
							title="Our mission"
							description="To empower students and professionals in the food technology industry with the knowledge, skills, and resources they need to succeed."
						/>
					</div>
				</div>
				<div className="hidden grid-cols-2 grid-rows-2 gap-2 lg:grid">
					<div className="row-span-2 overflow-hidden rounded-2xl">
						<Img
							src="/img/index/about/about1.jpg"
							width={800}
							height={1200}
							alt=""
							className="h-full object-cover transition duration-300 hover:scale-110"
						/>
					</div>
					<div className="overflow-hidden rounded-2xl">
						<Img
							src="/img/index/about/about2.jpg"
							width={1200}
							height={800}
							alt=""
							className="h-full scale-125 object-cover transition duration-300 hover:scale-135"
						/>
					</div>
					<div className="overflow-hidden rounded-2xl">
						<Img
							src="/img/index/about/about3.jpg"
							width={1200}
							height={800}
							alt=""
							className="h-full object-cover transition duration-300 hover:scale-110"
						/>
					</div>
				</div>
			</motion.div>
		</section>
	)
}
