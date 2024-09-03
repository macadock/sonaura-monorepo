'use server'

import { getRequestContext } from "@cloudflare/next-on-pages";

export default async function getPublicApiUrl() {
  const { env } = getRequestContext()

  return env.NEXT_PUBLIC_API_URL
}