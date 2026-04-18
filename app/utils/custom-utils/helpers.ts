/**
 * Formats a number of seconds into a string representing hours.
 * @param {number} seconds - The number of seconds to convert.
 * @returns {string} The formatted hours string.
 */
export function formatHours(seconds: number): string {
	let hours = (seconds / 3600).toFixed(1)
	hours = hours.replace(/\.0$/, '')
	return `${hours} ${Number(hours) === 1 ? 'hour' : 'hours'}`
}

export const formatINR = (amountInPaise: number) => {
	return new Intl.NumberFormat('en-IN', {
		maximumFractionDigits: 0,
	}).format(amountInPaise / 100)
}
