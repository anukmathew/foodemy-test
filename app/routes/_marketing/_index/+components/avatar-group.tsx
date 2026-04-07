import {
	Avatar,
	AvatarFallback,
	AvatarGroup,
	AvatarGroupCount,
	AvatarImage,
} from '#app/components/ui/avatar.tsx'

export function StudentsCount() {
	return (
		<AvatarGroup className="grayscale">
			<Avatar>
				<AvatarImage src="https://github.com/shadcn.png" alt="@shadcn" />
				<AvatarFallback>CN</AvatarFallback>
			</Avatar>
			<Avatar>
				<AvatarImage src="https://github.com/maxleiter.png" alt="@maxleiter" />
				<AvatarFallback>LR</AvatarFallback>
			</Avatar>
			<Avatar>
				<AvatarImage
					src="https://github.com/evilrabbit.png"
					alt="@evilrabbit"
				/>
				<AvatarFallback>ER</AvatarFallback>
			</Avatar>
			<AvatarGroupCount className="text-[10px]">+300</AvatarGroupCount>
		</AvatarGroup>
	)
}
