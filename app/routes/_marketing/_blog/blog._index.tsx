import _ from 'lodash'
import { useLoaderData } from 'react-router'
import { getAllMDXSlugs } from '#app/utils/custom-utils/mdx.server.ts'
import { BlogCard } from './+components/blogCard.tsx'
import FeaturedBlog from './+components/featuredBlog.tsx'
import { type Route } from './+types/blog._index.ts'

export const meta: Route.MetaFunction = () => [
	{
		title: 'Blog | Foodemy',
	},
	{
		name: 'description',
		content:
			'Read the latest articles on GATE preparation, study tips, and engineering topics on the Foodemy blog. Stay updated with expert insights and resources to ace your GATE exam.',
	},
]

export async function loader({}: Route.LoaderArgs) {
	const slugs = await getAllMDXSlugs('blogs')
	return { slugs }
}

export default function Blog() {
	const data = useLoaderData<typeof loader>()
	const sortedBlogs = _.sortBy(data.slugs, (b) => b.frontmatter.date).reverse()
	const featuredBlog = sortedBlogs[0]!

	return (
		<div className="container flex flex-col gap-12 py-36">
			<section aria-labelledby="featured" className="">
				<h2 id="featured" className="sr-only">
					Featured article
				</h2>
				<FeaturedBlog
					blog={featuredBlog?.frontmatter}
					slug={featuredBlog?.slug}
				/>
			</section>
			<section
				id="all-articles"
				className="grid grid-cols-1 gap-6 md:grid-cols-2 lg:grid-cols-3"
			>
				{sortedBlogs.slice(1).map((blog) => (
					<div key={blog.slug} className="text-lg">
						<BlogCard blog={blog.frontmatter} slug={blog.slug} />
					</div>
				))}
			</section>
		</div>
	)
}
