export const runtime = "edge";

export default function Home() {
	const nextApiLocalhost = process.env.NEXT_PUBLIC_API_UR;

	return (
		<main>
			<h1>{`process.env: ${nextApiLocalhost}`}</h1>
		</main>
	);
}
