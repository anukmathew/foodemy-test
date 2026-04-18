import { motion } from 'motion/react'
import { Link } from 'react-router'
import {
	Accordion,
	AccordionItem,
	AccordionTrigger,
	AccordionContent,
} from '#app/components/ui/accordion.tsx'
import { Icon } from '#app/components/ui/icon.tsx'

// Create a list of faqs based on the existing websote foodemy.in in the format question and explanation

const faqs = [
	{
		question: 'How can I enroll in a course?',
		explanation:
			'To enroll, visit the course page on our website, choose your desired course, and click on the "Enroll Now" button. Follow the checkout process to complete your purchase.',
	},
	{
		question: 'What is the validity of the courses?',
		explanation:
			'Each course comes with a specific validity period. Please refer to the individual course page for exact details.',
	},
	{
		question: 'Do I get lifetime access to the course?',
		explanation:
			'No, access is limited to the validity period mentioned on the course page. Once the validity expires, access to the course materials will be revoked.',
	},
	{
		question: 'Can I download the course materials?',
		explanation:
			'Course materials are available for online access only and cannot be downloaded. This helps us protect our content and ensure a consistent learning experience for all users.',
	},
	{
		question: 'Can I use my account on multiple devices?',
		explanation:
			'You can log in from different devices, but only one active session is allowed at a time. Logging in on a new device will automatically log you out from the previous one.',
	},
	{
		question: 'What is the medium of instruction?',
		explanation: 'The medium of instruction for all our courses is English.',
	},
	{
		question: 'What payment methods are accepted?',
		explanation:
			'We accept major payment options including credit/debit cards, net banking, UPI, and popular wallets for your convenience.',
	},
	{
		question: 'Is there a refund policy?',
		explanation: (
			<>
				We do not offer refunds once a course is purchased. Please review our{' '}
				<Link to="/legal/refund-policy" className="inline-flex">
					refund policy
				</Link>{' '}
				for detailed terms.
			</>
		),
	},
	{
		question: 'Can I access the course on mobile devices?',
		explanation:
			'Yes, our platform is accessible on mobile, tablet, and desktop devices through a web browser.',
	},
	{
		question: 'What happens if I face technical issues?',
		explanation: (
			<>
				If you experience any technical problems, please reach out through our{' '}
				<Link to="/contact" className="inline-flex">
					contact form
				</Link>{' '}
				or email us at{' '}
				<a
					href="mailto:support@foodemy.in"
					className="inline-flex no-underline"
				>
					support@foodemy.in
				</a>
				. Our support team will assist you as soon as possible.
			</>
		),
	},
	{
		question: 'Can I switch to another course after enrolling?',
		explanation:
			'Course switching is generally not allowed after purchase. If you have a special case, please contact support for assistance.',
	},
	{
		question: 'How can I contact support?',
		explanation: (
			<>
				You can reach our support team via the{' '}
				<Link to="/contact" className="inline-flex">
					contact form
				</Link>{' '}
				or email us at{' '}
				<a
					href="mailto:support@foodemy.in"
					className="inline-flex no-underline"
				>
					support@foodemy.in
				</a>
				.
			</>
		),
	},
]

export default function FAQs() {
	return (
		<section className="container flex flex-col gap-24 py-12 sm:gap-36 sm:py-36">
			<div className="mx-auto w-full max-w-[40rem]">
				<h2 className="mb-12 text-center">FAQs</h2>
				<Accordion
					type="single"
					collapsible
					className="w-full"
					defaultValue="item-1"
				>
					{faqs.map((faq, index) => (
						<AccordionItem
							value={`item-${index + 1}`}
							key={index}
							className="border-muted no-underline"
						>
							<AccordionTrigger className="text-secondary font-display text-left text-base font-bold">
								{faq.question}
							</AccordionTrigger>
							<AccordionContent>
								<p className="text-foreground text-sm">{faq.explanation}</p>
							</AccordionContent>
						</AccordionItem>
					))}
				</Accordion>
			</div>
			<div className="text-muted-foreground bg-muted/50 mx-auto flex w-full flex-col items-center gap-4 rounded-2xl px-6 py-12 text-center">
				<p className="text-foreground text-xl font-bold">
					Still have questions?
				</p>
				<p>
					Can't find the answer you're looking for? Please talk to our friendly
					team.
				</p>
				<button className="bg-primary text-primary-foreground hover:bg-primary/80 mt-6 flex w-fit gap-2 rounded-lg px-5 py-2 font-bold transition-colors">
					<motion.div
						animate={{
							rotate: [0, 5, -5, 5, -5, 0], // Wiggle back and forth
						}}
						transition={{
							duration: 0.6,
							ease: 'easeInOut',
							repeat: Infinity, // Keep wiggling forever
							repeatDelay: 1, // Optional: add delay between wiggles
						}}
						className="inline-block"
					>
						<Icon
							name="customer-service-2-fill"
							className="text-primary-foreground"
							size="lg"
						/>
					</motion.div>
					<a href="tel:8076828540" className="inline-flex no-underline">
						Talk to us
					</a>
				</button>
			</div>
		</section>
	)
}
