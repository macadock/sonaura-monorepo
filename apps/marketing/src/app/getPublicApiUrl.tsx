import { getRequestContext } from "@cloudflare/next-on-pages";

export const runtime = "edge"

export default function getPublicApiUrl() {
  const { env } = getRequestContext()

  return env.NEXT_PUBLIC_API_URL
}