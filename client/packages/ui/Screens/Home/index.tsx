// This pollyfills are necessary to work in NextJS with `reanimated` (Animations for React Native)
// https://docs.swmansion.com/react-native-reanimated/docs/fundamentals/web-support/#nextjs-polyfill
//
/* import 'raf/polyfill' */
/* import 'setimmediate' */

// The problem is that this does not work with NextJS 13 and the `app` folder
// [Add pollyfills in NextJS 13](https://github.com/vercel/next.js/discussions/20992)
// [Solito issue](https://github.com/nandorojo/solito/issues/383)
import { MotiLink } from 'solito/moti'

import { A, H1, P, Text, TextLink } from '@ui/ds/atoms/Text'
import Row from '@ui/ds/atoms/Row'
import View from '@ui/ds/atoms/View'

export default function HomeScreen() {
  return (
    <View className='flex-1 items-center justify-center p-3'>
      <H1>Welcome to Solito.</H1>
      <View className='max-w-xl'>
        <Text fontWeight='black' className='text-center'>
          Here is a basic starter to show you how you can navigate from one
          screen to another. This screen uses the same code on Next.js and React
          Native.
        </Text>
        <P className='text-center'>
          Solito is made by{' '}
          <A
            href='https://twitter.com/fernandotherojo'
            hrefAttrs={{
              target: '_blank',
              rel: 'noreferrer',
            }}
          >
            Fernando Rojo
          </A>
          .
        </P>
        <P className='text-center'>
          NativeWind is made by{' '}
          <A
            href='https://twitter.com/mark__lawlor'
            hrefAttrs={{
              target: '_blank',
              rel: 'noreferrer',
            }}
          >
            Mark Lawlor
          </A>
          .
        </P>
      </View>
      <View className='h-[32px]' />
      <Row className='space-x-8'>
        <TextLink href='/user/fernando'>Regular Link</TextLink>
        <MotiLink
          href='/user/fernando'
          animate={({ hovered, pressed }) => {
            'worklet'

            return {
              scale: pressed ? 0.95 : hovered ? 1.1 : 1,
              rotateZ: pressed ? '0deg' : hovered ? '-3deg' : '0deg',
            }
          }}
          transition={{
            type: 'timing',
            duration: 150,
          }}
        >
          <Text selectable={false} className='text-base font-bold'>
            Moti Link
          </Text>
        </MotiLink>
      </Row>
    </View>
  )
}
