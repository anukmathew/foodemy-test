import { useEffect, useRef, useState } from 'react'
import {
	EmailShareButton,
	FacebookShareButton,
	LinkedinShareButton,
	RedditShareButton,
	TelegramShareButton,
	WhatsappShareButton,
	XShareButton,
} from 'react-share'
import {
	Avatar,
	AvatarFallback,
	AvatarImage,
} from '#app/components/ui/avatar.tsx'
import { Badge } from '#app/components/ui/badge.tsx'
import { Button } from '#app/components/ui/button.tsx'
import { Icon } from '#app/components/ui/icon.tsx'
import { Separator } from '#app/components/ui/separator.tsx'
import '#app/styles/blog.css'
import { type BlogFrontmatter } from '#app/utils/custom-utils/mdx.server.ts'
import { cn } from '#app/utils/misc.tsx'

export default function BlogPage({
	frontMatter,
	domainUrl,
	slug,
	children,
	className,
}: {
	frontMatter: BlogFrontmatter
	domainUrl: string
	slug: string
	children: React.ReactNode
	className?: string
}) {
	const socials = frontMatter.author.socials || null
	const [isCopied, setIsCopied] = useState(false)
	const copyResetTimeoutRef = useRef<ReturnType<typeof setTimeout> | null>(null)

	useEffect(() => {
		return () => {
			if (copyResetTimeoutRef.current) {
				clearTimeout(copyResetTimeoutRef.current)
			}
		}
	}, [])

	const handleCopyLink = async () => {
		await navigator.clipboard.writeText(`${domainUrl}/blog/${slug}`)
		setIsCopied(true)

		if (copyResetTimeoutRef.current) {
			clearTimeout(copyResetTimeoutRef.current)
		}

		copyResetTimeoutRef.current = setTimeout(() => {
			setIsCopied(false)
		}, 2000)
	}

	return (
		<article className="container flex flex-col items-center gap-12 py-30 md:py-48 lg:px-36">
			<div className="flex max-w-[65ch] flex-col items-center gap-12">
				<div className="flex flex-col items-center gap-6">
					<span className="text-destructive text-sm font-bold">
						Published on{' '}
						{new Date(frontMatter.date).toLocaleDateString('en-US', {
							year: 'numeric',
							month: 'long',
							day: 'numeric',
						})}
					</span>
					<h1 className="text-center text-3xl font-bold lg:text-4xl xl:text-5xl">
						{frontMatter.title}
					</h1>
					<div className="flex flex-wrap justify-center gap-2">
						{frontMatter.tags.length > 0 &&
							frontMatter.tags.map((tag) => (
								<Badge key={tag} variant={'secondary'}>
									{tag}
								</Badge>
							))}
					</div>
				</div>

				<div className="container flex max-h-96 items-center justify-center overflow-hidden rounded-2xl bg-red-50 p-0">
					<img
						src={frontMatter.bannerImage}
						alt={frontMatter.title}
						className="w-full object-contain"
					/>
				</div>
			</div>

			<div
				className={cn(
					className,
					[
						'prose',
						'prose-figcaption:text-muted-foreground',
						'select-none',
					].join(' '),
				)}
			>
				{children}
			</div>
			<Separator />
			<div className="flex w-full flex-col items-center justify-between gap-8 md:flex-row">
				<div className="text-md flex items-center gap-4 font-medium">
					<Avatar className="bg-primary size-12">
						<AvatarImage
							src={frontMatter.author.avatar}
							className="translate-y-0.5"
						/>
						<AvatarFallback className="text-secondary-foreground">
							{frontMatter.author.name
								.split(' ')
								.map((word) => word[0])
								.join('')}
						</AvatarFallback>
					</Avatar>
					<div>
						<div className="flex flex-col gap-1">
							<span className="text-primary-foreground font-semibold">
								{frontMatter.author.name}
							</span>
							<div className="flex items-center gap-2">
								{frontMatter.author.socials && (
									<>
										{socials?.twitter && (
											<a
												href={socials.twitter}
												target="_blank"
												rel="noopener noreferrer"
												className="bg-muted flex items-center rounded-full px-3 py-1 text-xs"
											>
												<Icon
													name="twitter-x-fill"
													className="text-muted-foreground inline"
												/>
											</a>
										)}
										{socials?.linkedin && (
											<a
												href={socials.linkedin}
												target="_blank"
												rel="noopener noreferrer"
												className="bg-muted flex items-center rounded-full px-3 py-1 text-xs"
											>
												<Icon
													name="linkedin-fill"
													className="text-muted-foreground inline"
												/>
											</a>
										)}
										{socials?.instagram && (
											<a
												href={socials.instagram}
												target="_blank"
												rel="noopener noreferrer"
												className="bg-muted flex items-center rounded-full px-3 py-1 text-xs"
											>
												<Icon
													name="instagram-fill"
													className="text-muted-foreground inline"
												/>
											</a>
										)}
									</>
								)}
							</div>
						</div>
					</div>
				</div>
				<div className="flex items-center gap-2">
					<Button
						onClick={handleCopyLink}
						variant="outline"
						className="text-secondary hover:bg-muted flex gap-2 px-2 text-xs ring-0 focus:ring-0"
					>
						<Icon
							name={isCopied ? 'file-copy-fill' : 'file-copy-line'}
							size="md"
						/>
						<span className="hidden md:inline-flex">
							{isCopied ? 'Copied' : 'Copy link'}
						</span>
					</Button>
					<WhatsappShareButton
						title={`Check this amazing blog from Foodemy about ${frontMatter.title}`}
						htmlTitle="Share on WhatsApp"
						url={`${domainUrl}/blog/${slug}`}
						aria-label="Share on WhatsApp"
					>
						<div className="border-input hover:bg-muted flex h-10 items-center rounded-md border px-2">
							<Icon name="whatsapp-fill" className="text-secondary" size="md" />
						</div>
					</WhatsappShareButton>
					<TelegramShareButton
						url={`${domainUrl}/blog/${slug}`}
						htmlTitle="Share via Telegram"
						aria-label="Share via Telegram"
					>
						<div className="border-input hover:bg-muted flex h-10 items-center rounded-md border px-2">
							<Icon name="telegram-fill" className="text-secondary" size="md" />
						</div>
					</TelegramShareButton>
					<LinkedinShareButton
						title={`Check this amazing blog from Foodemy about ${frontMatter.title}`}
						htmlTitle="Share on LinkedIn"
						url={`${domainUrl}/blog/${slug}`}
						aria-label="Share on LinkedIn"
					>
						<div className="border-input hover:bg-muted flex h-10 items-center rounded-md border px-2">
							<Icon name="linkedin-fill" className="text-secondary" size="md" />
						</div>
					</LinkedinShareButton>
					<EmailShareButton
						subject={`Check this amazing blog from Foodemy about ${frontMatter.title}`}
						body={`I thought you might enjoy this blog post from Foodemy: ${domainUrl}/blog/${slug}`}
						url={`${domainUrl}/blog/${slug}`}
						htmlTitle="Share via Email"
						aria-label="Share via Email"
					>
						<div className="border-input hover:bg-muted flex h-10 items-center rounded-md border px-2">
							<Icon name="mail" className="text-secondary" size="md" />
						</div>
					</EmailShareButton>
					<XShareButton
						title={`Check this amazing blog from Foodemy about ${frontMatter.title}`}
						htmlTitle="Share on X"
						url={`${domainUrl}/blog/${slug}`}
						aria-label="Share on X"
					>
						<div className="border-input hover:bg-muted flex h-10 items-center rounded-md border px-2">
							<Icon
								name="twitter-x-fill"
								className="text-secondary"
								size="md"
							/>
						</div>
					</XShareButton>
					<FacebookShareButton
						title={`Check this amazing blog from Foodemy about ${frontMatter.title}`}
						url={`${domainUrl}/blog/${slug}`}
						htmlTitle="Share on Facebook"
						aria-label="Share on Facebook"
					>
						<div className="border-input hover:bg-muted flex h-10 items-center rounded-md border px-2">
							<Icon name="facebook-fill" className="text-secondary" size="md" />
						</div>
					</FacebookShareButton>

					<RedditShareButton
						url={`${domainUrl}/blog/${slug}`}
						htmlTitle="Share via Reddit"
						aria-label="Share via Reddit"
					>
						<div className="border-input hover:bg-muted flex h-10 items-center rounded-md border px-2">
							<Icon name="reddit-fill" className="text-secondary" size="md" />
						</div>
					</RedditShareButton>
				</div>
			</div>
		</article>
	)
}
