import AboutFoodemy from './+sections/about-foodemy.tsx'
import Hero from './+sections/hero.tsx'
import Testimonials from './+sections/testimonials.tsx'
import TrustedBy from './+sections/trusted-by.tsx'
import WhatIsFygate from './+sections/fygate-course.tsx'
import WhyUs from './+sections/why-choose-foodemy.tsx'
import { type Route } from './+types/index.ts'

export const meta: Route.MetaFunction = () => [
	{
		title: 'Home | Foodemy',
	},
	{
		name: 'description',
		content:
			'Crack GATE with Foodemy, India’s leading online GATE coaching platform. Expert faculty, comprehensive study materials, and personalized mentorship to help you succeed.',
	},
]

// Tailwind Grid cell classes lookup

export default function Index() {
	return (
		<div>
			<Hero />
			<TrustedBy />
			<Testimonials />
			<WhatIsFygate />
			<WhyUs />
			<AboutFoodemy />
		</div>
	)
}
