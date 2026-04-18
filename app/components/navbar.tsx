import { useState } from 'react'
import { Link } from 'react-router'
import {
	MobileNav,
	MobileNavHeader,
	MobileNavMenu,
	MobileNavToggle,
	NavbarButton,
	NavbarLogo,
	NavBody,
	NavItems,
	Navbar,
} from '#app/components/aceternity/resizable-navbar.tsx'

export default function Navigation() {
	const navItems = [
		{
			name: 'Home',
			link: '/',
		},
		{
			name: 'Courses',
			link: '/courses',
		},
		{
			name: 'Blog',
			link: '/blog',
		},
		{
			name: 'About us',
			link: '/about',
		},
		{
			name: 'Contact',
			link: '/contact',
		},
	]
	const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false)
	return (
		<>
			<div className="fixed inset-0 z-30 h-25">
				<div className="from-muted/50 absolute inset-0 bg-linear-to-b to-transparent mask-b-from-50% mask-b-to-transparent backdrop-blur-3xl" />
			</div>

			<Navbar>
				{/* Desktop Navigation */}
				<NavBody>
					<NavbarLogo />
					<NavItems items={navItems} />
					<NavbarButton className="bg-primary text-primary-foreground hover:bg-primary-soft border-primary-soft-foreground flex cursor-pointer items-center rounded-full px-10 py-2 font-bold transition duration-300">
						<Link to={'login'} className="no-underline">
							Login
						</Link>
					</NavbarButton>
				</NavBody>

				{/* Mobile Navigation */}
				<MobileNav>
					<MobileNavHeader>
						<NavbarLogo />
						<MobileNavToggle
							isOpen={isMobileMenuOpen}
							onClick={() => setIsMobileMenuOpen(!isMobileMenuOpen)}
						/>
					</MobileNavHeader>

					<MobileNavMenu
						isOpen={isMobileMenuOpen}
						onClose={() => setIsMobileMenuOpen(false)}
					>
						{navItems.map((item, idx) => (
							<a
								key={`mobile-link-${idx}`}
								href={item.link}
								onClick={() => setIsMobileMenuOpen(false)}
								className="relative text-neutral-600 no-underline dark:text-neutral-300"
							>
								<span className="block">{item.name}</span>
							</a>
						))}
						<div className="flex w-full flex-col gap-4">
							<Link to={'/login'}>
								<NavbarButton
									onClick={() => setIsMobileMenuOpen(false)}
									variant="primary"
									className="w-full"
								>
									Login
								</NavbarButton>
							</Link>
						</div>
					</MobileNavMenu>
				</MobileNav>
			</Navbar>
		</>
	)
}
