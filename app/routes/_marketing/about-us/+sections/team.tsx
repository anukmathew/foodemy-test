import { motion, useReducedMotion } from 'motion/react'
import TeamMateCard from '../+components/teamMateCard'

export default function Team() {
	const prefersReducedMotion = useReducedMotion()

	const cardsContainerVariants = {
		hidden: {},
		show: {
			transition: {
				delayChildren: prefersReducedMotion ? 0 : 0.15,
				staggerChildren: prefersReducedMotion ? 0 : 0.12,
			},
		},
	}

	const cardVariants = {
		hidden: prefersReducedMotion
			? { opacity: 1, y: 0, scale: 1 }
			: { opacity: 0, y: 24, scale: 0.98 },
		show: {
			opacity: 1,
			y: 0,
			scale: 1,
			transition: {
				duration: prefersReducedMotion ? 0 : 0.5,
			},
		},
	}

	return (
		<section className="w-full py-36 shadow-xl">
			<motion.div
				initial={{ opacity: 0.0, y: 80 }}
				whileInView={{ opacity: 1, y: 0 }}
				transition={{
					delay: 0.1,
					duration: 0.8,
					ease: 'easeInOut',
				}}
				viewport={{ once: true, amount: 0.1 }}
				className="container px-4 xl:px-36"
			>
				<h2 className="text-center">
					The dream <span className="highlight">team</span>
				</h2>
				<motion.div
					className="mt-12 grid grid-cols-2 gap-4 md:gap-12 lg:grid-cols-3"
					initial="hidden"
					whileInView="show"
					viewport={{ once: true, amount: 0.2 }}
					variants={cardsContainerVariants}
				>
					{TeamMembers.map((member) => (
						<motion.div key={member.name} variants={cardVariants}>
							<TeamMateCard {...member} />
						</motion.div>
					))}
				</motion.div>
			</motion.div>
		</section>
	)
}

const TeamMembers = [
	{
		name: 'Avneet Kaur',
		edu: 'M.Tech | NIFTEM-K',
		image: '/img/teammates/akk.webp',
		bio: 'Started with Food Technology, somehow ended up running the whole show. Now our CEO, she keeps the team in line and the vision even tighter. A dancer by passion, so naturally she expects everything—strategy included—to have perfect timing (which Shabari occasionally claims was his idea).',
		linkedIn: 'https://www.linkedin.com/in/avneet-kaur-67832080',
	},
	{
		name: 'Neha Mahto',
		edu: 'M.Tech | NIFTEM-K',
		image: '/img/teammates/nem.webp',
		bio: 'The gold medalist who makes “difficult” look like a personality trait. She sets standards so high they’re almost offensive, then casually meets them. If something feels too easy, she probably hasn’t reviewed it yet—and that’s when people get nervous.',
		linkedIn: 'https://www.linkedin.com/in/nehamahto',
	},
	{
		name: 'Dr. Parinder Kaur',
		edu: 'Ph.D. | ICT-Mumbai',
		image: '/img/teammates/prk.webp',
		bio: 'Has a PhD, explains food science, and somehow still has time to look like a content creator doing it. Turns complex topics into something people actually want to watch—occasionally making the rest of the team wonder if they should try being more interesting.',
		linkedIn: 'https://www.linkedin.com/in/parinderkaur',
	},
	{
		name: 'Shabari Sreenivas',
		edu: 'M.Tech | NIFTEM-K',
		image: '/img/teammates/sbs.webp',
		bio: 'Claims he’s not the CEO. Makes decisions like he is. Coincidence? Unlikely. The team’s unofficial strategist who somehow turns his ideas into “team consensus” without anyone noticing. Always thinking three steps ahead—mainly so he can say “I told you so” later (quietly, of course).',
		linkedIn: 'https://www.linkedin.com/in/shabarisreenivas',
	},
	{
		name: 'Dr. Smriti Chaturvedi',
		edu: 'Ph.D. | ICT-Mumbai',
		image: '/img/teammates/smc.webp',
		bio: 'With a PhD in Food Microbiology, she knows more about microbes than most people know about their friends. You won’t hear her in every discussion—but give her a task, and it gets done properly, without drama or reminders. She prefers letting her work speak—and it does, with clarity, rigor, and impact.',
		linkedIn: 'https://www.linkedin.com/in/smriti-chaturvedi',
	},
	{
		name: 'Anu K Mathew',
		edu: 'M.Tech | NIFTEM-K',
		image: '/img/teammates/akm.webp',
		bio: 'The reason this website works—and occasionally even looks good. A self-taught developer who fixes bugs before anyone else notices them, which is great because everyone else definitely wouldn’t. Quietly translating the team’s chaos into clean, functioning code.',
		linkedIn: 'https://www.linkedin.com/in/anukmathew',
	},
]
