import { motion } from 'motion/react'
import { type ReactNode } from 'react'
import { CardStack } from '#app/components/aceternity/card-stack.tsx'
import { WobbleCard } from '#app/components/aceternity/wobble-card.tsx'
import { cn } from '#app/utils/misc.tsx'
import { StudyMaterialsStack } from '../+components/studyMaterialsStack'

function FeatureCard({
	containerClassName,
	textClassName,
	title,
	description,
	visual,
	inlineVisual = false,
}: {
	containerClassName?: string
	textClassName?: string
	title: string
	description: string
	visual?: ReactNode
	inlineVisual?: boolean
}) {
	const textContent = (
		<>
			<h3
				className={cn(
					'font-display text-left leading-10 font-semibold tracking-[-0.015em] text-balance text-white',
					textClassName,
				)}
			>
				{title}
			</h3>
			<p
				className={cn(
					'mt-4 text-left leading-6 text-neutral-200',
					textClassName,
				)}
			>
				{description}
			</p>
		</>
	)

	return (
		<WobbleCard
			containerClassName={containerClassName}
			className="max-md:px-4 max-md:py-8"
		>
			{inlineVisual ? (
				<div className="flex items-center justify-between">
					<div className="max-w-xs">{textContent}</div>
					<div className="hidden lg:block">{visual}</div>
				</div>
			) : (
				<>
					<div className="max-w-sm">{textContent}</div>
					{visual && <div className="hidden lg:block">{visual}</div>}
				</>
			)}
		</WobbleCard>
	)
}

export default function WhyUs() {
	return (
		<section className="container py-36">
			<motion.div
				initial={{ opacity: 0.0, x: 80 }}
				whileInView={{ opacity: 1, x: 0 }}
				transition={{
					delay: 0.3,
					duration: 0.8,
					ease: 'easeInOut',
				}}
				viewport={{ once: true }}
			>
				<h2 className="mb-4">
					Why choose <span className="highlight">Foodemy?</span>
				</h2>
				<div className="mx-auto grid w-full max-w-full grid-cols-1 gap-4 lg:grid-cols-4 xl:grid-cols-3">
					<FeatureCard
						containerClassName="col-span-1 lg:col-span-4 xl:col-span-2 h-full bg-secondary text-secondary lg:min-h-[300px]"
						textClassName="text-secondary-foreground"
						title="High Quality Video Lectures"
						description="Our expert faculty brings their wealth of knowledge and teaching experience to deliver high-quality video lectures."
						visual={<CardStack items={VIDEO_CARDS} />}
						inlineVisual
					/>
					<FeatureCard
						containerClassName="col-span-1 lg:col-span-2 xl:col-span-1 bg-secondary"
						textClassName="text-secondary-foreground"
						title="Solved Previous Year Questions"
						description="Access to solved previous year questions helps you understand the exam's pattern and gain insight into the frequently asked topics"
					/>
					<FeatureCard
						containerClassName="col-span-1 lg:col-span-2 xl:col-span-1 bg-secondary"
						textClassName="text-secondary-foreground"
						title="Mentorship from subject experts"
						description="We believe in providing personalized attention. Benefit from mentorship from our experienced subject experts"
					/>
					<FeatureCard
						containerClassName="col-span-1 lg:col-span-4 xl:col-span-2 relative bg-secondary lg:min-h-[300px] xl:min-h-[300px]"
						textClassName="text-secondary-foreground"
						title="Crisp and Concise Study Materials"
						description="We provide you with crisp and concise study materials, eliminating the need for exhaustive searches through numerous books"
						visual={
							<StudyMaterialsStack
								images={STUDY_MATERIALS}
								direction="up"
								speed="normal"
								className="absolute top-0 right-0 mr-12 h-full"
							/>
						}
					/>
				</div>
			</motion.div>
		</section>
	)
}

const VIDEO_CARDS = [
	{
		id: 0,
		name: '',
		designation: '',
		content: (
			<video
				src="/videos/video1.webm"
				autoPlay={true}
				loop={true}
				muted={true}
				playsInline={true}
			/>
		),
	},
	{
		id: 1,
		name: '',
		designation: '',
		content: (
			<video
				src="/videos/video2.webm"
				autoPlay={true}
				loop={true}
				muted={true}
				playsInline={true}
			/>
		),
	},
	{
		id: 2,
		name: '',
		designation: '',
		content: (
			<video
				src="/videos/video3.webm"
				autoPlay={true}
				loop={true}
				muted={true}
				playsInline={true}
			/>
		),
	},
	{
		id: 3,
		name: '',
		designation: '',
		content: (
			<video
				src="/videos/video4.webm"
				autoPlay={true}
				loop={true}
				muted={true}
				playsInline={true}
			/>
		),
	},
]

const STUDY_MATERIALS = [
	'/img/notes/note1.webp',
	'/img/notes/note2.webp',
	'/img/notes/note3.webp',
	'/img/notes/note4.webp',
]
