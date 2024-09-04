import { getRequestContext } from "@cloudflare/next-on-pages";


export const runtime = "edge";

export default function Home() {

  const { env } = getRequestContext()

  const nextApiCloudflare = env.NEXT_PUBLIC_API_URL
  const nextApiLocalhost = process.env.NEXT_PUBLIC_API_URL

  return (
    <main>
      <h1>{`getRequestContext: ${env.NEXT_PUBLIC_API_URL}`}</h1>
        <h1>{`process.env: ${nextApiLocalhost}`}</h1>
    </main>
  );
}
