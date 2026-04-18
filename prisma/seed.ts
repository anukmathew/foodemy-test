import { type Permission as _Permission, type Subject } from '@prisma/client'
import { prisma } from '#app/utils/db.server.ts'
import { bcSyllabus } from '../other/syllabus/bc'
import { chSyllabus } from '../other/syllabus/ch'
import { emSyllabus } from '../other/syllabus/em'
import { ftSyllabus } from '../other/syllabus/ft'
import { gaSyllabus } from '../other/syllabus/ga'
import { mbSyllabus } from '../other/syllabus/mb'
import { thSyllabus } from '../other/syllabus/th'

const features = [
	{
		title: 'High Quality Video Lectures',
		description:
			'Our expert faculty brings their wealth of knowledge and teaching experience to deliver high-quality video lectures. These engaging and informative sessions ensure you grasp even the most complex concepts with ease, at your own pace.',
	},
	{
		title: 'Crisp and Concise Study Materials',
		description:
			'We provide you with crisp and concise study materials, eliminating the need for exhaustive searches through numerous books. Our materials are thoughtfully curated, focusing on the most relevant GATE syllabus topics, saving you valuable time and effort.',
	},
	{
		title: 'Solved Previous Year Questions',
		description:
			"Access to solved previous year questions helps you understand the exam's pattern and gain insight into the frequently asked topics, giving you the competitive edge you need.",
	},
	{
		title: 'Practice Questions',
		description:
			'Practice makes perfect! Our extensive repository of practice questions challenges your problem-solving skills and reinforces your understanding of the subject matter, ensuring you are well-prepared to tackle any GATE question.',
	},
	{
		title: 'Mentorship from Subject Experts',
		description:
			'At fyGATE, we believe in providing personalized attention. Benefit from mentorship from our experienced subject experts who guide you throughout your GATE preparation journey, offering valuable insights and support.',
	},
	{
		title: 'Mock Test on Dedicated Platform',
		description:
			'Evaluate your progress and build confidence with our mock tests conducted on dedicated platform. These tests simulate the actual GATE exam environment, preparing you to excel on the big day.',
	},
	{
		title: 'Doubt Clearance Sessions',
		description:
			'We understand that doubts can hinder progress. Our dedicated doubt clearance systems offer you the opportunity to seek clarifications on any topic, leaving no room for confusion.',
	},
	{
		title: 'Personal Mentoring Sessions',
		description:
			'Our commitment to your success goes beyond conventional coaching. Personal mentoring sessions allow you to interact one-on-one with our faculty, enabling customized learning and addressing specific challenges.',
	},
]

const subjectDefinitions = [
	{
		name: 'General Aptitude',
		abbreviation: 'GA',
		description: 'General aptitude topics common across GATE streams.',
		sortOrder: 1,
	},
	{
		name: 'Engineering Mathematics',
		abbreviation: 'EM',
		description: 'Engineering mathematics for GATE XE streams.',
		sortOrder: 2,
	},
	{
		name: 'Thermodynamics',
		abbreviation: 'TH',
		description: 'Thermodynamics syllabus for GATE XE.',
		sortOrder: 3,
	},
	{
		name: 'Food Technology',
		abbreviation: 'FT',
		description:
			'Core food technology syllabus shared across XE and XL packages.',
		sortOrder: 4,
	},
	{
		name: 'Chemistry',
		abbreviation: 'CH',
		description: 'Chemistry topics used in GATE XL streams.',
		sortOrder: 5,
	},
	{
		name: 'Biochemistry',
		abbreviation: 'BC',
		description: 'Biochemistry syllabus for GATE XL.',
		sortOrder: 6,
	},
	{
		name: 'Microbiology',
		abbreviation: 'MB',
		description: 'Microbiology syllabus for GATE XL.',
		sortOrder: 7,
	},
] as const

const syllabusBySubject = {
	GA: gaSyllabus,
	EM: emSyllabus,
	TH: thSyllabus,
	FT: ftSyllabus,
	CH: chSyllabus,
	BC: bcSyllabus,
	MB: mbSyllabus,
} as const

