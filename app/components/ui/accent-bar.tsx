export default function AccentBar({
	orientation = 'vertical',
	color = 'accent',
}: {
	orientation?: 'vertical' | 'horizontal'
	color?: 'primary' | 'secondary' | 'accent' | 'destructive'
}) {
	const colorClass =
		color === 'primary'
			? 'bg-primary'
			: color === 'destructive'
				? 'bg-destructive'
				: color === 'accent'
					? 'bg-accent'
					: 'bg-secondary'

	return orientation === 'vertical' ? (
		<div className={`${colorClass} mr-1 h-8 w-1`}></div>
	) : (
		<div
			className={`${colorClass} mt-1 flex h-1 w-8 items-center justify-center`}
		></div>
	)
}
