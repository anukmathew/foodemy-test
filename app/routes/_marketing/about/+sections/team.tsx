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
					delay: 0.3,
					duration: 0.8,
					ease: 'easeInOut',
				}}
				viewport={{ once: true }}
				className="container px-4 xl:px-36"
			>
				<h2 className="text-center">
					The dream <span className="highlight">team</span>
				</h2>
				<motion.div
					className="mt-12 flex flex-wrap justify-center gap-4 sm:gap-8 md:gap-10"
					initial="hidden"
					whileInView="show"
					viewport={{ once: true, amount: 0.2 }}
					variants={cardsContainerVariants}
				>
					{TeamMembers.map((member) => (
						<motion.div
							key={member.name}
							variants={cardVariants}
							className="w-[170px] sm:w-[250px] md:w-[300px]"
						>
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
		image:
			'/resources/images?src=/img/about-us/teammates/akk.webp&format=webp&w=800&h=800&fit=cover',
		// Write a line about avneet being a foodie as well
		bio: 'CEO, strategy machine, and the only reason Foodemy isn’t just a Google Doc with vibes. Walks into meetings with clarity, direction, and actual decisions—deeply unsettling for the rest of us. If there’s a plan, it’s hers. If there isn’t one, she’s already made it. We just catch up eventually. Also, a certified foodie who can probably tell you the best food in any city.',
		linkedIn: 'https://www.linkedin.com/in/avneet-kaur-67832080',
	},
	// {
	// 	name: 'Neha Mahto',
	// 	edu: 'M.Tech | NIFTEM-K',
	// 	image: '/img/teammates/nem.webp',
	// 	bio: 'Part of the Academia pillar, where “good enough” is not a thing. Known for her sharp mind and even sharper standards, she makes sure the content is solid—whether the rest of the team is ready for that level or not. If something passes her check, it’s probably safe to trust it.',
	// 	linkedIn: 'https://www.linkedin.com/in/nehamahto',
	// },
	{
		name: 'Dr. Parinder Kaur',
		edu: 'Ph.D. | ICT-Mumbai',
		image:
			'/resources/images?src=/img/about-us/teammates/prk.webp&format=webp&w=800&h=800&fit=cover',
		bio: 'The "reel" reason people don’t scroll past us. A PhD holder who can teach, present, and market without making it look like effort, she handles social media while making the rest of us question our screen presence. If it looks smooth and engaging online, chances are she had something to do with it.',
		linkedIn: 'https://www.linkedin.com/in/parinderkaur',
	},
	{
		name: 'Shabari Sreenivas',
		edu: 'M.Tech | NIFTEM-K',
		image:
			'/resources/images?src=/img/about-us/teammates/sbs.webp&format=webp&w=800&h=800&fit=cover',
		bio: 'The team’s built-in motivator and full-time conversation starter. Knows exactly what to ask, when to ask it, and how to keep customers convinced. Handles HR and relationships—which makes sense, because he’s been managing people (and situations) long before it became official. If there’s a tricky conversation, it usually ends up with him.',
		linkedIn: 'https://www.linkedin.com/in/shabarisreenivas',
	},
	{
		name: 'Dr. Smriti Chaturvedi',
		edu: 'Ph.D. | ICT-Mumbai',
		image:
			'/resources/images?src=/img/about-us/teammates/smc.webp&format=webp&w=800&h=800&fit=cover',
		bio: 'A PhD holder in Food Biotechnology. Doesn’t say much, doesn’t get into every discussion—and clearly prefers it that way. But when work comes her way, it gets done properly, on time, and without the chaos everyone else seems to generate. Quietly reliable, which in this team is actually a big deal.',
		linkedIn: 'https://www.linkedin.com/in/smriti-chaturvedi',
	},
	{
		name: 'Anu K Mathew',
		edu: 'M.Tech | NIFTEM-K',
		image:
			'/resources/images?src=/img/about-us/teammates/akm.webp&format=webp&w=800&h=800&fit=cover',
		bio: 'Accidental food technologist, accidental developer, and now permanently responsible for “why isn’t this working?” Built this website, fixes the bugs, and silently judges everyone’s “small change” requests. If it works, he built it. If it breaks… also him.',
		// linkedIn: 'https://www.linkedin.com/in/anukmathew',
	},
]
