import { InfiniteMovingTestimonials } from '#app/components/aceternity/infinite-moving-testimonials.tsx'

export default function Testimonials() {
	return (
		<div className="relative flex flex-col items-center justify-center overflow-hidden rounded-md bg-white py-24 antialiased">
			<InfiniteMovingTestimonials
				items={testimonials}
				direction="left"
				speed="slow"
			/>
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
		image: '/img/index/students/1.jpg',
	},
	{
		quote: 'I highly recommend Foodemy for GATE preparation.',
		name: 'Vikram Singh',
		title: 'GATE 2022 Topper',
		image: '/img/index/students/2.jpg',
	},
	{
		quote:
			'The study material provided by Foodemy was comprehensive and easy to follow.',
		name: 'Priya Gupta',
		title: 'GATE 2022 Topper',
		image: '/img/index/students/3.jpg',
	},
	{
		quote:
			'I was able to clear my doubts instantly with the help of Foodemy’s faculty.',
		name: 'Rohan Verma',
		title: 'GATE 2022 Topper',
		image: '/img/index/students/4.jpg',
	},
	{
		quote: 'Foodemy’s mock tests were very helpful in my preparation.',
		name: 'Sneha Patel',
		title: 'GATE 2022 Topper',
		image: '/img/index/students/1.jpg',
	},
]
