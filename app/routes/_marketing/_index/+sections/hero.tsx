import { motion } from 'motion/react'
import { type ReactElement } from 'react'
import { Link } from 'react-router'
import { DotBackground } from '#app/components/aceternity/dot-background.tsx'
import { FlipWords } from '#app/components/aceternity/flip-words.tsx'
import { TypewriterEffectSmooth } from '#app/components/aceternity/typewriter-effect.tsx'
import { Icon } from '#app/components/ui/icon.tsx'
import { StudentsCount } from '../+components/avatar-group'

function FloatingFeatureCard({
	className,
	iconContainerClassName,
	icon,
	title,
	subtitle,
	floatDelay = 0,
}: {
	className: string
	iconContainerClassName: string
	icon: ReactElement
	title: string
	subtitle: string
	floatDelay?: number
}) {
	return (
		<div
			className={`absolute z-999 ${className}`}
			// initial={{ opacity: 0, y: 16 }}
			// animate={{ opacity: 1, y: 0 }}
			// transition={{ duration: 0.5, ease: 'easeInOut' }}
		>
			<motion.div
				className="flex gap-2 rounded-2xl bg-white px-2 py-3 drop-shadow-md"
				animate={{ y: [0, -8, 0] }}
				transition={{
					duration: 3,
					ease: 'easeInOut',
					repeat: Infinity,
					repeatType: 'loop',
					delay: floatDelay,
				}}
			>
				<div
					className={`${iconContainerClassName} flex size-10 rounded-full p-2`}
				>
					{icon}
				</div>
				<div className="flex flex-col items-start">
					<span className="text-muted-foreground text-sm font-bold">
						{title}
					</span>
					<span className="text-muted-foreground text-xs font-normal">
						{subtitle}
					</span>
				</div>
			</motion.div>
		</div>
	)
}

export default function Hero() {
	const words = [
		'Confidence',
		'Ease',
		'Guidance',
		'Mentorship',
		'Strategy',
		'Precision',
	]
	return (
		<div
		// initial={{ opacity: 0.0, y: 80 }}
		// whileInView={{ opacity: 1, y: 0 }}
		// transition={{
		// 	delay: 0.3,
		// 	duration: 0.8,
		// 	ease: 'easeInOut',
		// }}
		// viewport={{ once: true }}
		>
			<DotBackground>
				<div className="container mx-auto flex flex-col items-center gap-12 pt-25 pb-24 md:pt-30 lg:flex-row xl:min-h-[calc(100dvh-(--spacing(48)))] 2xl:min-h-fit">
					<div className="flex flex-2/3 flex-col items-center gap-12 text-center lg:items-start lg:text-left">
						<div className="flex flex-col gap-6">
							<h1 className="text-secondary font-serif text-3xl leading-tight font-semibold tracking-tight md:text-6xl">
								Master GATE XE/XL Food Technology
								<br /> with{' '}
								{/* <FlipWords
									className="text-primary-foreground highlight font-black italic"
									words={words}
									duration={1000}
								/> */}
								<TypewriterEffectSmooth
									className="text-primary-foreground text-3xl font-black italic md:text-6xl"
									words={typewriterWords}
									cursorClassName="text-primary-foreground"
								/>
							</h1>
							<p className="text-muted-foreground font-normal">
								Your personal mentor for GATE — learn smarter with expert
								guidance, structured modules, and clarity that sticks.
							</p>
						</div>
						<div className="flex items-center gap-4 md:gap-6">
							<Link
								to={'login'}
								className="text-primary-foreground bg-primary hover:bg-primary-soft hover:text-primary-soft-foreground flex items-center justify-center rounded-full px-6 py-3 text-base font-semibold shadow-md duration-300 hover:-translate-y-[2px] hover:scale-105 hover:shadow-xl"
								aria-label="Link to enroll in Foodemy's courses"
							>
								Enroll now
								<Icon name="arrow-right" className="ml-2" />
							</Link>
							<Link
								to="courses"
								className="text-muted-foreground bg-muted hover:bg-primary-soft hover:text-primary-soft-foreground flex items-center justify-center rounded-full px-6 py-3 text-base font-normal shadow-md duration-300 hover:-translate-y-[2px] hover:scale-105 hover:shadow-xl"
								aria-label="Link to know more about Foodemy's courses"
							>
								<span>Explore courses</span>
							</Link>
						</div>
						<div className="mt-6 flex items-center gap-6">
							<StudentsCount />
							<p className="text-muted-foreground ml-2 text-sm font-normal">
								Trusted by over{' '}
								<span className="font-bold">300+ students </span>
								<br />
								for their GATE preparation
							</p>
						</div>
					</div>
					<div className="flex-1/3 md:flex-1/2">
						<motion.div
							className="relative w-fit shrink-0 max-lg:hidden"
							initial={{ opacity: 0.0, scale: 1.25, x: -10 }}
							animate={{ opacity: 1, scale: 1, x: 0 }}
							transition={{ duration: 0.5, ease: 'easeInOut' }}
						>
							{/* <FloatingFeatureCard
								className="top-0 left-0 -translate-x-8"
								iconContainerClassName="bg-accent/30 text-accent"
								icon={<Icon name="file-list-3-line" />}
								title="Structured modules"
								subtitle="Full GATE Syllabus Coverage"
								floatDelay={1.1}
							/>
							<FloatingFeatureCard
								className="right-0 bottom-0 translate-x-5 -translate-y-5"
								iconContainerClassName="bg-info/30 text-info"
								icon={<Icon name="question-answer-line" />}
								title="1:1 Mentorship"
								subtitle="Personalized Progress Check-ins"
								floatDelay={2.1}
							/> */}
							<div className="bg-primary-soft/90 rotate-2 overflow-hidden rounded-4xl p-3 shadow-lg">
								<div className="-rotate-2 overflow-hidden rounded-4xl bg-white p-4">
									<img
										src={'img/hero.png'}
										alt="Hero Image"
										className="max-h-[calc(60dvh)] rounded-2xl object-cover"
									/>
								</div>
							</div>
						</motion.div>
					</div>
				</div>
			</DotBackground>
		</div>
	)
}

const typewriterWords = [
	{
		text: 'Confidence',
		className: 'textprimary-foreground',
	},
	{
		text: 'Ease',
	},
	{
		text: 'Guidance',
	},
	{
		text: 'Mentorship',
	},
	{
		text: 'Strategy',
	},
	{
		text: 'Precision',
	},
]
