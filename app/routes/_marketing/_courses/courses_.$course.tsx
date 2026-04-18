import { parseWithZod } from '@conform-to/zod'
import { motion, type Variants } from 'motion/react'
import { Link, useLoaderData } from 'react-router'
import { SpamError } from 'remix-utils/honeypot/server'
import z from 'zod'
import { Badge } from '#app/components/ui/badge.tsx'
import { Icon } from '#app/components/ui/icon.tsx'
import { prisma } from '#app/utils/db.server.ts'
import { honeypot } from '#app/utils/honeypot.server.ts'
import { CourseFooter } from './+sections/course-cta.tsx'
import { Syllabus } from './+sections/syllabus.tsx'
import { type Route } from './+types/courses_.$course.ts'

export const NotificationSchema = z.object({
	email: z.string().email(),
	course: z.string(),
})

const childVariants: Variants = {
	hover: { translateY: 5 },
	rest: {},
}
const parentVariants: Variants = {
	hover: {},
	rest: {},
}

export async function action({ request }: Route.ActionArgs) {
	const formData = await request.formData()
	console.log(formData)
	try {
		await honeypot.check(formData)
	} catch (error) {
		if (error instanceof SpamError) {
			throw new Response('Invalid form submission', { status: 400 })
		}
		throw error
	}
	const submission = parseWithZod(formData, { schema: NotificationSchema })
	if (submission.status !== 'success') {
		return submission.reply()
	}
	const webhookResponse = await fetch(
		'https://discord.com/api/webhooks/1493678857285271744/v1nUzCrh_7BuGXL8EMYDbIAqNn2ILH8FZsIXRQDei4ZMhazS5t5uvFB1ZXkMFN1CpKHv',
		{
			method: 'POST',
			body: JSON.stringify({
				embeds: [
					{
						title: 'Notify Form Submission',
						fields: [
							{
								name: 'Email',
								value: submission.value.email,
							},
							{
								name: 'Course',
								value: submission.value.course,
							},
						],
						color: 0xffdb00,
					},
				],
			}),
			headers: {
				'Content-Type': 'application/json',
			},
		},
	)

	if (!webhookResponse.ok) {
		return submission.reply({
			formErrors: ['Something went wrong. Please try again in a moment.'],
		})
	}

	return { status: 'success' as const, email: submission.value.email }
}

export async function loader({ params }: Route.LoaderArgs) {
	const courseURLName = params.course

	const coursePackage = await prisma.coursePackage.findUnique({
		where: { slug: courseURLName },
		select: {
			id: true,
			name: true,
			slug: true,
			description: true,
			streamInfo: true,
			category: {
				select: {
					name: true,
					id: true,
					whatYouWillGet: {
						select: {
							id: true,
							title: true,
							description: true,
						},
					},
				},
			},
			subjects: {
				select: {
					name: true,
					id: true,
					abbreviation: true,
					sortOrder: true,
				},
			},
			modules: {
				orderBy: { sortOrder: 'asc' },
				select: {
					name: true,
					description: true,
					sortOrder: true,
					topics: {
						orderBy: { sortOrder: 'asc' },
						select: {
							id: true,
							name: true,
							description: true,
							subject: {
								select: {
									id: true,
									name: true,
									abbreviation: true,
									sortOrder: true,
								},
							},
							videoLectures: {
								select: {
									id: true,
									title: true,
									duration: true,
									demoUrl: true,
								},
							},
							studyMaterials: {
								select: {
									id: true,
									title: true,
									demoUrl: true,
									pages: true,
								},
							},
						},
					},
				},
			},
			yearlyProducts: {
				where: { isActive: true },
				orderBy: { year: 'desc' },
				take: 1,
				select: {
					id: true,
					year: true,
					price: true,
					discountedPrice: true,
					accessEndsAt: true,
					batches: {
						where: { isActive: true },
						select: {
							id: true,
							name: true,
							startDate: true,
							endDate: true,
						},
					},
				},
			},
		},
	})

	const latestProduct = coursePackage?.yearlyProducts[0]

	const course = coursePackage
		? {
				...coursePackage,
				courseCategory: coursePackage.category,
				price: latestProduct?.price ?? 0,
				discountedPrice:
					latestProduct?.discountedPrice ?? latestProduct?.price ?? 0,
				accessEndsAt: latestProduct?.accessEndsAt ?? null,
				batches: latestProduct?.batches ?? [],
			}
		: null

	return { course }
}

