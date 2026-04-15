import { invariant } from '@epic-web/invariant'
import { getMDXComponent } from 'mdx-bundler/client'
import { useMemo } from 'react'
import { data, useLoaderData } from 'react-router'
import { Icon } from '#app/components/ui/icon.tsx'
import { getMDXPage } from '#app/utils/custom-utils/mdx.server.ts'
import { pipeHeaders } from '#app/utils/headers.server.ts'
import { getDomainUrl } from '#app/utils/misc.tsx'
import BlogPage from './+components/blogPage.tsx'
import { type Route } from './+types/blog_.$slug.ts'

export async function loader({ params, request }: Route.LoaderArgs) {
	const { slug } = params
	invariant(slug, 'Blog id is required')
	const blog = await getMDXPage({ dir: 'blogs', slug })
	return data(
		{
			blog,
			domainUrl: getDomainUrl(request),
			slug,
		},
		{
			headers: {
				'Cache-Control':
					'public, max-age=3600, s-maxage=86400, stale-while-revalidate=604800',
			},
		},
	)
}

export const headers: Route.HeadersFunction = pipeHeaders

export const meta: Route.MetaFunction = ({ loaderData }) => [
	{
		title: loaderData?.blog.frontmatter.title || 'Blog | Foodemy',
	},
	{
		name: 'description',
		content:
			loaderData?.blog.frontmatter.description || 'A blog post from Foodemy',
	},
]

export default function Blog() {
	const { blog, domainUrl, slug } = useLoaderData<typeof loader>()

	const Component = useMemo(() => getMDXComponent(blog.code), [blog.code])
	return (
		<>
			<BlogPage
				frontMatter={blog.frontmatter}
				domainUrl={domainUrl}
				slug={slug}
			>
				<Component
					components={{
						figcaption: (caption) => {
							return (
								<div className="text-muted-foreground/80 mt-4 flex items-center gap-2 text-sm">
									<Icon
										name="link-m"
										className="text-muted-foreground/40 size-5"
									/>{' '}
									{caption.children}
								</div>
							)
						},
					}}
				/>
			</BlogPage>
		</>
	)
}

export function ErrorBoundary({ error }: { error: Error | Response }) {
	const message =
		error instanceof Response
			? `${error.status} - ${error.statusText || 'MDX file not found'}`
			: error.message

	return (
		<div className="prose container py-36">
			<h1>Error loading blog</h1>
			<p>{message}</p>
		</div>
	)
}

export const links: Route.LinksFunction = () => {
	return [
		{
			rel: 'stylesheet',
			href: 'https://cdn.jsdelivr.net/npm/katex@0.16.8/dist/katex.min.css',
		},
	].filter(Boolean)
}
