import { AnimatePresence, motion } from 'motion/react'

import { useState } from 'react'
import { cn } from '#app/utils/misc.tsx'

export const HoverEffect = ({
	items,
	containerClassName,
	titleClassName,
	descriptionClassName,
	className,
	hoverClassName,
}: {
	items: {
		title: string
		description: string
		link: string
	}[]
	className?: string
	containerClassName?: string
	titleClassName?: string
	descriptionClassName?: string
	hoverClassName?: string
}) => {
	let [hoveredIndex, setHoveredIndex] = useState<number | null>(null)

	return (
		<div
			className={cn(
				'grid grid-cols-1 py-10 md:grid-cols-2 lg:grid-cols-3',
				className,
			)}
		>
			{items.map((item, idx) => (
				<a
					href={item?.link}
					key={idx}
					className="group relative block h-full w-full p-2 no-underline"
					onMouseEnter={() => setHoveredIndex(idx)}
					onMouseLeave={() => setHoveredIndex(null)}
				>
					<AnimatePresence>
						{hoveredIndex === idx && (
							<motion.span
								className={cn(
									'absolute inset-0 block h-full w-full rounded-3xl',
									hoverClassName,
								)}
								layoutId="hoverBackground"
								initial={{ opacity: 0 }}
								animate={{
									opacity: 1,
									transition: { duration: 0.15 },
								}}
								exit={{
									opacity: 0,
									transition: { duration: 0.15, delay: 0.2 },
								}}
							/>
						)}
					</AnimatePresence>
					<Card className={containerClassName}>
						<CardTitle className={titleClassName}>{item.title}</CardTitle>
						<CardDescription className={descriptionClassName}>
							{item.description}
						</CardDescription>
					</Card>
				</a>
			))}
		</div>
	)
}

export const Card = ({
	className,
	children,
}: {
	className?: string
	children: React.ReactNode
}) => {
	return (
		<div
			className={cn(
				'relative z-20 h-full w-full overflow-hidden rounded-2xl border border-transparent p-4 dark:border-white/20',
				className,
			)}
		>
			<div className="relative z-50">
				<div className="p-4">{children}</div>
			</div>
		</div>
	)
}
export const CardTitle = ({
	className,
	children,
}: {
	className?: string
	children: React.ReactNode
}) => {
	return (
		<h4 className={cn('font-bold tracking-wide', className)}>{children}</h4>
	)
}
export const CardDescription = ({
	className,
	children,
}: {
	className?: string
	children: React.ReactNode
}) => {
	return (
		<p
			className={cn(
				'mt-8 text-sm leading-relaxed tracking-wide text-zinc-400',
				className,
			)}
		>
			{children}
		</p>
	)
}
