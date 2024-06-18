/** @type {import('tailwindcss').Config} */
import colorPallette from "tailwindcss/colors";

export default {
	content: [
		'./src/**/*.{astro,md,mdx,ts,tsx}',
		'./node_modules/flowbite/**/*.js'
	],
	theme: {
		extend: {},
	},
	plugins: [
		require('flowbite/plugin'),
		require('tailwindcss-themer')({
			themes: [
				{
					name: 'theme-selkies-dark',
					extend: {
						colors: {
							// Primary accent
							'selkies-accent-lighter': colorPallette.yellow["400"],
							'selkies-accent': colorPallette.yellow["500"],
							'selkies-accent-darker': colorPallette.yellow["600"],
							// Primary fill
							'selkies-fill-lighter': colorPallette.slate["800"],
							'selkies-fill': colorPallette.slate["900"],
							'selkies-fill-darker': colorPallette.slate["950"],
							// Text color
							'selkies-text': colorPallette.neutral["200"],
							// Shadow color
							'selkies-shadow': colorPallette.black["500"],
						},
					},
				},
				{
					name: 'theme-selkies-light',
					extend: {
						colors: {
							// Primary accent
							'selkies-accent-lighter': colorPallette.yellow["400"],
							'selkies-accent': colorPallette.yellow["500"],
							'selkies-accent-darker': colorPallette.yellow["600"],
							// Primary fill
							'selkies-fill-lighter': colorPallette.slate["100"],
							'selkies-fill': colorPallette.slate["200"],
							'selkies-fill-darker': colorPallette.slate["300"],
							// Text color
							'selkies-text': colorPallette.neutral["800"],
							// Shadow color
							'selkies-shadow': colorPallette.black["500"],
						},
					},
				},
			]
		})
	],
}