export const meta: Route.MetaFunction = ({ loaderData }) => [
	{
		title: loaderData?.course?.name || 'Course | Foodemy',
	},
	{
		name: 'description',
		content:
			loaderData?.course?.description ||
			"Crack GATE with Foodemy, India's leading online GATE coaching platform. Expert faculty, comprehensive study materials, and personalized mentorship to help you succeed.",
	},
]

export default function Course() {
	const data = useLoaderData<typeof loader>()

	return (
		<>
			<section className="relative isolate overflow-hidden py-36">
				<div
					className="absolute inset-0 z-0"
					style={{
						backgroundImage: `
        repeating-linear-gradient(0deg, transparent, transparent 10px, rgba(107, 114, 128, 0.04) 10px, rgba(107, 114, 128, 0.04) 11px, transparent 11px, transparent 30px),
        repeating-linear-gradient(90deg, transparent, transparent 10px, rgba(107, 114, 128, 0.04) 10px, rgba(107, 114, 128, 0.04) 11px, transparent 11px, transparent 30px)
      `,
					}}
				/>
				<div
					className="absolute inset-0 -z-1"
					style={{
						background:
							'radial-gradient(125% 125% at 50% 10%, #fff 60%, var(--color-primary) 100%)',
					}}
				/>
				<div className="relative z-10 container mx-auto px-4">
					<div className="mx-auto flex max-w-4xl flex-col items-center gap-4 text-center">
						<Badge
							className="mb-4 w-fit text-sm font-medium"
							variant={'secondary'}
						>
							🚀 GATE 2027 updated
						</Badge>

						<h1 className="font-montserrat to-destructive bg-linear-to-r from-amber-600 via-orange-700 bg-clip-text text-4xl leading-tight font-bold text-balance text-transparent md:text-6xl">
							{data.course?.name}
						</h1>
						<p className="text-secondary mx-auto mb-8 max-w-2xl text-lg">
							{data.course?.description}
						</p>
						{/* <div className="text-muted-foreground mb-8 flex flex-wrap justify-center gap-6 text-sm">
							<div className="flex items-center gap-2">
								<Icon
									name="chalkboard-teacher"
									className="fill-primary text-primary h-5 w-5"
								/>
								<span className="font-medium">4.9 (2,847 reviews)</span>
							</div>
							<div className="flex items-center gap-2">
								<Icon
									name="camera"
									className="text-primary fill-primary h-5 w-5"
								/>
								<span>15,432 students enrolled</span>
							</div>
							<div className="flex items-center gap-2">
								<Icon name="clock" className="text-primary h-5 w-5" />
								<span>40+ hours of content</span>
							</div>
						</div> */}
						<Link to={'#cta'} className="no-underline">
							<motion.div
								className={
									'bg-primary hover:bg-primary/80 text-primary-foreground flex justify-center gap-2 rounded-lg px-6 py-3 font-bold transition'
								}
								variants={parentVariants}
								whileHover="hover"
								initial="rest"
								role="button"
							>
								Notify me
								<motion.div className="inline-block" variants={childVariants}>
									<Icon name="arrow-down-s-line" />
								</motion.div>
							</motion.div>
						</Link>
					</div>
				</div>
			</section>
			{data && <Syllabus data={data} />}
			{data && <CourseFooter data={data} />}
		</>
	)
}
