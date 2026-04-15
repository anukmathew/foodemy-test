import { readdir } from 'fs/promises'
import path from 'path'
import _ from 'lodash'
import { bundleMDX } from 'mdx-bundler'
import calculateReadingTime from 'reading-time'
import rehypeCallouts, { type UserOptions } from 'rehype-callouts'
import rehypeKatex from 'rehype-katex'
import remarkMathJax from 'rehype-mathjax'
import remarkGfm from 'remark-gfm'
import remarkMath from 'remark-math'

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

export async function getMDXPage({
	dir,
	slug,
	jsxFiles,
}: {
	dir: string
	slug: string
	jsxFiles?: string[]
}) {
	const mdxFilePath = `content/${dir}/${slug}.mdx`
	const directory = path.dirname(mdxFilePath)
	const allFiles = await readdir(directory)
	if (_.includes(allFiles, path.basename(mdxFilePath).toString())) {
		const result = await bundleMDX<BlogFrontmatter>({
			file: path.resolve(mdxFilePath),
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
		// return {result}
	} else {
		throw new Response('MDX file not found', { status: 404 })
	}
}

// create a function to get all the slugs of the mdx files in a directory and get its frontmatter only
export async function getAllMDXSlugs(dir: string) {
	const directory = path.resolve(`content/${dir}`)
	const files = await readdir(directory)
	const slugs = await Promise.all(
		files
			.filter((file) => path.extname(file) === '.mdx')
			.map(async (file) => {
				const { frontmatter } = await getMDXPage({
					dir,
					slug: path.basename(file, '.mdx'),
				})
				return {
					slug: path.basename(file, '.mdx'),
					frontmatter,
				}
			}),
	)
	return slugs
}