const packageDefinitions = [
	{
		name: 'XE Thermodynamics',
		slug: 'xe-thermodynamics',
		description:
			'Complete GATE XE package focused on thermodynamics with shared aptitude and food technology coverage.',
		streamInfo:
			'Includes General Aptitude, Engineering Mathematics, Thermodynamics, and Food Technology.',
		subjectAbbreviations: ['GA', 'EM', 'TH', 'FT'],
		price: 1999900,
		discountedPrice: 1499900,
		sortOrder: 3,
	},
	{
		name: 'XL Biochemistry',
		slug: 'xl-biochemistry',
		description:
			'Complete GATE XL package for the biochemistry stream with chemistry and food technology support.',
		streamInfo:
			'Includes General Aptitude, Chemistry, Biochemistry, and Food Technology.',
		subjectAbbreviations: ['GA', 'CH', 'BC', 'FT'],
		price: 1999900,
		discountedPrice: 1499900,
		sortOrder: 2,
	},
	{
		name: 'XL Microbiology',
		slug: 'xl-microbiology',
		description:
			'Complete GATE XL package for microbiology with chemistry and food technology support.',
		streamInfo:
			'Includes General Aptitude, Chemistry, Microbiology, and Food Technology.',
		subjectAbbreviations: ['GA', 'CH', 'MB', 'FT'],
		price: 1999900,
		discountedPrice: 1499900,
		sortOrder: 1,
	},
	{
		name: 'XL Food Technology',
		slug: 'xl-food-technology',
		description:
			'Focused GATE XL package for food technology with chemistry support.',
		streamInfo: 'Includes General Aptitude, Chemistry, and Food Technology.',
		subjectAbbreviations: ['GA', 'CH', 'FT'],
		price: 1699900,
		discountedPrice: 1275000,
		sortOrder: 4,
	},
	{
		name: 'XE Food Technology',
		slug: 'xe-food-technology',
		description:
			'Focused GATE XE package for food technology with engineering mathematics support.',
		streamInfo:
			'Includes General Aptitude, Engineering Mathematics, and Food Technology.',
		subjectAbbreviations: ['GA', 'EM', 'FT'],
		price: 1699900,
		discountedPrice: 1275000,
		sortOrder: 5,
	},
] as const

const batchTemplates = [
	{
		name: '26B1',
		startDate: new Date('2026-06-14T00:00:00.000Z'),
		endDate: new Date('2027-02-06T23:59:59.999Z'),
	},
	{
		name: '26B2',
		startDate: new Date('2026-08-02T00:00:00.000Z'),
		endDate: new Date('2027-02-06T23:59:59.999Z'),
	},
	{
		name: '26B3',
		startDate: new Date('2026-10-04T00:00:00.000Z'),
		endDate: new Date('2027-02-06T23:59:59.999Z'),
	},
] as const

const _actions = ['create', 'read', 'update', 'delete'] as const
const _entities = ['user', 'note'] as const
const _accesses = ['own', 'any'] as const

function getModuleName(moduleKey: string) {
	return `Module ${moduleKey}`
}

function getModuleSortOrder(moduleKey: string) {
	const parsed = Number(moduleKey)
	return Number.isNaN(parsed) ? 0 : parsed
}

function addDays(date: Date, days: number) {
	const next = new Date(date)
	next.setUTCDate(next.getUTCDate() + days)
	return next
}

type SyllabusEntry = {
	title?: string
	description?: string
	studyMaterialDemoUrl?: string[]
	videoDemoUrl?: string[]
}

function buildStudyMaterials(entry: SyllabusEntry, index: number) {
	const demoUrls = entry.studyMaterialDemoUrl?.filter(Boolean) ?? []

	if (demoUrls.length > 0) {
		return demoUrls.map((demoUrl, demoIndex) => ({
			title:
				demoUrls.length === 1
					? `${entry.title} Study Material`
					: `${entry.title} Study Material ${demoIndex + 1}`,
			description: entry.description || undefined,
			demoUrl,
			pages: 10 + index * 2,
			sortOrder: demoIndex + 1,
		}))
	}

	return [
		{
			title: `${entry.title} Study Material`,
			description: entry.description || undefined,
			pages: 10 + index * 2,
			sortOrder: 1,
		},
	]
}

