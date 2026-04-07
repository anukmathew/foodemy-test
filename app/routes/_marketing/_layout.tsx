import { Outlet } from 'react-router'
import Footer from '#app/components/footer.tsx'
import Navigation from '#app/components/navbar.tsx'

export default function Layout() {
	return (
		<div className="text-primary relative w-full max-w-screen overflow-hidden">
			<Navigation />
			<Outlet />
			<Footer />
		</div>
	)
}
