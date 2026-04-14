import { type ReactNode } from 'react'
import {
	Dialog,
	DialogContent,
	DialogDescription,
	DialogHeader,
	DialogTitle,
	DialogTrigger,
} from '#app/components/ui/dialog.tsx'
import { Icon } from '#app/components/ui/icon.tsx'
import {
	Tooltip,
	TooltipContent,
	TooltipProvider,
	TooltipTrigger,
} from '#app/components/ui/tooltip.tsx'

export default function TeammateDetailsDialog({
	name,
	bio,
	edu,
	linkedIn,
	children,
}: {
	name: string
	bio: string
	edu: string
	linkedIn?: string
	children: ReactNode
}) {
	return (
		<Dialog>
			<DialogTrigger asChild>{children}</DialogTrigger>
			<DialogContent className="w-[90%]">
				<DialogHeader>
					<DialogTitle className="font-display text-center">{name}</DialogTitle>
					<DialogDescription className="text-center">{edu}</DialogDescription>
				</DialogHeader>
				<p className="text-center text-sm leading-relaxed">{bio}</p>
				{linkedIn ? (
					<a
						href={linkedIn}
						target="_blank"
						rel="noopener noreferrer"
						className="bg-info text-info-foreground hover:bg-info-foreground/20 mx-auto mt-2 flex w-[80%] justify-center gap-2 rounded-md p-2 text-sm transition duration-300"
					>
						<Icon
							name="linkedin-fill"
							className="text-info-foreground size-5 font-bold"
						/>
						View on LinkedIn
					</a>
				) : (
					<span className="text-muted hover:text-muted-foreground mt-auto flex w-full cursor-pointer items-center justify-center gap-2 rounded-md border p-2 transition duration-300">
						🥷🏼 &nbsp; Networking in stealth mode
					</span>
				)}
			</DialogContent>
		</Dialog>
	)
}
