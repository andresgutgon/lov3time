import { ComponentProps, forwardRef } from 'react'
import cn from 'classnames'
import {
  Text as NativeText,
  TextProps,
  Platform,
  Linking,
  TextStyle,
} from 'react-native'
import { styled, StyledProps } from 'nativewind'
import { TextLink as SolitoTextLink } from 'solito/link'

// Duplicated as `font-inter` because `react-native` does
// not support `font-sans` generic style
// https://www.nativewind.dev/tailwind/typography/font-family
const FONT = {
  web: {
    normal: 'font-sans',
    medium: 'font-sans font-medium',
    bold: 'font-sans font-bold',
    black: 'font-sans font-black',
  },
  mobile: {
    normal: 'font-inter400',
    medium: 'font-inter500',
    bold: 'font-inter700',
    black: 'font-inter900',
  },
}

const WrappedText = styled(NativeText)

type Props = TextProps & {
  fontWeight?: 'normal' | 'medium' | 'bold' | 'black'
  // FIXME: Remove this shit
  className?: string
}
export const Text = forwardRef<NativeText, Props>(function Text(
  { children, className = '', fontWeight = 'normal', ...props },
  ref,
) {
  const font = Platform.select({
    web: { className: FONT.web },
    default: { className: FONT.mobile },
  }).className
  return (
    <WrappedText
      ref={ref}
      {...props}
      className={cn(className, {
        [font.normal]: fontWeight === 'normal',
        [font.medium]: fontWeight === 'medium',
        [font.bold]: fontWeight === 'bold',
        [font.black]: fontWeight === 'black',
      })}
    >
      {children}
    </WrappedText>
  )
})

// TODO: Remove this component
export const P = styled(NativeText, 'text-base text-black my-4')

// TODO: Remove this component
export const H1 = styled(NativeText, 'text-3xl font-extrabold my-4')
H1.defaultProps = {
  accessibilityLevel: 1,
  accessibilityRole: 'header',
}

/**
 * This is a more advanced component with custom styles and per-platform functionality
 */
export interface AProps extends ComponentProps<typeof Text> {
  href?: string
  target?: '_blank'
}

export const A = forwardRef<NativeText, StyledProps<AProps>>(function A(
  { className = '', href, target, ...props },
  ref,
) {
  const nativeAProps = Platform.select<Partial<AProps>>({
    web: {
      href,
      target,
      hrefAttrs: {
        rel: 'noreferrer',
        target,
      },
    },
    default: {
      onPress: (event) => {
        props.onPress && props.onPress(event)
        if (Platform.OS !== 'web' && href !== undefined) {
          Linking.openURL(href)
        }
      },
    },
  })

  return (
    <Text
      ref={ref}
      accessibilityRole='link'
      className={cn('text-blue-500 hover:underline', className)}
      {...props}
      {...nativeAProps}
    />
  )
})

/**
 * Solito's TextLink doesn't work directly with styled() since it has a textProps prop
 * By wrapping it in a function, we can forward style down properly.
 */
export const TextLink = styled<
  ComponentProps<typeof SolitoTextLink> & { style?: TextStyle }
>(function TextLink({ style, textProps, ...props }) {
  return (
    <SolitoTextLink
      textProps={{ ...textProps, style: [style, textProps?.style] }}
      {...props}
    />
  )
}, 'text-base font-bold hover:underline text-blue-500')
