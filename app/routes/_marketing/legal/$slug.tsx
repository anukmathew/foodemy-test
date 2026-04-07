import { invariant } from '@epic-web/invariant'
import { getMDXComponent } from 'mdx-bundler/client'
import { useMemo } from 'react'
import { useLoaderData } from 'react-router'
import { getMDXPage } from '#app/utils/custom-utils/mdx.server.ts'
import LegalPage from './+components/legalPage'
import { type Route } from './+types/$slug'

export async function loader({ params }: Route.LoaderArgs) {
	const { slug } = params
	invariant(slug, 'An id is required')
	const page = await getMDXPage({ dir: 'legal', slug })
	return {
		page,
		headers: {
			'Cache-Control': 'public, max-age=3600',
		},
	}
}

export const meta: Route.MetaFunction = ({ loaderData }) => [
	{
		title: loaderData?.page.frontmatter.title || 'Legal | Foodemy',
	},
	{
		name: 'description',
		content:
			loaderData?.page.frontmatter.description || 'A legal page from Foodemy',
	},
]

export default function Legal() {
	const { page } = useLoaderData<typeof loader>()
	const Component = useMemo(() => getMDXComponent(page.code), [page.code])
	return (
		<>
			<LegalPage
				title={page.frontmatter.title}
				updatedOn={page.frontmatter.date}
				className="prose"
			>
				<Component />
			</LegalPage>
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
			<h1>Error loading legal page</h1>
			<p>{message}</p>
		</div>
	)
}
