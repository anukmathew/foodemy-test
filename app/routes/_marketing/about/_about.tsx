import About from './+sections/about'
import Team from './+sections/team'
import FoodemyTimeline from './+sections/timeline'
import VisionMission from './+sections/vision-mission'
import { type Route } from './+types/_about'

export default function AboutUs() {
	return (
		<>
			<About />
			<VisionMission />
			<Team />
			<FoodemyTimeline />
		</>
	)
}

export const meta: Route.MetaFunction = () => [
	{
		title: 'About us | Foodemy',
	},
	{
		name: 'description',
		content:
			'Learn more about Foodemy, our mission to provide quality GATE coaching, our expert team, and our journey towards empowering students to achieve their dreams.',
	},
]
