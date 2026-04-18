import { useLoaderData } from 'react-router'
import { prisma } from '#app/utils/db.server.ts'
import AllCourses from './+sections/all-courses.tsx'
import FAQs from './+sections/faq.tsx'
import Introduction from './+sections/introduction.tsx'
import WhatYouWillGet from './+sections/what-you-will-get.tsx'
import { type Route } from './+types/courses._courses.ts'

export async function loader({ request: _request }: Route.LoaderArgs) {
	const allCourses = await prisma.coursePackage.findMany({
		where: {
			isActive: true,
			category: { name: 'GATE', isActive: true },
		},
		select: {
			id: true,
			name: true,
			slug: true,
			description: true,
			subjects: {
				select: { name: true, id: true, sortOrder: true },
			},
			sortOrder: true,
			yearlyProducts: {
				where: { isActive: true },
				orderBy: { year: 'desc' },
				take: 1,
				select: {
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
		orderBy: { name: 'asc' },
	})

	const mappedCourses = allCourses.map((coursePackage) => {
		const latestProduct = coursePackage.yearlyProducts[0]
		return {
			id: coursePackage.id,
			name: coursePackage.name,
			slug: coursePackage.slug,
			description: coursePackage.description,
			price: latestProduct?.price ?? 0,
			sortOrder: coursePackage.sortOrder,
			discountedPrice:
				latestProduct?.discountedPrice ?? latestProduct?.price ?? 0,
			accessEndsAt: latestProduct?.accessEndsAt ?? null,
			subjects: coursePackage.subjects,
			batches: latestProduct?.batches ?? [],
		}
	})
	const courseCategory = await prisma.courseCategory.findFirst({
		where: { name: 'GATE' },
		select: {
			whatYouWillGet: { select: { id: true, title: true, description: true } },
		},
	})

	return { allCourses: mappedCourses, courseCategory }
}

export const meta: Route.MetaFunction = () => [
	{
		title: 'Courses | Foodemy',
	},
	{
		name: 'description',
		content:
			"Explore Foodemy's comprehensive GATE courses with expert faculty, personalized mentorship, and extensive study materials to help you succeed.",
	},
]

export default function CoursesPage() {
	const data = useLoaderData<typeof loader>()
	return (
		<>
			<Introduction />
			<AllCourses data={data} />
			<WhatYouWillGet data={data} />
			<FAQs />
		</>
	)
}

// export async function loader({ request }: Route.LoaderArgs) {
// 	const videoTokens = await generateVideoTokens({
// 		playbackId: 'pjCodmkImuzlUJMmLpPRxKxaH017D8EZy368O02x25YJg',
// 	})
// 	return videoTokens
// }

// <MuxPlayer
// 	playbackId="pjCodmkImuzlUJMmLpPRxKxaH017D8EZy368O02x25YJg"
// 	accentColor="#ffdb00"
// 	title="Hello there"
// 	placeholder={data.blurDataURL}
// 	style={{ aspectRatio: data.aspectRatio }}
// 	tokens={{
// 		playback: data.playbackToken,
// 		thumbnail: data.thumbnailToken,
// 	}}
// />
