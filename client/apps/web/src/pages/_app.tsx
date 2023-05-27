import 'raf/polyfill'
import 'setimmediate'

import cn from 'classnames'
import localFont from 'next/font/local'

const inter = localFont({
  variable: '--font-inter',
  src: [
    {
      path: '../../public/font/Inter/Inter-Regular.otf',
      weight: '400',
      style: 'normal',
    },
    {
      path: '../../public/font/Inter/Inter-Medium.otf',
      weight: '500',
      style: 'normal',
    },
    {
      path: '../../public/font/Inter/Inter-Bold.otf',
      weight: '700',
      style: 'normal',
    },
    {
      path: '../../public/font/Inter/Inter-Black.otf',
      weight: '900',
      style: 'normal',
    },
  ],
})

import '../global.css'

import Head from 'next/head'
import type { SolitoAppProps } from 'solito'
import Provider from '@ui/Provider'

export default function App({ Component, pageProps }: SolitoAppProps) {
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

        <main className={cn(inter.variable)}>
          <Component {...pageProps} />
        </main>
      </Provider>
    </>
  )
}

