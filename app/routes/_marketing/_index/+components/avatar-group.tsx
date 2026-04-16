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
				<AvatarImage
					src="/resources/images?src=/img/students/1.jpg&format=webp&w=200&h=200"
					alt="@shadcn"
				/>
				<AvatarFallback>CN</AvatarFallback>
			</Avatar>
			<Avatar>
				<AvatarImage
					src="/resources/images?src=/img/students/2.jpg&format=webp&w=200&h=200"
					alt="@maxleiter"
				/>
				<AvatarFallback>LR</AvatarFallback>
			</Avatar>
			<Avatar>
				<AvatarImage
					src="/resources/images?src=/img/students/3.jpg&format=webp&w=200&h=200"
					alt="@evilrabbit"
				/>
				<AvatarFallback>ER</AvatarFallback>
			</Avatar>
			<Avatar>
				<AvatarImage
					src="/resources/images?src=/img/students/4.jpg&format=webp&w=200&h=200"
					alt="@evilrabbit"
				/>
				<AvatarFallback>ER</AvatarFallback>
			</Avatar>
			<AvatarGroupCount className="text-[10px]">+300</AvatarGroupCount>
		</AvatarGroup>
	)
}
