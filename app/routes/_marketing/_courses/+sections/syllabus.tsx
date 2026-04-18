import _ from 'lodash'
import { motion } from 'motion/react'
import { useState } from 'react'
import {
	Accordion,
	AccordionContent,
	AccordionItem,
	AccordionTrigger,
} from '#app/components/ui/accordion.tsx'
import { AspectRatio } from '#app/components/ui/aspect-ratio.tsx'
import { Badge } from '#app/components/ui/badge.tsx'
import {
	Dialog,
	DialogContent,
	DialogTitle,
	DialogTrigger,
} from '#app/components/ui/dialog.tsx'
import { Icon } from '#app/components/ui/icon.tsx'
import { formatHours } from '#app/utils/custom-utils/helpers.ts'
import { type loader } from '../courses_.$course.tsx'

export function Syllabus({
	data,
}: {
	data: Awaited<ReturnType<typeof loader>>
}) {
	// NOTE: upComingOrCurrentBatch was unused and removed to satisfy lint rules

	const subjectSortOrder = _.sortBy(
		data.course?.subjects || [],
		(subject) => subject.sortOrder,
	).map((subject) => subject.name)

	const modules = _.chain(data.course?.modules || [])
		.map((module) => {
			const groupedTopics = _.chain(module.topics)
				.groupBy((topic) => topic.subject?.name ?? 'Other')
				.map((topics, subjectName) => ({
					subjectName,
					subjectAbbreviation: topics[0]?.subject?.abbreviation ?? null,
					topics,
				}))
				.sortBy((item) => _.indexOf(subjectSortOrder, item.subjectName))
				.value()

			return {
				module: module.name,
				items: groupedTopics,
			}
		})
		.value()

	const totalModules = Object.keys(modules).length

	const totalTopics = _.chain(modules)
		.flatMap((module) => _.flatMap(module.items, (mod) => mod.topics))
		.size()
		.value()

	const totalDuration = _.chain(modules)
		.flatMap((module) =>
			_.flatMap(module.items, (mod) =>
				_.flatMap(mod.topics, (topic) => topic.videoLectures),
			),
		)
		.sumBy((video) => video.duration)
		.value()

	const INITIAL_VISIBLE = 5
	const [showAll, setShowAll] = useState(false)
	const visibleModules = showAll ? modules : modules.slice(0, INITIAL_VISIBLE)

	return (
		<section className="bg-muted-foreground/10 py-20">
			<div className="container mx-auto px-4">
				<div className="mx-auto max-w-4xl">
					<div className="mb-12 text-center">
						<h2 className="mb-4 text-3xl font-bold md:text-4xl">
							Course Curriculum
						</h2>
						<p className="mb-6">
							{totalModules} comprehensive modules covering every topics from
							the {data.course?.courseCategory.name} {data.course?.name}{' '}
							syllabus
						</p>

						<motion.div className="mb-8 flex flex-wrap justify-center gap-4">
							<Badge
								variant="outline"
								className="border-muted-foreground/50 text-muted-foreground text-sm"
							>
								<Icon name="book-3-line" className="mr-2 h-4 w-4" />
								{totalTopics} topics
							</Badge>
							<Badge
								variant="outline"
								className="border-muted-foreground/50 text-muted-foreground text-sm"
							>
								{/* <AnimatedClock className="mr-2 h-4 w-4" /> */}
								<Icon name="clock" className="mr-2 h-4 w-4" />
								{`${formatHours(totalDuration)} of video content`}
							</Badge>
						</motion.div>
					</div>

					<Accordion
						type="single"
						collapsible
						className="space-y-4"
						defaultValue="item-0"
					>
						{visibleModules.map((module, index) => {
							const topics = _.chain(module.items)
								.flatMap((topic) => ({
									subject: topic.subjectName,
									subjectAbbreviation: topic.subjectAbbreviation,
									topics: _.flatMap(topic.topics),
								}))

								.value()

							const duration = _.chain(topics)
								.flatMap((topic) =>
									_.flatMap(topic.topics, (top) => top.videoLectures),
								)
								.sumBy((video) => video.duration)
								.value()

							const numberOfTopics = _.flatMap(topics, (t) => t.topics).length

							return (
								<AccordionItem
									key={index}
									value={`item-${index}`}
									className="border-muted rounded-2xl border bg-white px-4 transition-colors last:border"
								>
									<AccordionTrigger className="py-4 hover:no-underline">
										<div className="mr-4 flex w-full items-center justify-between">
											<div className="flex items-center gap-4">
												<div className="bg-primary-soft text-primary-soft-foreground flex h-10 w-10 items-center justify-center rounded-lg p-2 text-sm font-medium">
													{index + 1}
												</div>
												<div className="text-left">
													<h2 className="text-foreground font-display text-lg font-semibold">
														{module.module}
													</h2>
												</div>
											</div>
											<div className="text-muted-foreground flex items-center gap-4 font-sans text-xs font-normal">
												<span>{numberOfTopics} topics</span>
												<span>{formatHours(duration)}</span>
											</div>
										</div>
									</AccordionTrigger>
									<AccordionContent className="pt-2 pb-4">
										<ul className="text-foreground ml-6 flex list-disc flex-col gap-2 text-base lg:ml-18">
											{module.items.map((mod) =>
												mod.topics.map((item, idx) => (
													<li key={idx}>
														<div className="flex flex-col">
															<div className="flex justify-between">
																<div className="flex items-baseline gap-2 text-sm">
																	{item.name}{' '}
																	<span className="hidden text-xs sm:inline-flex">
																		({mod.subjectName})
																	</span>
																	<span className="text-xs sm:hidden">
																		{mod.subjectAbbreviation
																			? ` (${mod.subjectAbbreviation})`
																			: ''}
																	</span>
																</div>
																<div className="flex gap-4">
																	{item.videoLectures.some(
																		(video) => video.demoUrl,
																	) && (
																		<div className="mt-1 flex gap-2">
																			{item.videoLectures
																				.filter((video) => video.demoUrl)
																				.map((video) => (
																					<Dialog key={video.id}>
																						<DialogTrigger asChild>
																							<div className="text-secondary flex cursor-pointer items-center gap-1">
																								<Icon
																									name="play-circle-fill"
																									size="sm"
																								/>
																								<span className="hidden border-b border-dashed text-xs sm:inline">
																									Preview
																								</span>
																							</div>
																						</DialogTrigger>
																						<DialogContent className="max-h-[80vh] max-w-[80vw] overflow-hidden p-0">
																							<DialogTitle className="sr-only">
																								Demo - {video.title}
																							</DialogTitle>

																							<div className="flex h-full w-full items-center justify-center">
																								<AspectRatio
																									ratio={16 / 9}
																									className="h-auto w-[80vw] max-w-[calc(80vh*16/9)]"
																								>
																									<iframe
																										src={video.demoUrl!}
																										title={video.title}
																										allowFullScreen
																										className="h-full w-full"
																									/>
																								</AspectRatio>
																							</div>
																						</DialogContent>
																					</Dialog>
																				))}
																		</div>
																	)}
																	{item.studyMaterials.some(
																		(studyMaterial) => studyMaterial.demoUrl,
																	) && (
																		<div className="mt-1 flex gap-2">
																			{item.studyMaterials
																				.filter(
																					(studyMaterial) =>
																						studyMaterial.demoUrl,
																				)
																				.map((studyMaterial) => (
																					<Dialog key={studyMaterial.id}>
																						<DialogTrigger asChild>
																							<div className="text-secondary flex cursor-pointer items-center gap-1">
																								<Icon
																									name="book-3-fill"
																									size="sm"
																								/>
																								<span className="hidden border-b border-dashed text-xs sm:inline">
																									Preview
																								</span>
																							</div>
																						</DialogTrigger>
																						<DialogContent className="max-h-[80vh] max-w-[80vw] overflow-hidden p-0">
																							<DialogTitle className="sr-only">
																								Demo - {studyMaterial.title}
																							</DialogTitle>

																							<div className="flex h-full w-full items-center justify-center">
																								<AspectRatio className="h-auto w-[80vw]">
																									<iframe
																										src={studyMaterial.demoUrl!}
																										title={studyMaterial.title}
																										allowFullScreen
																										className="h-full w-full"
																									/>
																								</AspectRatio>
																							</div>
																						</DialogContent>
																					</Dialog>
																				))}
																		</div>
																	)}
																</div>
															</div>
															<div>
																{item.description
																	?.split('\n')
																	.map((line, i) => (
																		<p
																			key={i}
																			className="text-secondary text-sm"
																		>
																			{line}
																		</p>
																	))}
															</div>
														</div>
													</li>
												)),
											)}
										</ul>
									</AccordionContent>
								</AccordionItem>
							)
						})}
					</Accordion>

					{modules.length > INITIAL_VISIBLE && (
						<div className="relative mt-2">
							<div className="flex justify-center pt-4">
								<button
									onClick={() => setShowAll((prev) => !prev)}
									className="border-muted-foreground/50 text-secondary hover:bg-primary hover:text-primary-foreground flex items-center gap-2 rounded-full border px-6 py-2 text-sm font-medium transition-colors"
								>
									{showAll ? (
										<>
											<Icon name="arrow-up-s-line" className="h-4 w-4" />
											Show less
										</>
									) : (
										<>
											<Icon name="arrow-down-s-line" className="h-4 w-4" />
											Show all {modules.length} modules
										</>
									)}
								</button>
							</div>
						</div>
					)}
				</div>
			</div>
		</section>
	)
}
