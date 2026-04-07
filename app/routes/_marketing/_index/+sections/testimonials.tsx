import { InfiniteMovingCards } from '#app/components/aceternity/infinite-moving-cards.tsx'

export default function Testimonials() {
	return (
		<div
			className="relative flex flex-col items-center justify-center overflow-hidden rounded-md bg-white py-24 antialiased"
			// initial={{ opacity: 0.0, y: 80 }}
			// whileInView={{ opacity: 1, y: 0 }}
			// transition={{
			// 	delay: 0.3,
			// 	duration: 0.8,
			// 	ease: 'easeInOut',
			// }}
			// viewport={{ once: true }}
		>
			<InfiniteMovingCards items={testimonials} direction="left" speed="slow" />
		</div>
	)
}

// generate an array of testimonials of the shape {quote: string, name: string, title: string} of students (indian names) talking about how they cracked GATE through Foodemy's online GATE coaching
const testimonials = [
	{
		quote:
			'Foodemy’s online coaching helped me understand complex concepts easily.',
		name: 'Aarav Sharma',
		title: 'GATE 2022 Topper',
	},
	{
		quote:
			'The study material provided by Foodemy was comprehensive and easy to follow.',
		name: 'Priya Gupta',
		title: 'GATE 2022 Topper',
	},
	{
		quote:
			'I was able to clear my doubts instantly with the help of Foodemy’s faculty.',
		name: 'Rohan Verma',
		title: 'GATE 2022 Topper',
	},
	{
		quote: 'Foodemy’s mock tests were very helpful in my preparation.',
		name: 'Sneha Patel',
		title: 'GATE 2022 Topper',
	},
	{
		quote: 'I highly recommend Foodemy for GATE preparation.',
		name: 'Vikram Singh',
		title: 'GATE 2022 Topper',
	},
]
