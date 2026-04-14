export default function YTVideoCard({
	link,
	title,
}: {
	link: string
	title: string
}) {
	return (
		<div className="relative h-0 w-full overflow-hidden rounded-2xl pb-[56.25%]">
			<iframe
				src={link}
				style={{
					position: 'absolute',
					top: 0,
					left: 0,
					width: '100%',
					height: '100%',
				}}
				allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
				allowFullScreen
				title={title}
			></iframe>
		</div>
	)
}
