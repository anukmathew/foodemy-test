import { Link } from 'react-router'
import {
	Avatar,
	AvatarFallback,
	AvatarImage,
} from '#app/components/ui/avatar.tsx'
import { Badge } from '#app/components/ui/badge.tsx'
import { Icon } from '#app/components/ui/icon.tsx'
import { type BlogFrontmatter } from '#app/utils/custom-utils/mdx.server.ts'

function FeaturedBlog({ blog, slug }: { blog: BlogFrontmatter; slug: string }) {
	return (
		<Link
			to={`/blog/${slug}`}
			className="flex flex-col overflow-hidden rounded-4xl bg-cover bg-center no-underline shadow-md lg:h-[600px]"
			style={{
				backgroundImage: `url('resources/images?src=${blog.bannerImage}&format=webp&w=1200&h=800&fit=cover')`,
			}}
			prefetch="intent"
		>
			<div className="text-muted/80 mt-auto flex flex-col gap-8 bg-linear-to-t from-black/70 from-60% to-transparent px-8 py-6 pt-24">
				<div className="flex flex-col gap-2">
					<div className="flex gap-3 text-xs md:hidden">
						<span>{blog.author.name}</span> <span>•</span>
						<span>{blog.readingTime.text}</span>
					</div>
					<h3 className="font-sans text-xl font-semibold text-pretty text-white md:text-3xl">
						{blog.title}
					</h3>
					<p className="text-muted/80 text-sm leading-snug md:text-base md:leading-relaxed">
						{blog.description}
					</p>
				</div>
				<div className="flex justify-between">
					<div className="flex gap-8 text-sm">
						<div className="hidden items-center gap-2 md:flex">
							<Avatar className="bg-primary size-8">
								<AvatarImage
									src={blog.author.avatar}
									className="bg-primary translate-y-0.5"
									alt={`${blog.author.name}'s avatar`}
								/>
								<AvatarFallback className="">
									{blog.author.name
										.split(' ')
										.map((word) => word[0])
										.join('')}
								</AvatarFallback>
							</Avatar>
							<span>{blog.author.name}</span>
						</div>
						<div className="flex items-center gap-2">
							<div className="bg-muted/20 flex size-8 items-center justify-center rounded-full">
								<Icon name="calendar-days" />
							</div>
							<span>
								{new Date(blog.date).toLocaleDateString('en-GB', {
									day: 'numeric',
									month: 'short',
									year: 'numeric',
								})}
							</span>
						</div>
					</div>
					<div className="flex flex-wrap items-center gap-2">
						{blog.tags.map((t, i) => (
							<Badge
								key={t}
								variant="outline"
								className={`border-muted/80 text-muted/80 bg-none ${i > 0 ? 'hidden lg:inline-flex' : ''}`}
							>
								{t}
							</Badge>
						))}
					</div>
				</div>
			</div>
		</Link>
	)
}

export default FeaturedBlog