function buildVideoLectures(entry: SyllabusEntry, index: number) {
	const demoUrls = entry.videoDemoUrl?.filter(Boolean) ?? []

	if (demoUrls.length > 0) {
		return demoUrls.map((demoUrl, demoIndex) => ({
			title:
				demoUrls.length === 1
					? `${entry.title} Video Lecture`
					: `${entry.title} Video Lecture ${demoIndex + 1}`,
			description: entry.description || undefined,
			demoUrl,
			duration: 900 + index * 300,
			sortOrder: demoIndex + 1,
		}))
	}

	return [
		{
			title: `${entry.title} Video Lecture`,
			description: entry.description || undefined,
			duration: 900 + index * 300,
			sortOrder: 1,
		},
	]
}

// async function seedPermissions() {
// 	const permissions: Array<Permission> = await Promise.all(
// 		actions.flatMap((action) =>
// 			entities.flatMap((entity) =>
// 				accesses.map((access) =>
// 					prisma.permission.create({
// 						data: {
// 							action,
// 							entity,
// 							access,
// 							description: `Allows ${action} on ${access} ${entity} records`,
// 						},
// 					}),
// 				),
// 			),
// 		),
// 	)

// 	const permissionsByKey = new Map<string, string>(
// 		permissions.map((permission) => [
// 			`${permission.action}:${permission.entity}:${permission.access}`,
// 			permission.id,
// 		]),
// 	)

// 	const userPermissionKeys = [
// 		'create:note:own',
// 		'read:note:own',
// 		'update:note:own',
// 		'delete:note:own',
// 		'read:user:own',
// 		'update:user:own',
// 	]

// 	await prisma.role.create({
// 		data: {
// 			name: 'admin',
// 			description: 'Administrator with access to every permission.',
// 			permissions: {
// 				connect: permissions.map((permission) => ({ id: permission.id })),
// 			},
// 		},
// 	})

// 	await prisma.role.create({
// 		data: {
// 			name: 'user',
// 			description: 'Standard user with self-service permissions.',
// 			permissions: {
// 				connect: userPermissionKeys.map((key) => {
// 					const permissionId = permissionsByKey.get(key)
// 					if (!permissionId) {
// 						throw new Error(`Missing permission ${key}`)
// 					}

// 					return { id: permissionId }
// 				}),
// 			},
// 		},
// 	})
// }

