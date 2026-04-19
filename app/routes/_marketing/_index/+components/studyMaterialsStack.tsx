import React, { useEffect, useState } from 'react'
import { cn } from '#app/utils/misc.tsx'
import { Img } from 'openimg/react'

export const StudyMaterialsStack = ({
	images,
	direction = 'up',
	speed = 'fast',
	pauseOnHover = true,
	className,
}: {
	images: string[]
	direction?: 'up' | 'down'
	speed?: 'fast' | 'normal' | 'slow'
	pauseOnHover?: boolean
	className?: string
}) => {
	const containerRef = React.useRef<HTMLDivElement>(null)
	const scrollerRef = React.useRef<HTMLUListElement>(null)
	const [start, setStart] = useState(false)

	useEffect(() => {
		addAnimation()
	}, [])

	function addAnimation() {
		if (containerRef.current && scrollerRef.current) {
			const scrollerContent = Array.from(scrollerRef.current.children)

			// duplicate items for smooth infinite scroll
			scrollerContent.forEach((item) => {
				const duplicatedItem = item.cloneNode(true)
				if (scrollerRef.current) {
					scrollerRef.current.appendChild(duplicatedItem)
				}
			})

			getDirection()
			getSpeed()
			setStart(true)
		}
	}

	const getDirection = () => {
		if (containerRef.current) {
			if (direction === 'up') {
				containerRef.current.style.setProperty(
					'--animation-direction',
					'forwards',
				)
			} else {
				containerRef.current.style.setProperty(
					'--animation-direction',
					'reverse',
				)
			}
		}
	}

	const getSpeed = () => {
		if (containerRef.current) {
			if (speed === 'fast') {
				containerRef.current.style.setProperty('--animation-duration', '20s')
			} else if (speed === 'normal') {
				containerRef.current.style.setProperty('--animation-duration', '40s')
			} else {
				containerRef.current.style.setProperty('--animation-duration', '80s')
			}
		}
	}

	return (
		<div
			ref={containerRef}
			className={cn(
				'scroller relative z-20 h-[10rem] w-1/4 overflow-hidden [mask-image:linear-gradient(to_bottom,transparent,white_20%,white_80%,transparent)]',
				className,
			)}
		>
			<ul
				ref={scrollerRef}
				className={cn(
					'flex h-max min-h-full shrink-0 flex-col flex-nowrap gap-4 py-4',
					start && 'animate-scroll-y',
					pauseOnHover && 'hover:[animation-play-state:paused]',
				)}
			>
				{images.map((image) => (
					<li
						className="group relative flex w-full max-w-full shrink-0 overflow-hidden rounded-2xl border border-zinc-200 bg-[linear-gradient(180deg,#fafafa,#f5f5f5)] dark:border-zinc-700 dark:bg-[linear-gradient(180deg,#27272a,#18181b)]"
						key={image}
					>
						<Img
							src={image}
							width={700}
							height={1000}
							alt=""
							className="h-auto w-full flex-1"
						/>
					</li>
				))}
			</ul>
		</div>
	)
}
