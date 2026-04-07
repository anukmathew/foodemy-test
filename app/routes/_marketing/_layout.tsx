import { Outlet } from 'react-router'
import Footer from '#app/components/footer.tsx'
import Navigation from '#app/components/navbar.tsx'
import blogStyleSheetUrl from '#app/styles/blog.css?url'
import { type Route } from './+types/_layout'

export default function Layout() {
	return (
		<div className="text-primary relative w-full max-w-screen overflow-hidden">
			<Navigation />
			<Outlet />
			<Footer />
		</div>
	)
}

export const links: Route.LinksFunction = () => {
	return [
		{
			rel: 'stylesheet',
			href: blogStyleSheetUrl,
		},
	].filter(Boolean)
}
