import { motion } from 'motion/react'
import { Timeline } from '#app/components/aceternity/timeline.tsx'
import YTVideoCard from '../+components/ytVideoCard'

export default function FoodemyTimeline() {
	const data = [
		{
			title: 'Early 2019',
			content: (
				<div>
					<p className="mb-8 text-lg">
						Launched our YouTube channel and started sharing free content
					</p>
					<div className="grid grid-cols-2 gap-4">
						<YTVideoCard
							link="https://www.youtube.com/embed/n3cYYxnnN-c?si=VauEyBL2dt_zpeYo&amp;controls=0"
							title="Top Government Job Opportunities for Food Technologists"
						/>
						<YTVideoCard
							link="https://www.youtube.com/embed/Absrge44uJg?si=FX1wSm1eQcOZ4HYr&amp;controls=0"
							title="Microbial Spoilage of Foods | Food Technology Lecture"
						/>
						<YTVideoCard
							link="https://www.youtube.com/embed/pFDWBs5oSFk?si=fNEp27V8txQyxuF7&amp;controls=0"
							title="Milling of Wheat | Food Technology Lecture"
						/>
						<YTVideoCard
							link="https://www.youtube.com/embed/PafSBZO92t8?si=yJjm4ddPCuZWhCNH&amp;controls=0"
							title="How to prepare for FSSAI | ft. Sakshi Gaurkhede | fyTalks."
						/>
					</div>
				</div>
			),
		},
		{
			title: '2020',
			content: (
				<div>
					<div className="flex h-48 w-full rounded-lg bg-radial bg-[url(/img/timeline/yt.webp)] bg-cover bg-center md:h-60 lg:h-96">
						<div className="flex w-full flex-1 items-center bg-radial-[at_50%_50%] from-black/50 from-50% to-transparent to-100% p-4">
							<span className="w-full text-center text-xl font-bold text-white md:text-2xl lg:text-3xl">
								Hit 1000 subscribers on YouTube
							</span>
						</div>
					</div>
				</div>
			),
		},
		{
			title: '2021',
			content: (
				<div className="flex flex-col gap-6">
					<span className="text-primary-foreground text-xl font-bold md:text-2xl lg:text-3xl">
						Launched fyGATE
					</span>
					<YTVideoCard
						link="https://www.youtube.com/embed/vKm4GU5uf8Y?si=c8-_H3JEIjSZzxge"
						title="fyGATE promo video"
					/>
				</div>
			),
		},
		{
			title: '2022',
			content: (
				<div>
					<div className="flex h-48 w-full rounded-lg bg-radial bg-[url(/img/timeline/grad.webp)] bg-cover bg-center md:h-60 lg:h-96">
						<div className="flex w-full flex-1 items-center bg-radial-[at_50%_50%] from-black/50 from-50% to-transparent to-100% p-4">
							<span className="w-full text-center text-xl font-bold text-white md:text-2xl lg:text-3xl">
								Our first batch of fyGATE students qualified GATE
							</span>
						</div>
					</div>
				</div>
			),
		},
	]
	return (
		<section className="w-full bg-white shadow-xl inset-shadow-2xs">
			<motion.div
				initial={{ opacity: 0.0, y: 80 }}
				whileInView={{ opacity: 1, y: 0 }}
				transition={{
					delay: 0.1,
					duration: 0.8,
					ease: 'easeInOut',
				}}
				viewport={{ once: true }}
				className="relative w-full py-36 xl:container"
			>
				<h2 className="text-center">
					Our <span className="highlight">journey</span>
				</h2>
				<Timeline data={data} />
			</motion.div>
		</section>
	)
}
