import { LogoSoup } from '@sanity-labs/logo-soup/react'
import _ from 'lodash'
import { InfiniteMovingLogos } from '#app/components/aceternity/infinite-moving-logos.tsx'

export const uniLogos: { src: string; alt: string }[] = [
	{
		src: '/resources/images?src=/img/index/uni/tezpur_uni.svg&format=webp&w=200&h=200',
		alt: 'Tezpur University Logo',
	},
	{
		src: '/resources/images?src=/img/index/uni/ict_mumbai.svg&format=webp&w=200&h=200',
		alt: 'ICT Mumbai Logo',
	},
	{
		src: '/resources/images?src=/img/index/uni/niftem_k.svg&format=webp&w=200&h=200',
		alt: 'NIFTEM Kundli Logo',
	},
	{
		src: '/resources/images?src=/img/index/uni/aks.svg&format=webp&w=200&h=200',
		alt: 'AKS University, Satna Logo',
	},
	{
		src: '/resources/images?src=/img/index/uni/amity.svg&format=webp&w=200&h=200',
		alt: 'Amity University Logo',
	},
	{
		src: '/resources/images?src=/img/index/uni/angrau.svg&format=webp&w=200&h=200',
		alt: 'ANGRAU Logo',
	},
	{
		src: '/resources/images?src=/img/index/uni/anna.svg&format=webp&w=200&h=200',
		alt: 'Anna University Logo',
	},
	{
		src: '/resources/images?src=/img/index/uni/bhu.svg&format=webp&w=200&h=200',
		alt: 'Benaras Hindu University Logo',
	},
	{
		src: '/resources/images?src=/img/index/uni/bit_mesra.svg&format=webp&w=200&h=200',
		alt: 'BIT Mesra Logo',
	},
	{
		src: '/resources/images?src=/img/index/uni/cu.svg&format=webp&w=200&h=200',
		alt: 'Chandigarh University Logo',
	},
	{
		src: '/resources/images?src=/img/index/uni/dypatu.svg&format=webp&w=200&h=200',
		alt: 'DYPATIL University Logo',
	},
	{
		src: '/resources/images?src=/img/index/uni/gbu.svg&format=webp&w=200&h=200',
		alt: 'Gautam Buddha University Logo',
	},
	{
		src: '/resources/images?src=/img/index/uni/gjust.svg&format=webp&w=200&h=200',
		alt: 'GJUST Logo',
	},
	{
		src: '/resources/images?src=/img/index/uni/gkciet.svg&format=webp&w=200&h=200',
		alt: 'Ghani Khan Choudhury Institute of Engineering & Technology Logo',
	},
	{
		src: '/resources/images?src=/img/index/uni/makaut.svg&format=webp&w=200&h=200',
		alt: 'MAKAUT Logo',
	},
	{
		src: '/resources/images?src=/img/index/uni/mit.svg&format=webp&w=200&h=200',
		alt: 'MIT Logo',
	},
	{
		src: '/resources/images?src=/img/index/uni/sharda.svg&format=webp&w=200&h=200',
		alt: 'Sharda University Logo',
	},
	{
		src: '/resources/images?src=/img/index/uni/tnau.svg&format=webp&w=200&h=200',
		alt: 'TNAU Logo',
	},

	//add remaining files from public/img/uni
]

export default function TrustedBy() {
	return (
		<section className="bg-white">
			<div
				className="container flex flex-col gap-6 pt-24"
				// initial={{ opacity: 0.0, y: -80 }}
				// whileInView={{ opacity: 1, y: 0 }}
				// transition={{
				// 	delay: 0.3,
				// 	duration: 0.8,
				// 	ease: 'easeInOut',
				// }}
				// viewport={{ once: true }}
			>
				<h2 className="mb-4 text-center">Trusted by students from</h2>
				<InfiniteMovingLogos
					items={uniLogos}
					speed="slow"
					direction="right"
					className="hidden lg:block"
				/>
				<LogoSoup
					logos={_.take(_.shuffle(uniLogos), 7)}
					className="block lg:hidden"
					baseSize={72}
				/>
			</div>
		</section>
	)
}
