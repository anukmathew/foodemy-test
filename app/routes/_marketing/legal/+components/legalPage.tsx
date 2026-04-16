import { cn } from '#app/utils/misc.tsx'

export default function LegalPage({
	title,
	updatedOn,
	children,
	className,
}: {
	title: string
	updatedOn: string
	children: React.ReactNode
	className?: string
}) {
	return (
		<div className="container flex flex-col items-center gap-24 py-36 lg:px-36">
			<div className="flex flex-col items-center gap-4">
				<span className="text-destructive text-sm font-bold">
					Last updated on{' '}
					{new Date(updatedOn).toLocaleDateString('en-US', {
						year: 'numeric',
						month: 'long',
						day: 'numeric',
					})}
				</span>
				<h1 className="font-display text-5xl font-bold">{title}</h1>
			</div>
			<div className={cn(className)}>{children}</div>
		</div>
	)
}
