import 'raf/polyfill'
import 'setimmediate'

import '../global.css'

import Head from 'next/head'
import type { SolitoAppProps } from 'solito'
import Provider from '@ui/Provider'

function MyApp({ Component, pageProps }: SolitoAppProps) {
  return (
    <>
      <Head>
        <title>Solito Example App</title>
        <meta
          name='description'
          content='Expo + Next.js with Solito. By Fernando Rojo.'
        />
        <link rel='icon' href='/favicon.ico' />
      </Head>
      <Provider>
        <Component {...pageProps} />
      </Provider>
    </>
  )
}

export default MyApp
