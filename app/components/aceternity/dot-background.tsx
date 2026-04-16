import { cn } from '#app/utils/misc.tsx'

export function DotBackground({ children }: { children: React.ReactNode }) {
	return (
		<section className="from-destructive/20 relative flex min-h-[calc(100dvh-(--spacing(48)))] w-full items-center justify-center bg-linear-to-tr via-white via-30% to-white max-lg:min-h-min dark:bg-black">
			<div
				className={cn(
					'absolute inset-0',
					'bg-size-[20px_20px]',
					'bg-[radial-gradient(#d4d4d4_1px,transparent_1px)]',
					'dark:bg-[radial-gradient(#404040_1px,transparent_1px)]',
				)}
			/>
			{/* Radial gradient for the container to give a faded look */}
			<div className="pointer-events-none absolute inset-0 flex items-center justify-center bg-white mask-[radial-gradient(ellipse_at_center,transparent_20%,black)] dark:bg-black"></div>
			<div className="relative z-20 bg-linear-to-b from-neutral-200 to-neutral-500 bg-clip-text py-8 text-4xl font-bold text-transparent sm:text-7xl">
				{children}
			</div>
		</section>
	)
}
