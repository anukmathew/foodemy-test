import { HoverEffect } from '#app/components/aceternity/card-hover-effect.tsx'
import { type loader } from '../courses._courses'

export default function WhatYouWillGet({
	data,
}: {
	data: Awaited<ReturnType<typeof loader>>
}) {
	const whatYouWillGet = data.courseCategory?.whatYouWillGet

	return (
		<>
			{whatYouWillGet && (
				<section className="bg-primary/10 w-full py-12 sm:py-36">
					<div className="container">
						<h2>
							What <span className="highlight">you will get</span>
						</h2>
						<HoverEffect
							items={whatYouWillGet.map((item) => ({
								key: item.id,
								title: item.title,
								description: item.description,
								link: '',
							}))}
							hoverClassName="bg-primary"
							containerClassName="bg-white border-primary/50 shadow-xs"
							titleClassName="text-secondary text-xl font-sans "
							descriptionClassName="text-secondary"
						/>
					</div>
				</section>
			)}
		</>
	)
}
