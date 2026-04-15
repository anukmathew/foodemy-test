import { createHash } from 'node:crypto'
import { readdir, readFile, stat } from 'node:fs/promises'
import path from 'path'
import matter from 'gray-matter'
import { bundleMDX } from 'mdx-bundler'
import calculateReadingTime from 'reading-time'
import rehypeCallouts, { type UserOptions } from 'rehype-callouts'
import rehypeKatex from 'rehype-katex'
import remarkMathJax from 'rehype-mathjax'
import remarkGfm from 'remark-gfm'
import remarkMath from 'remark-math'
import { cache, cachified } from '#app/utils/cache.server.ts'

export type BlogFrontmatter = {
	title: string
	date: string
	author: {
		name: string
		avatar?: string
		socials?: {
			twitter?: string
			instagram?: string
			linkedin?: string
			facebook?: string
			youtube?: string
		}
	}
	bannerImage: string
	tags: string[]
	description: string
	// ...any other fields you use
	readingTime: {
		text: string
		time: number
		words: number
		minutes: number
	}
}

type BlogFrontmatterWithoutReadingTime = Omit<BlogFrontmatter, 'readingTime'>

export async function getMDXPage({
	dir,
	slug,
	jsxFiles: _jsxFiles,
}: {
	dir: string
	slug: string
	jsxFiles?: string[]
}) {
	const mdxFilePath = path.resolve(`content/${dir}/${slug}.mdx`)
	let mdxFileStats: Awaited<ReturnType<typeof stat>>
	try {
		mdxFileStats = await stat(mdxFilePath)
	} catch {
		throw new Response('MDX file not found', { status: 404 })
	}

	return cachified({
		key: `mdx-page:${dir}:${slug}:${Math.trunc(mdxFileStats.mtimeMs)}`,
		cache,
		ttl: 1000 * 60 * 60,
		swr: 1000 * 60 * 60 * 24 * 7,
		async getFreshValue() {
			const result = await bundleMDX<BlogFrontmatter>({
				file: mdxFilePath,
				cwd: path.resolve(`content/${dir}`),
				mdxOptions(options) {
					options.remarkPlugins = [
						...(options.remarkPlugins ?? []),
						remarkGfm,
						remarkMath,
						remarkMathJax,
						// remarkDirective,
						// answerBlock,
					]
					options.rehypePlugins = [
						...(options.rehypePlugins ?? []),

						[
							rehypeCallouts,
							{
								theme: 'obsidian',
								callouts: {
									info: {
										title: 'Info',
										indicator:
											'<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-bookmark-check-icon lucide-bookmark-check"><path d="m19 21-7-4-7 4V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2Z"/><path d="m9 10 2 2 4-4"/></svg>',
									},
									answer: {
										title: 'Answer',
										indicator:
											'<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-bookmark-check-icon lucide-bookmark-check"><path d="m19 21-7-4-7 4V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2Z"/><path d="m9 10 2 2 4-4"/></svg>',
									},
								},
							} as UserOptions,
						],
						rehypeKatex,
					]
					return options
				},
			})
			const readingTime = calculateReadingTime(result.matter.content)
			return {
				...result,
				frontmatter: {
					...result.frontmatter,
					readingTime,
				},
			}
		},
	})
}

// create a function to get all the slugs of the mdx files in a directory and get its frontmatter only
export async function getAllMDXSlugs(dir: string) {
	const directory = path.resolve(`content/${dir}`)
	const files = (await readdir(directory))
		.filter((file) => path.extname(file) === '.mdx')
		.sort()
	const fileStats = await Promise.all(
		files.map((file) => stat(path.join(directory, file))),
	)
	const cacheVersion = createHash('sha1')
		.update(
			files
				.map(
					(file, index) => `${file}:${Math.trunc(fileStats[index]!.mtimeMs)}`,
				)
				.join('|'),
		)
		.digest('hex')

	return cachified({
		key: `mdx-slugs:${dir}:${cacheVersion}`,
		cache,
		ttl: 1000 * 60 * 30,
		swr: 1000 * 60 * 60 * 24,
		async getFreshValue() {
			return Promise.all(
				files.map(async (file) => {
					const slug = path.basename(file, '.mdx')
					const fullPath = path.join(directory, file)
					const source = await readFile(fullPath, 'utf-8')
					const parsed = matter(source)
					const frontmatter = parsed.data as BlogFrontmatterWithoutReadingTime
					const rawDate = (parsed.data as { date?: unknown }).date
					const normalizedDate =
						rawDate instanceof Date
							? rawDate.toISOString()
							: typeof rawDate === 'string'
								? rawDate
								: String(rawDate ?? '')
					return {
						slug,
						frontmatter: {
							...frontmatter,
							date: normalizedDate,
							readingTime: calculateReadingTime(parsed.content),
						},
					}
				}),
			)
		},
	})
}
