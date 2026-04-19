import { Icon } from '#app/components/ui/icon.tsx'
import {
	Tooltip,
	TooltipContent,
	TooltipProvider,
	TooltipTrigger,
} from '#app/components/ui/tooltip.tsx'
import { Img } from 'openimg/react'
import TeammateDetailsDialog from './teammate-details-dialog'

export default function TeamMateCard({
	name,
	bio,
	edu,
	image,
	linkedIn,
}: {
	name: string
	bio: string
	edu: string
	image: string
	linkedIn?: string
}) {
	return (
		<div className="border-muted group from-muted to-muted-foreground relative flex max-w-7xl flex-col overflow-hidden rounded-2xl border bg-radial-[at_50%_40%] from-20% shadow-md transition duration-300">
			<div className="pointer-events-none absolute z-30 hidden h-full w-full flex-col justify-between overflow-scroll bg-white p-6 text-left opacity-0 transition-all duration-500 group-hover:pointer-events-auto group-hover:opacity-100 md:flex">
				<p className="text-base leading-normal">{bio}</p>
				{linkedIn ? (
					<a
						href={linkedIn}
						target="_blank"
						rel="noopener noreferrer"
						className="bg-info text-info-foreground hover:bg-info/80 mt-auto flex w-full cursor-pointer items-baseline justify-center gap-2 rounded-md p-2 no-underline transition duration-300"
					>
						<Icon
							name="linkedin-fill"
							className="text-info-foreground size-5 font-bold"
						/>
						View on LinkedIn
					</a>
				) : (
					<TooltipProvider>
						<Tooltip delayDuration={0}>
							<TooltipTrigger className="text-muted hover:text-muted-foreground mt-auto flex w-full cursor-pointer items-center justify-center gap-2 rounded-md border p-2 text-sm transition duration-300">
								🥷🏼 &nbsp; Networking in stealth mode
							</TooltipTrigger>
							<TooltipContent>Nice try!</TooltipContent>
						</Tooltip>
					</TooltipProvider>
				)}
			</div>
			<div className="z-10 mt-6 justify-center overflow-hidden">
				<TeammateDetailsDialog
					name={name}
					bio={bio}
					edu={edu}
					linkedIn={linkedIn}
				>
					<button
						type="button"
						className="block w-full cursor-pointer md:pointer-events-none"
					>
						<Img
							src={image}
							width={800}
							height={800}
							fit="cover"
							alt={name}
							className="h-full w-full object-cover grayscale transition duration-300"
						/>
					</button>
				</TeammateDetailsDialog>
			</div>
			<div className="z-20 flex flex-col justify-center bg-white p-2 text-center md:p-4">
				<h3 className="text-primary-foreground font-display truncate text-sm font-semibold md:text-lg">
					{name}
				</h3>
				<p className="text-muted-foreground text-xs md:text-sm">{edu}</p>
			</div>
		</div>
	)
}
