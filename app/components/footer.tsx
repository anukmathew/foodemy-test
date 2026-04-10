import { Link } from 'react-router'
import { Logo } from '#app/root.tsx'
import { Icon } from './ui/icon'
import { type IconName } from '@/icon-name'

export default function Footer() {
	return (
		<footer className="text-muted-foreground bg-muted flex flex-col py-4">
			<div className="flex flex-col justify-between gap-8 px-4 py-4 sm:flex-row sm:px-12 sm:py-18">
				<div className="flex flex-col justify-between gap-4">
					<div className="hidden flex-col gap-3 md:flex">
						<Logo variant="dark" />
						<div className="flex flex-col gap-1 text-xs">
							<span>{`Copyright © ${new Date().getFullYear()} Foodemy`}</span>
							<span>All rights reserved</span>
						</div>
					</div>
					<div className="flex flex-col gap-2 rounded-xl">
						<span>Follow us on</span>
						<div className="flex gap-2">
							{SocialIcon(
								'youtube-fill',
								'https://www.youtube.com/foodemyofficial',
								'YouTube',
							)}
							{SocialIcon(
								'instagram-fill',
								'https://www.instagram.com/foodemyofficial',
								'Instagram',
							)}
							{SocialIcon(
								'linkedin-fill',
								'https://www.linkedin.com/company/foodemyofficial',
								'LinkedIn',
							)}
							{SocialIcon(
								'facebook-fill',
								'https://www.facebook.com/foodemyofficial',
								'Facebook',
							)}
						</div>
					</div>
				</div>
				<div className="grid grid-cols-1 justify-between gap-6 sm:grid-cols-2 lg:grid-cols-3">
					<FooterSection
						title="Pages"
						links={[
							{ label: 'Home', href: '/' },
							{ label: 'Courses', href: '/courses' },
							{ label: 'Blog', href: '/blog' },
							{ label: 'About us', href: '/about' },
							{ label: 'Contact', href: '/contact' },
						]}
					/>
					<FooterSection
						title="Legal"
						links={[
							{ label: 'T&C', href: '/legal/tnc' },
							{ label: 'Privacy policy', href: '/legal/privacy-policy' },
							{ label: 'Refund policy', href: '/legal/refund-policy' },
						]}
					/>
					<FooterSection
						title="Contact"
						links={[
							{
								label: '+91 8076828540',
								href: 'tel:8076828540',
								iconName: 'phone',
							},
							{
								label: 'support@foodemy.in',
								href: 'mailto:support@foodemy.in',
								iconName: 'mail',
							},
							{ label: 'Najafgarh, New Delhi', href: '#', iconName: 'map-pin' },
						]}
					/>
				</div>
			</div>
		</footer>
	)

	function SocialIcon(name: IconName, href: string, ariaLbel: string) {
		return (
			<Link
				to={href}
				className="bg-muted-foreground text-muted hover:bg-primary-foreground group flex size-8 cursor-pointer items-center justify-center rounded-full p-1 transition duration-300"
				aria-label={ariaLbel}
			>
				<Icon
					name={name}
					size="md"
					className="group-hover:text-primary transition-all duration-300"
				/>
			</Link>
		)
	}
}

function FooterSection({
	title,
	links,
}: {
	title: string
	links: Array<{ label: string; href: string; iconName?: IconName }>
}) {
	return (
		<div className="flex flex-col gap-4 text-sm">
			<span className="text-foreground font-bold">{title}</span>
			<div className="flex flex-col gap-3">
				{links.map((link) => (
					<Link key={link.label} to={link.href}>
						{link.iconName && (
							<Icon name={link.iconName} size="sm" className="mr-2" />
						)}
						{link.label}
					</Link>
				))}
			</div>
		</div>
	)
}

// Show me all compontents in the shadcn registry
