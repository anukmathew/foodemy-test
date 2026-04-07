import { InfiniteMovingLogos } from '#app/components/aceternity/infinite-moving-logos.tsx'

const items: { src: string; alt: string }[] = [
	{
		src: '/img/uni/tezpur_uni.svg',
		alt: 'Tezpur University Logo',
	},
	{
		src: '/img/uni/ict_mumbai.svg',
		alt: 'ICT Mumbai Logo',
	},
	{
		src: '/img/uni/niftem_k.svg',
		alt: 'NIFTEM Kundli Logo',
	},
	{
		src: '/img/uni/aks.svg',
		alt: 'AKS University, Satna Logo',
	},
	{
		src: '/img/uni/amity.svg',
		alt: 'Amity University Logo',
	},
	{
		src: '/img/uni/angrau.svg',
		alt: 'ANGRAU Logo',
	},
	{
		src: '/img/uni/anna.svg',
		alt: 'Anna University Logo',
	},
	{
		src: '/img/uni/bhu.svg',
		alt: 'Benaras Hindu University Logo',
	},
	{
		src: '/img/uni/bit_mesra.svg',
		alt: 'BIT Mesra Logo',
	},
	{
		src: '/img/uni/cu.svg',
		alt: 'Chandigarh University Logo',
	},
	{
		src: '/img/uni/dypatu.svg',
		alt: 'DYPATIL University Logo',
	},
	{
		src: '/img/uni/gbu.svg',
		alt: 'Gautam Buddha University Logo',
	},
	{
		src: '/img/uni/gjust.svg',
		alt: 'GJUST Logo',
	},
	{
		src: '/img/uni/gkciet.svg',
		alt: 'Ghani Khan Choudhury Institute of Engineering & Technology Logo',
	},
	{
		src: '/img/uni/makaut.svg',
		alt: 'MAKAUT Logo',
	},
	{
		src: '/img/uni/mit.svg',
		alt: 'MIT Logo',
	},
	{
		src: '/img/uni/sharda.svg',
		alt: 'Sharda University Logo',
	},
	{
		src: '/img/uni/tnau.svg',
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
				<InfiniteMovingLogos items={items} speed="slow" direction="right" />
			</div>
		</section>
	)
}
