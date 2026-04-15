import {
	getFormProps,
	getInputProps,
	getTextareaProps,
	useForm,
} from '@conform-to/react'
import { parseWithZod } from '@conform-to/zod'
import { Form, Link, useActionData } from 'react-router'
import { HoneypotInputs } from 'remix-utils/honeypot/react'
import { SpamError } from 'remix-utils/honeypot/server'
import { z } from 'zod'

import { Button } from '#app/components/ui/button.tsx'
import { Checkbox } from '#app/components/ui/checkbox.tsx'
import {
	FieldSet,
	FieldGroup,
	FieldLabel,
	Field,
	FieldError,
} from '#app/components/ui/field.tsx'
import { Icon, type IconName } from '#app/components/ui/icon.tsx'
import { Input } from '#app/components/ui/input.tsx'
import { Textarea } from '#app/components/ui/textarea.tsx'
import { honeypot } from '#app/utils/honeypot.server.ts'
import { type Route } from './+types/_contact.ts'
import { useState } from 'react'

export async function action({ request }: Route.ActionArgs) {
	const formData = await request.formData()
	try {
		await honeypot.check(formData)
	} catch (error) {
		if (error instanceof SpamError) {
			throw new Response('Invalid form submission', { status: 400 })
		}
		throw error
	}
	const submission = parseWithZod(formData, { schema: ContactFormSchema })
	if (submission.status !== 'success') {
		return submission.reply()
	}
	const webhookResponse = await fetch(
		'https://discord.com/api/webhooks/1493678857285271744/v1nUzCrh_7BuGXL8EMYDbIAqNn2ILH8FZsIXRQDei4ZMhazS5t5uvFB1ZXkMFN1CpKHv',
		{
			method: 'POST',
			body: JSON.stringify({
				content: 'New contact form submission',
				embeds: [
					{
						title: 'Contact Form Submission',
						fields: [
							{
								name: 'Name',
								value: `${submission.value.firstName} ${submission.value.lastName}`,
							},
							{
								name: 'Phone Number',
								value: submission.value.phoneNumber,
							},
							{
								name: 'Email',
								value: submission.value.email,
							},
							{
								name: 'Message',
								value: submission.value.message,
							},
						],
						color: 0xffdb00,
					},
				],
			}),
			headers: {
				'Content-Type': 'application/json',
			},
		},
	)

	if (!webhookResponse.ok) {
		return submission.reply({
			formErrors: ['Something went wrong. Please try again in a moment.'],
		})
	}

	return { status: 'success' as const }
}

