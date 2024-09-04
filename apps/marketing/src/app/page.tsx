export default function Home() {

  const nextApiLocalhost = process.env.NEXT_PUBLIC_API_URL

  return (
    <main>
        <h1>{`process.env: ${nextApiLocalhost}`}</h1>
    </main>
  );
}
