import { motion } from 'motion/react'
import React, { useState } from 'react'
import { NavLink } from 'react-router'
import { Logo } from '#app/root.tsx'
import { cn } from '#app/utils/misc.tsx'

const transition = {
	type: 'spring' as const,
	mass: 0.5,
	damping: 11.5,
	stiffness: 100,
	restDelta: 0.001,
	restSpeed: 0.001,
}

export const MenuItem = ({
	setActive,
	active,
	item,
	children,
}: {
	setActive: (item: string) => void
	active: string | null
	item: string
	children?: React.ReactNode
}) => {
	return (
		<div onMouseEnter={() => setActive(item)} className="relative">
			<motion.p
				transition={{ duration: 0.3 }}
				className="cursor-pointer text-black hover:opacity-[0.9] dark:text-white"
			>
				{item}
			</motion.p>
			{active !== null && (
				<motion.div
					initial={{ opacity: 0, scale: 0.85, y: 10 }}
					animate={{ opacity: 1, scale: 1, y: 0 }}
					transition={transition}
				>
					{active === item && (
						<div className="absolute top-[calc(100%_+_1.2rem)] left-1/2 -translate-x-1/2 transform pt-4">
							<motion.div
								transition={transition}
								layoutId="active" // layoutId ensures smooth animation
								className="overflow-hidden rounded-2xl border border-black/[0.2] bg-white shadow-xl backdrop-blur-sm dark:border-white/[0.2] dark:bg-black"
							>
								<motion.div
									layout // layout ensures smooth animation
									className="h-full w-max p-4"
								>
									{children}
								</motion.div>
							</motion.div>
						</div>
					)}
				</motion.div>
			)}
		</div>
	)
}

export const Menu = ({
	setActive,
	children,
}: {
	setActive: (item: string | null) => void
	children: React.ReactNode
}) => {
	return (
		<nav
			onMouseLeave={() => setActive(null)} // resets the state
			className="bg-background/60 border-foreground/10 relative flex justify-center space-x-4 rounded-full border px-8 py-6 shadow-lg backdrop-blur-2xl"
		>
			{children}
		</nav>
	)
}

// export const ProductItem = ({
// 	title,
// 	description,
// 	href,
// 	src,
// }: {
// 	title: string
// 	description: string
// 	href: string
// 	src: string
// }) => {
// 	return (
// 		<a href={href} className="flex space-x-2">
// 			<img
// 				src={src}
// 				width={140}
// 				height={70}
// 				alt={title}
// 				className="shrink-0 rounded-md shadow-2xl"
// 			/>
// 			<div>
// 				<h4 className="mb-1 text-xl font-bold text-black dark:text-white">
// 					{title}
// 				</h4>
// 				<p className="max-w-[10rem] text-sm text-neutral-700 dark:text-neutral-300">
// 					{description}
// 				</p>
// 			</div>
// 		</a>
// 	)
// }

// export const HoveredLink = ({ children, ...rest }: any) => {
// 	return (
// 		<a
// 			{...rest}
// 			className="text-neutral-700 hover:text-black dark:text-neutral-200"
// 		>
// 			{children}
// 		</a>
// 	)
// }

export default function Navbar({ className }: { className?: string }) {
	const [active, setActive] = useState<string | null>(null)
	return (
		<nav
			className={cn(
				'font-montserrat fixed inset-x-0 top-10 z-50 mx-auto max-w-3xl',
				className,
			)}
		>
			<Menu setActive={setActive}>
				<div className="flex w-full justify-between">
					<Logo size="lg" />
					<div className="flex gap-6">
						<NavLink to="/">Home</NavLink>
						<NavLink to="/courses">Courses</NavLink>
						<NavLink to="/">Blog</NavLink>
						<NavLink to="/">About us</NavLink>
						<NavLink to="/">Contact</NavLink>
					</div>
				</div>
			</Menu>
		</nav>
	)
}
