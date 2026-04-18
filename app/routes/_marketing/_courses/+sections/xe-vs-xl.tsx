import { Icon } from '#app/components/ui/icon.tsx'
import {
	Table,
	TableBody,
	TableCell,
	TableHead,
	TableHeader,
	TableRow,
} from '#app/components/ui/table.tsx'
import { cn } from '#app/utils/misc.tsx'

type XEvsXLProp = {
	condition: string
	xe: boolean
	xl: boolean
}

type XEvsXLProps = {
	data?: XEvsXLProp[]
}

export const statements: XEvsXLProps = {
	data: [
		{
			condition: 'If your undergraduate background is B.Tech / Engineering',
			xe: true,
			xl: false,
		},
		{
			condition: 'If your undergraduate background is B.Sc. / Life Sciences',
			xe: false,
			xl: true,
		},
		{
			condition:
				'If you are more comfortable with Engineering Mathematics as a compulsory section',
			xe: true,
			xl: false,
		},
		{
			condition:
				'If you are more comfortable with Chemistry as a compulsory section',
			xe: false,
			xl: true,
		},
		{
			condition: 'If your target institutes typically accept only XE',
			xe: true,
			xl: false,
		},
		{
			condition: 'If your target institutes typically accept only XL',
			xe: false,
			xl: true,
		},
		{
			condition: 'If your target institutes accept both XE and XL',
			xe: true,
			xl: true,
		},
		{
			condition:
				'If you want your preparation aligned with an engineering-oriented exam structure',
			xe: true,
			xl: false,
		},
		{
			condition:
				'If you want your preparation aligned with a life-sciences-oriented exam structure',
			xe: false,
			xl: true,
		},
		{
			condition:
				'If you are choosing based on Food Technology syllabus content alone',
			xe: true,
			xl: true,
		},
		{
			condition:
				'If you are selecting based on which paper format (Maths vs Chemistry) suits you better',
			xe: true,
			xl: true,
		},
	],
}

export default function XEvsXL({ data }: XEvsXLProps = statements) {
	const tableData = data ?? statements.data ?? []
	return (
		<div className="w-full">
			<h4 className="text-primary-foreground mb-6 text-center text-2xl font-bold">
				Your guide to choosing XE or XL
			</h4>
			<div className="mx-auto max-w-4xl">
				<Table>
					<TableHeader className="bg-primary-soft">
						<TableRow>
							<TableHead className="text-primary-soft-foreground font-bold">
								Scenario
							</TableHead>
							<TableHead className="text-primary-soft-foreground font-bold">
								XE
							</TableHead>
							<TableHead className="text-primary-soft-foreground font-bold">
								XL
							</TableHead>
						</TableRow>
					</TableHeader>
					<TableBody>
						{tableData.map((item, index) => (
							<TableRow key={index} className="border-muted-foreground/30">
								<TableCell className="text-secondary">
									{item.condition}
								</TableCell>
								<TableCell>
									<Icon
										name={item.xe ? 'check-fill' : 'close-fill'}
										className={cn(
											'size-5 rounded-full border p-[2px]',
											item.xe
												? 'bg-accent/10 text-accent border-accent/50'
												: 'bg-destructive/20 text-destructive border-destructive/50',
										)}
									/>
								</TableCell>
								<TableCell>
									<Icon
										name={item.xl ? 'check-fill' : 'close-fill'}
										className={cn(
											'size-5 rounded-full border p-[2px]',
											item.xl
												? 'bg-accent/10 text-accent border-accent/50'
												: 'bg-destructive/20 text-destructive border-destructive/50',
										)}
									/>
								</TableCell>
							</TableRow>
						))}
					</TableBody>
				</Table>
			</div>
		</div>
	)
}
