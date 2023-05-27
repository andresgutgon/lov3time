import { useFonts as useExpoFonts } from 'expo-font'

const useFonts = () => {
  const [isLoaded] = useExpoFonts({
    Inter_400: require('../../../web/public/font/Inter/Inter-Regular.otf'),
    Inter_500: require('../../../web/public/font/Inter/Inter-Medium.otf'),
    Inter_700: require('../../../web/public/font/Inter/Inter-Bold.otf'),
    Inter_900: require('../../../web/public/font/Inter/Inter-Black.otf'),
  })

  return isLoaded
}

export default useFonts
