type BlogImageProps = React.ImgHTMLAttributes<HTMLImageElement> & {
	fit?: 'cover' | 'contain'
	format?: 'webp' | 'avif' | 'jpeg' | 'png'
}

function toDimension(value: number | string | undefined) {
	if (typeof value === 'number') return Number.isFinite(value) ? value : null
	if (typeof value === 'string') {
		const parsed = Number.parseInt(value, 10)
		return Number.isFinite(parsed) ? parsed : null
	}
	return null
}

function toOptimizedSrc({
	src,
	width,
	height,
	fit,
	format,
}: {
	src: string
	width?: number | string
	height?: number | string
	fit?: BlogImageProps['fit']
	format?: BlogImageProps['format']
}) {
	if (src.startsWith('/resources/images') || src.startsWith('data:')) {
		return src
	}

	const params = new URLSearchParams()
	params.set('src', src)

	const parsedWidth = toDimension(width)
	const parsedHeight = toDimension(height)
	if (parsedWidth) params.set('w', String(parsedWidth))
	if (parsedHeight) params.set('h', String(parsedHeight))
	if (fit) params.set('fit', fit)
	if (format) params.set('format', format)

	return `/resources/images?${params.toString()}`
}

export function BlogImage({
	src,
	alt,
	width,
	height,
	fit,
	format,
	...props
}: BlogImageProps) {
	if (!src) return null

	const optimizedSrc = toOptimizedSrc({ src, width, height, fit, format })

	return (
		<img
			src={optimizedSrc}
			alt={alt ?? ''}
			width={width}
			height={height}
			{...props}
		/>
	)
}
