import { differenceInDays, format, isAfter } from 'date-fns'
import _ from 'lodash'
import { motion, type Variants } from 'motion/react'
import { Link } from 'react-router'
import { Icon } from '#app/components/ui/icon.tsx'
import { cn } from '#app/utils/misc.tsx'
import { type loader } from '../courses._courses'
import { formatINR } from '#app/utils/custom-utils/helpers.ts'

const childVariants: Variants = {
	hover: { translateX: 5 },
	rest: {},
}
const parentVariants: Variants = {
	hover: {},
	rest: {},
}

export default function PricingCard({
	course,
	variants,
	staggerIndex = 0,
}: {
	course: Awaited<ReturnType<typeof loader>>['allCourses'][number]

	variants?: Variants
	staggerIndex?: number
}) {
	const newBatch = _.sortBy(
		_.filter(course.batches, (batch) => {
			return isAfter(batch.startDate, new Date())
		}),
		(batch) => {
			return differenceInDays(batch.startDate, new Date())
		},
	)

	return (
		<motion.div
			className="z-20 flex flex-col gap-6 rounded-xl border bg-white p-6 shadow-lg"
			variants={variants}
			custom={staggerIndex}
			initial="hidden"
			whileInView="show"
			viewport={{ once: true, amount: 0.2 }}
		>
			<div className="flex items-center justify-between">
				<h3
					className={
						'text-primary-foreground font-display font-bold lg:text-lg xl:text-xl'
					}
				>
					{course.name}
				</h3>
				<div>
					{course.price > 0 && course.discountedPrice < course.price && (
						<div
							className={cn(
								'rounded-md px-2 py-1 text-[0.6rem] font-semibold lg:px-1 xl:px-3',
								'bg-accent/10 text-accent',
							)}
						>
							{Math.round(
								((course.price - course.discountedPrice) / course.price) * 100,
							)}
							% OFF
						</div>
					)}
				</div>
			</div>
			<span className={'text-secondary text-4xl font-extrabold'}>
				<span className="mr-2 inline-flex -translate-y-[0.15rem] align-super text-xl">
					₹
				</span>
				{formatINR(course.discountedPrice)}{' '}
				<span className="text-muted-foreground/50 text-lg font-medium">
					<del>{formatINR(course.price)}</del>
				</span>
			</span>

			<hr className="text-secondary/50 mb-2" />
			<div>
				<span className="text-primary-foreground text-sm font-medium">
					Covers the following subjects
				</span>
				<ul className="text-secondary mt-2 ml-4 flex flex-col gap-1 text-sm">
					{_.sortBy(course.subjects, 'sortOrder').map((subject) => (
						<li key={subject.name} className="list-disc">
							{subject.name}
						</li>
					))}
				</ul>
			</div>
			{/* The Icon should animate when the button is hovered */}
			<Link to={course.slug} className="no-underline">
				<motion.div
					className={
						'bg-primary hover:bg-primary/80 text-primary-foreground flex justify-center gap-2 rounded-lg px-4 py-2 font-bold transition'
					}
					variants={parentVariants}
					whileHover="hover"
					initial="rest"
					role="button"
				>
					Learn more
					<motion.div className="inline-block" variants={childVariants}>
						<Icon name="arrow-right" />
					</motion.div>
				</motion.div>
			</Link>
			<hr className="text-muted mt-2" />

			<div className="text-muted-foreground flex flex-col">
				{course.accessEndsAt ? (
					<span className="text-xs">
						Course valid until {course.accessEndsAt.toLocaleDateString()}.
					</span>
				) : null}
				{newBatch.length > 0 ? (
					<span className="text-xs">
						Next batch starts from{' '}
						{newBatch[0]?.startDate
							? format(newBatch[0].startDate, 'do MMMM	')
							: ''}
						.
					</span>
				) : (
					<span className="text-xs">No upcoming batches.</span>
				)}
			</div>
		</motion.div>
	)
}
