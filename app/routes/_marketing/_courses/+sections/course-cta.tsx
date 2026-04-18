import { getFormProps, getInputProps, useForm } from '@conform-to/react'
import { parseWithZod } from '@conform-to/zod'
import { Form, useActionData, useNavigation } from 'react-router'
import { HoneypotInputs } from 'remix-utils/honeypot/react'
import { Button } from '#app/components/ui/button.tsx'
import { Card, CardContent } from '#app/components/ui/card.tsx'
import { FieldError, FieldGroup } from '#app/components/ui/field.tsx'
import { Icon } from '#app/components/ui/icon.tsx'
import { Input } from '#app/components/ui/input.tsx'
import { formatINR } from '#app/utils/custom-utils/helpers.ts'
import { cn } from '#app/utils/misc.tsx'
import {
	NotificationSchema,
	type action,
	type loader,
} from '../courses_.$course.tsx'

export function CourseFooter({
	data,
}: {
	data: Awaited<ReturnType<typeof loader>>
}) {
	const actionData = useActionData<typeof action>()
	const isSuccess = actionData?.status === 'success'
	const submittedEmail =
		actionData && 'email' in actionData ? actionData.email : undefined

	const [form, fields] = useForm({
		id: 'cta-form',
		lastResult: actionData,
		onValidate({ formData }) {
			return parseWithZod(formData, {
				schema: NotificationSchema,
			})
		},
	})
	const formProps = getFormProps(form)

	const navigation = useNavigation()
	const isSubmitting = navigation.state === 'submitting'

	return (
		<section className="relative py-12 md:py-36" id="cta">
			<div
				className="absolute inset-0 -z-2"
				style={{
					background:
						'radial-gradient(125% 125% at 50% 10%, #fff 70%, var(--color-primary) 100%)',
				}}
			/>
			<div className="container mx-auto px-4">
				<div className="mx-auto max-w-4xl text-center">
					<h2 className="mb-4 text-3xl font-bold text-balance md:text-4xl">
						Ready to start your {data.course?.courseCategory?.name} preparation?
					</h2>
					<p className="text-muted-foreground mb-12 text-pretty">
						Join hundreds of students who have successfully cracked{' '}
						{data.course?.courseCategory?.name} with Foodemy.
					</p>

					<Card className="bg-primary/20 border-primary mb-12 rounded-2xl shadow-lg">
						<CardContent className="p-8">
							<div className="grid items-center gap-8 md:grid-cols-2">
								<div>
									<h3 className="mb-6 text-2xl font-bold">What's included:</h3>
									<div className="space-y-3 text-left">
										{data.course?.courseCategory?.whatYouWillGet.map((item) => (
											<div key={item.id} className="flex items-center gap-3">
												<div className="bg-primary flex h-5 w-5 items-center justify-center rounded-full">
													<Icon
														name="check"
														className="text-primary-foreground h-3 w-3"
													/>
												</div>
												<span>{item.title}</span>
											</div>
										))}
									</div>
								</div>

								<div className="text-center">
									<div className="mb-6">
										<div className="text-foodemy mb-2 text-5xl font-bold">
											<span className="mr-2 inline-flex -translate-y-[0.01rem] align-super text-3xl">
												₹
											</span>
											{formatINR(data.course?.discountedPrice ?? 0)}
										</div>
										<div className="text-muted-foreground text-2xl line-through">
											<span className="mr-1 inline-flex -translate-y-[0.01rem] align-super text-xs">
												₹
											</span>
											{formatINR(data.course?.price ?? 0)}
										</div>
									</div>

									{/* <Button
										className="relative mb-4 w-full overflow-hidden py-6 text-lg font-bold"
										disabled
									>
										<span className="z-40 flex items-center">
											Registration opens soon
											<motion.div
												initial={{ x: 0, scaleY: '100%' }}
												animate={{ x: 10, scaleY: '85%' }}
												transition={{
													repeat: Infinity,
													duration: 0.75,
													damping: 10,
													ease: 'easeInOut',
													repeatType: 'mirror',
												}}
											>
												<Icon name="arrow-right" className="ml-2 h-5 w-5" />
											</motion.div>
										</span>
										<motion.div
											initial={{ x: '-50%' }}
											whileInView={{ x: '100%' }}
											transition={{
												duration: 3,
												repeat: Infinity,
												ease: 'easeInOut',
												// repeatDelay: 1,
											}}
											className="absolute inline-block h-full w-full"
										>
											<div className="h-[200%] w-1/3 -translate-y-[25%] -rotate-12 bg-linear-to-r from-transparent via-amber-200 to-transparent" />
										</motion.div>
									</Button> */}

									<p className="text-muted-foreground text-sm">
										Registration opens on 1st June.
									</p>

									<Form
										{...formProps}
										action="."
										method="post"
										className="mt-6 flex items-start justify-between gap-2"
									>
										<HoneypotInputs />
										<FieldGroup className="flex flex-[65%] flex-col items-start gap-1">
											<Input
												placeholder={submittedEmail ?? 'Enter your email'}
												disabled={isSuccess}
												{...getInputProps(fields.email, { type: 'text' })}
												autoComplete="email"
												className="placeholder:text-sm"
											/>
											{fields.email.errors && (
												<FieldError
													errors={fields.email.errors?.map((e) => ({
														message: e,
													}))}
													className="text-xs"
												/>
											)}
										</FieldGroup>
										<input
											{...getInputProps(fields.course, { type: 'hidden' })}
											value={data.course?.name}
										/>
										<Button
											type="submit"
											className="w-full flex-[35%] px-0"
											disabled={isSuccess}
										>
											<Icon
												name={
													isSuccess
														? 'check'
														: isSubmitting
															? 'loader-2-line'
															: 'notification-2-line'
												}
												className={cn(
													'mr-2 h-4 w-4',
													isSubmitting && 'animate-spin',
												)}
											/>
											{isSuccess ? 'All set!' : 'Notify me'}
										</Button>
									</Form>
									<span className="text-muted-foreground mt-4 block text-xs leading-snug">
										{isSuccess ? (
											<>
												Thank you for your interest! <br /> We will notify you
												when registration opens.
											</>
										) : (
											<>
												We will notify you when registration opens. <br /> No
												spam, we promise!
											</>
										)}
									</span>
								</div>
							</div>
						</CardContent>
					</Card>
				</div>
			</div>
		</section>
	)
}