export default function Contact() {
	const actionData = useActionData<typeof action>()
	const isSuccess = actionData?.status === 'success'

	const [form, fields] = useForm({
		id: 'contact-form',
		lastResult: actionData,
		onValidate({ formData }) {
			return parseWithZod(formData, { schema: ContactFormSchema })
		},
	})

	return (
		<section className="w-full">
			<div className="container py-48">
				<div className="grid grid-cols-1 grid-rows-3 gap-6 lg:grid-cols-2">
					<div className="bg-card border-muted row-span-3 flex flex-col rounded-2xl border p-8 py-12 shadow-sm inset-shadow-2xs">
						<div className="flex flex-col gap-4">
							<span className="text-destructive font-semibold">
								Get in touch
							</span>
							<h3 className="text-primary-foreground font-display text-3xl">
								Let's Chat, Reach Out to Us
							</h3>
							<p>
								Have questions or feedback? We're here to help. Send us a
								message, and we'll respond within 24 hours.
							</p>
						</div>
						<hr className="text-muted my-12" />
						{isSuccess ? (
							<div className="mt-8 flex flex-1 flex-col items-center justify-center gap-4">
								<div className="bg-success/15 text-success flex size-14 items-center justify-center rounded-full">
									<Icon name="check" className="size-7" />
								</div>
								<h4 className="text-primary-foreground font-display text-2xl">
									Message sent successfully
								</h4>
								<p className="text-muted-foreground max-w-prose text-center">
									Thanks for contacting us. We&apos;ve received your message and
									will get back to you within 24 hours.
								</p>
								<Link
									to={'/contact'}
									className="text-primary-foreground border-primary-foreground hover:bg-primary mt-6 flex items-center rounded-md border px-4 py-2 text-sm font-medium transition-colors"
								>
									<Icon name="arrow-left" className="mr-2" />
									Send another message
								</Link>
							</div>
						) : (
							<Form
								method="POST"
								className="text-primary-foreground mt-8 flex flex-1 flex-col gap-2"
								{...getFormProps(form)}
							>
								<HoneypotInputs />
								<FieldSet className="flex w-full">
									<div className="grid w-full grid-cols-2 gap-4">
										<FieldGroup className="gap-2">
											<Field>
												<FieldLabel htmlFor={fields.firstName.id}>
													First name
												</FieldLabel>
												<Input
													{...getInputProps(fields.firstName, { type: 'text' })}
													autoComplete="off"
													placeholder="John"
												/>
											</Field>
											<div className="min-h-[32px]">
												{fields.firstName.errors && (
													<FieldError
														errors={fields.firstName.errors?.map((e) => ({
															message: e,
														}))}
													/>
												)}
											</div>
										</FieldGroup>
										<FieldGroup className="gap-2">
											<Field>
												<FieldLabel htmlFor={fields.lastName.id}>
													Last name
												</FieldLabel>
												<Input
													{...getInputProps(fields.lastName, { type: 'text' })}
													autoComplete="off"
													placeholder="Doe"
												/>
											</Field>
											<div className="min-h-[32px]">
												{fields.lastName.errors && (
													<FieldError
														errors={fields.lastName.errors?.map((e) => ({
															message: e,
														}))}
													/>
												)}
											</div>
										</FieldGroup>
									</div>
								</FieldSet>
								<FieldSet>
									<FieldGroup className="gap-2">
										<Field>
											<FieldLabel htmlFor={fields.phoneNumber.id}>
												Phone Number
											</FieldLabel>
											<Input
												{...getInputProps(fields.phoneNumber, { type: 'tel' })}
												autoComplete="off"
												placeholder="9876543210"
											/>
										</Field>
										<div className="min-h-[32px]">
											{fields.phoneNumber.errors && (
												<FieldError
													errors={fields.phoneNumber.errors?.map((e) => ({
														message: e,
													}))}
												/>
											)}
										</div>
									</FieldGroup>
								</FieldSet>
								<FieldSet>
									<FieldGroup className="gap-2">
										<Field>
											<FieldLabel htmlFor={fields.email.id}>Email</FieldLabel>
											<Input
												{...getInputProps(fields.email, { type: 'email' })}
												autoComplete="off"
												placeholder="john.doe@example.com"
											/>
										</Field>
										<div className="min-h-[32px]">
											{fields.email.errors && (
												<FieldError
													errors={fields.email.errors?.map((e) => ({
														message: e,
													}))}
												/>
											)}
										</div>
									</FieldGroup>
								</FieldSet>
								<FieldSet className="grow">
									<FieldGroup className="grow gap-2">
										<Field className="grow">
											<FieldLabel htmlFor={fields.message.id}>
												Message
											</FieldLabel>
											<Textarea
												{...getTextareaProps(fields.message, {})}
												autoComplete="off"
												placeholder="Type your message here"
												className="grow"
											/>
										</Field>
										<div className="min-h-[32px]">
											{fields.message.errors && (
												<FieldError
													errors={fields.message.errors?.map((e) => ({
														message: e,
													}))}
												/>
											)}
										</div>
									</FieldGroup>
								</FieldSet>

								<FieldSet className="flex items-center space-x-2">
									<FieldGroup className="gap-2">
										<Field orientation={'horizontal'}>
											<Checkbox
												{...(() => {
													const { type, ...rest } = getInputProps(
														fields.privacy,
														{
															type: 'checkbox',
														},
													)
													return rest
												})()}
											/>
											<FieldLabel
												htmlFor={fields.privacy.id}
												className="text-xs"
											>
												I agree to the
												<Link to="/legal/privacy-policy">privacy policy</Link>
											</FieldLabel>
										</Field>
										<div className="min-h-[32px]">
											{fields.privacy.errors && (
												<FieldError
													errors={fields.privacy.errors?.map((e) => ({
														message: e,
													}))}
												/>
											)}
										</div>
									</FieldGroup>
								</FieldSet>
								<Button type="submit" className="font-bold">
									Submit
								</Button>
							</Form>
						)}
					</div>
					<div className="row-span-2 hidden rounded-2xl bg-[url(/img/contact/contact.jpg)] bg-cover bg-center shadow-sm inset-shadow-2xs grayscale lg:flex"></div>
					<div className="bg-card border-muted flex flex-col justify-between gap-4 rounded-2xl border p-8 shadow-sm inset-shadow-2xs">
						<ContactItem
							iconName="phone"
							title="Phone"
							info="+91 80768 28540"
							href="tel:8076828540"
						/>
						<ContactItem
							iconName="mail-line"
							title="Email"
							info="support@foodemy.in"
							href="mailto:support@foodemy.in"
						/>
						<ContactItem
							iconName="whatsapp-line"
							title="WhatsApp"
							info="+91 80768 28540"
							href="https://wa.me/918076828540"
						/>
					</div>
				</div>
			</div>
		</section>
	)
}

export const meta: Route.MetaFunction = () => [
	{
		title: 'Contact | Foodemy',
	},
	{
		name: 'description',
		content:
			"Have questions or feedback? Contact Foodemy for support, inquiries, or partnership opportunities. We're here to help!",
	},
]

const ContactFormSchema = z.object({
	firstName: z
		.string()
		.min(2, 'First name must be at least 2 characters long')
		.max(100, 'First name must be at most 100 characters long'),
	lastName: z
		.string()
		.min(2, 'Last name must be at least 2 characters long')
		.max(100, 'Last name must be at most 100 characters long'),
	phoneNumber: z
		.string()
		.refine((val) => !val || /^(\+91[\-\s]?)?[0]?(91)?[6789]\d{9}$/.test(val), {
			message: 'Please enter a valid phone number',
		}),
	email: z.string().email('Please enter a valid email address'),
	message: z
		.string()
		.min(10, 'Message must be at least 10 characters long')
		.max(500, 'Message must be at most 500 characters long'),
	privacy: z
		.boolean({ required_error: 'You must accept the privacy policy' })
		.refine((val) => val === true, {
			message: 'You must accept the privacy policy',
		}),
})

{
	/* export function FieldError({ errors }: { errors?: string[] }) {
	if (!errors || errors.length === 0) return null
	return <span className="text-destructive text-xs">{errors[0]}</span>
} */
}

function ContactItem({
	iconName,
	title,
	info,
	href = '#',
}: {
	iconName: IconName
	title: string
	info: string
	href?: string
}) {
	return (
		<div className="bg-muted/50 flex items-center gap-6 rounded-xl px-4 py-3">
			<div className="bg-info/20 flex size-12 items-center justify-center rounded-full p-1">
				<Icon name={iconName} className="text-info size-6" />
			</div>
			<div className="flex flex-col">
				<span className="text-secondary text-sm font-thin">{title}</span>
				<a
					href={href}
					className="text-primary-foreground font-semibold no-underline"
				>
					{info}
				</a>
			</div>
		</div>
	)
}
