import { Link } from 'react-router'
import { Badge } from '#app/components/ui/badge.tsx'
import {
	Card,
	CardHeader,
	CardTitle,
	CardContent,
	CardFooter,
} from '#app/components/ui/card.tsx'
import { Icon } from '#app/components/ui/icon.tsx'
import { type BlogFrontmatter } from '#app/utils/custom-utils/mdx.server.ts'

export function BlogCard({
	blog,
	slug,
}: {
	blog: BlogFrontmatter
	slug: string
}) {
	return (
		<Link to={`/blog/${slug}`} className="h-full" prefetch="intent">
			<Card className="border-muted group flex h-full flex-col overflow-hidden rounded-4xl">
				<div className="relative rounded-4xl pt-4 pr-4 pl-4">
					<div className="overflow-hidden rounded-2xl">
						<img
							src={
								blog.bannerImage ||
								'/placeholder.svg?height=360&width=640&query=blog-cover'
							}
							alt={`${blog.title} cover`}
							className="h-56 w-full object-cover transition-transform duration-300 ease-in-out group-hover:scale-105"
						/>
					</div>
				</div>
				<CardHeader className="flex flex-col gap-1 p-4 pb-0">
					<div className="text-muted-foreground flex flex-wrap items-center gap-2 text-xs">
						<span>{blog.author.name}</span>{' '}
						<span className="text-muted-foreground/60">•</span>
						<span>{blog.readingTime.text}</span>
					</div>
					<div className="flex justify-between">
						<CardTitle className="text-lg text-pretty">{blog.title}</CardTitle>
						<div className="w-7">
							<Icon
								name="arrow-right-up-line"
								className="text-muted-foreground/60 size-7"
							/>
						</div>
					</div>
				</CardHeader>
				<CardContent className="flex flex-col gap-4 p-4 pt-2">
					<p className="text-muted-foreground text-sm leading-relaxed">
						{blog.description}
					</p>
				</CardContent>
				<CardFooter className="flex grow p-4">
					<div className="mt-auto flex items-center gap-4">
						<div className="flex flex-wrap gap-2">
							<Badge className="text-xs" variant={'secondary'}>
								{blog.tags[0]}
							</Badge>
						</div>
						<span className="text-xs">
							{new Date(blog.date).toLocaleDateString('en-GB', {
								day: 'numeric',
								month: 'short',
								year: 'numeric',
							})}
						</span>
					</div>
				</CardFooter>
			</Card>
		</Link>
	)
}
