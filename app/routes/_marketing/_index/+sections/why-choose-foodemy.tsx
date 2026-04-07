import { motion } from 'motion/react'
import { type ReactNode } from 'react'
import { CardStack } from '#app/components/aceternity/card-stack.tsx'
import { cn } from '#app/utils/misc.tsx'
import { StudyMaterialsStack } from '../+components/studyMaterialsStack'

function FeatureCard({
	className,
	textClassName,
	title,
	description,
	visual,
	inlineVisual = false,
}: {
	className?: string
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
		<section
			className={cn(
				'relative mx-auto w-full overflow-hidden rounded-2xl bg-indigo-800',
				className,
			)}
		>
			<div
				className="relative h-full overflow-hidden bg-[radial-gradient(88%_100%_at_top,rgba(255,255,255,0.5),rgba(255,255,255,0))] sm:mx-0 sm:rounded-2xl"
				style={{
					boxShadow:
						'0 10px 32px rgba(34, 42, 53, 0.12), 0 1px 1px rgba(0, 0, 0, 0.05), 0 0 0 1px rgba(34, 42, 53, 0.05), 0 4px 6px rgba(34, 42, 53, 0.08), 0 24px 108px rgba(47, 48, 55, 0.10)',
				}}
			>
				<motion.div className={cn('h-full px-4 py-20 sm:px-10')}>
					<Noise />
					<div className="max-md:px-4 max-md:py-8">
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
					</div>
				</motion.div>
			</div>
		</section>
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
						className="bg-secondary text-secondary lg:mn-h-75 col-span-1 h-full lg:col-span-4 xl:col-span-2"
						textClassName="text-secondary-foreground"
						title="High Quality Video Lectures"
						description="Our expert faculty brings their wealth of knowledge and teaching experience to deliver high-quality video lectures."
						visual={<CardStack items={VIDEO_CARDS} />}
						inlineVisual
					/>
					<FeatureCard
						className="bg-secondary col-span-1 lg:col-span-2 xl:col-span-1"
						textClassName="text-secondary-foreground"
						title="Solved Previous Year Questions"
						description="Access to solved previous year questions helps you understand the exam's pattern and gain insight into the frequently asked topics"
					/>
					<FeatureCard
						className="bg-secondary col-span-1 lg:col-span-2 xl:col-span-1"
						textClassName="text-secondary-foreground"
						title="Mentorship from subject experts"
						description="We believe in providing personalized attention. Benefit from mentorship from our experienced subject experts"
					/>
					<FeatureCard
						className="bg-secondary relative col-span-1 lg:col-span-4 lg:min-h-75 xl:col-span-2 xl:min-h-75"
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

const Noise = () => {
	return (
		<div
			className="absolute inset-0 h-full w-full scale-[1.2] transform mask-[radial-gradient(#fff,transparent,75%)] opacity-10"
			style={{
				backgroundImage: 'url(/img/noise.webp)',
				backgroundSize: '30%',
			}}
		></div>
	)
}
