import {
	Avatar,
	AvatarFallback,
	AvatarGroup,
	AvatarGroupCount,
	AvatarImage,
} from '#app/components/ui/avatar.tsx'

export function StudentsCount() {
	return (
		<AvatarGroup className="">
			<Avatar>
				<AvatarImage src="img/students/1.jpg" alt="@shadcn" />
				<AvatarFallback>CN</AvatarFallback>
			</Avatar>
			<Avatar>
				<AvatarImage src="img/students/2.jpg" alt="@maxleiter" />
				<AvatarFallback>LR</AvatarFallback>
			</Avatar>
			<Avatar>
				<AvatarImage src="img/students/3.jpg" alt="@evilrabbit" />
				<AvatarFallback>ER</AvatarFallback>
			</Avatar>
			<Avatar>
				<AvatarImage src="img/students/4.jpg" alt="@evilrabbit" />
				<AvatarFallback>ER</AvatarFallback>
			</Avatar>
			<AvatarGroupCount className="text-[10px]">+300</AvatarGroupCount>
		</AvatarGroup>
	)
}
