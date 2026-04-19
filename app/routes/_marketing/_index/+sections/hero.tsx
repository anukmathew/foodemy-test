import { motion } from 'motion/react'
import { Link } from 'react-router'
import { DotBackground } from '#app/components/aceternity/dot-background.tsx'
import { TypewriterEffectSmooth } from '#app/components/aceternity/typewriter-effect.tsx'
import { Icon } from '#app/components/ui/icon.tsx'
import { StudentsCount } from '../+components/avatar-group'
import { Img } from 'openimg/react'

export default function Hero() {
	return (
		<DotBackground>
			<div className="container mx-auto flex flex-col items-center gap-12 pt-25 pb-24 md:pt-30 lg:flex-row xl:min-h-[calc(100dvh-(--spacing(48)))] 2xl:min-h-fit">
				<div className="flex flex-2/3 flex-col items-center gap-12 text-center lg:items-start lg:text-left">
					<div className="flex flex-col gap-6">
						<h1 className="text-primary-foreground font-serif text-3xl leading-tight font-semibold tracking-tight md:text-6xl">
							Master GATE XE/XL Food Technology
							<br /> with{' '}
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
							className="text-primary-foreground bg-primary hover:bg-primary-soft hover:text-primary-soft-foreground flex items-center justify-center rounded-full px-6 py-3 text-base font-semibold no-underline shadow-md duration-300 hover:-translate-y-[2px] hover:scale-105 hover:shadow-xl"
							aria-label="Link to enroll in Foodemy's courses"
						>
							Enroll now
							<Icon name="arrow-right" className="ml-2" />
						</Link>
						<Link
							to="courses"
							className="text-muted-foreground bg-muted hover:bg-primary-soft hover:text-primary-soft-foreground flex items-center justify-center rounded-full px-6 py-3 text-base font-normal no-underline shadow-md duration-300 hover:-translate-y-[2px] hover:scale-105 hover:shadow-xl"
							aria-label="Link to know more about Foodemy's courses"
						>
							<span>Explore courses</span>
						</Link>
					</div>
					<div className="mt-6 flex items-center gap-6">
						<StudentsCount />
						<p className="text-muted-foreground ml-2 text-sm font-normal">
							Trusted by over <span className="font-bold">300+ students </span>
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
						<div className="bg-primary-soft/90 rotate-2 overflow-hidden rounded-4xl p-3 shadow-lg">
							<div className="-rotate-2 overflow-hidden rounded-4xl bg-white p-4">
								<Img
									src={'/img/index/hero.png'}
									width={900}
									height={1200}
									isAboveFold
									fetchPriority="high"
									fit="cover"
									alt="Hero Image"
									className="max-h-[calc(60dvh)] rounded-2xl object-cover"
								/>
							</div>
						</div>
					</motion.div>
				</div>
			</div>
		</DotBackground>
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