async function seedCatalogue() {
	const category = await prisma.courseCategory.create({
		data: {
			name: 'GATE',
			slug: 'gate',
			description:
				'GATE is a national level entrance exam for admission to M.Tech programs in India.',
			generalInfo:
				'Foodemy packages combine shared aptitude preparation with stream-specific content, staggered module releases, and long-tail access through the exam cycle.',
			whatYouWillGet: {
				create: features.map((feature, index) => ({
					title: feature.title,
					description: feature.description,
					sortOrder: index + 1,
				})),
			},
		},
	})

	await prisma.subject.createMany({
		data: subjectDefinitions.map((subject) => ({
			name: subject.name,
			abbreviation: subject.abbreviation,
			description: subject.description,
			sortOrder: subject.sortOrder,
		})),
	})

	const subjects: Array<Subject> = await prisma.subject.findMany()
	const subjectsByAbbreviation = new Map<string, Subject>(
		subjects.map((subject) => [subject.abbreviation, subject]),
	)

	const topicIdsBySubjectAndModule = new Map<string, string[]>()

	for (const subjectDefinition of subjectDefinitions) {
		const subject = subjectsByAbbreviation.get(subjectDefinition.abbreviation)
		if (!subject) {
			throw new Error(
				`Subject ${subjectDefinition.abbreviation} was not created successfully`,
			)
		}

		for (const [moduleKey, syllabusEntries] of Object.entries(
			syllabusBySubject[subjectDefinition.abbreviation],
		)) {
			const createdTopicIds: string[] = []

			for (const [index, rawEntry] of syllabusEntries.entries()) {
				const entry = rawEntry as SyllabusEntry
				if (!entry?.title) continue

				const topic = await prisma.topic.create({
					data: {
						name: entry.title,
						description: entry.description || undefined,
						sortOrder: index + 1,
						subjectId: subject.id,
						studyMaterials: {
							create: buildStudyMaterials(entry, index),
						},
						videoLectures: {
							create: buildVideoLectures(entry, index),
						},
					},
					select: { id: true },
				})

				createdTopicIds.push(topic.id)
			}

			topicIdsBySubjectAndModule.set(
				`${subjectDefinition.abbreviation}:${moduleKey}`,
				createdTopicIds,
			)
		}
	}

	for (const [
		packageIndex,
		packageDefinition,
	] of packageDefinitions.entries()) {
		const relatedSubjects = packageDefinition.subjectAbbreviations.map(
			(abbreviation) => {
				const subject = subjectsByAbbreviation.get(abbreviation)
				if (!subject) {
					throw new Error(
						`Subject ${abbreviation} missing for ${packageDefinition.slug}`,
					)
				}
				return subject
			},
		)

		const coursePackage = await prisma.coursePackage.create({
			data: {
				name: packageDefinition.name,
				slug: packageDefinition.slug,
				description: packageDefinition.description,
				streamInfo: packageDefinition.streamInfo,
				categoryId: category.id,
				sortOrder: packageDefinition.sortOrder,
				subjects: {
					connect: relatedSubjects.map((subject) => ({ id: subject.id })),
				},
			},
		})

		const moduleKeys = Array.from(
			new Set(
				packageDefinition.subjectAbbreviations.flatMap((abbreviation) =>
					Object.keys(syllabusBySubject[abbreviation]),
				),
			),
		).sort(
			(left, right) => getModuleSortOrder(left) - getModuleSortOrder(right),
		)

		const modules = []
		for (const moduleKey of moduleKeys) {
			const module = await prisma.module.create({
				data: {
					name: getModuleName(moduleKey),
					description: `Release bundle for ${packageDefinition.name} ${getModuleName(moduleKey)}.`,
					sortOrder: getModuleSortOrder(moduleKey),
					packageId: coursePackage.id,
					topics: {
						connect: packageDefinition.subjectAbbreviations.flatMap(
							(abbreviation) =>
								(
									topicIdsBySubjectAndModule.get(
										`${abbreviation}:${moduleKey}`,
									) ?? []
								).map((id) => ({ id })),
						),
					},
				},
			})

			modules.push(module)
		}

		const yearlyProduct = await prisma.yearlyProduct.create({
			data: {
				year: 2026,
				displayName: `${packageDefinition.name} | GATE 2026`,
				price: packageDefinition.price,
				discountedPrice: packageDefinition.discountedPrice,
				accessEndsAt: new Date('2027-02-06T23:59:59.999Z'),
				packageId: coursePackage.id,
			},
		})

		for (const batchTemplate of batchTemplates) {
			const batch = await prisma.batch.create({
				data: {
					name: batchTemplate.name,
					startDate: batchTemplate.startDate,
					endDate: batchTemplate.endDate,
					yearlyProductId: yearlyProduct.id,
				},
			})

			await Promise.all(
				modules.map((module) =>
					prisma.batchModule.create({
						data: {
							batchId: batch.id,
							moduleId: module.id,
							releaseDate: addDays(
								batchTemplate.startDate,
								Math.max(module.sortOrder - 1, 0) * 7,
							),
						},
					}),
				),
			)
		}
	}
}

async function seed() {
	console.log('🌱 Seeding...')
	console.time(`🌱 Database has been seeded`)

	// console.time(`🔐 Created permissions and roles`)
	// await seedPermissions()
	// console.timeEnd(`🔐 Created permissions and roles`)

	console.time(`📚 Created catalogue and content`)
	await seedCatalogue()
	console.timeEnd(`📚 Created catalogue and content`)

	console.timeEnd(`🌱 Database has been seeded`)
}

seed()
	.catch((e) => {
		console.error(e)
		process.exit(1)
	})
	.finally(async () => {
		await prisma.$disconnect()
	})

// we're ok to import from the test directory in this file
/*
eslint
	no-restricted-imports: "off",
*/
