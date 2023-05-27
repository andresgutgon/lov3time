import { Stack, SplashScreen } from 'expo-router'
import Provider from '@ui/Provider'
import useFonts from 'app/hooks/useFonts'

export default function AppLayout() {
  const areLoaded = useFonts()

  if (!areLoaded) {
    return <SplashScreen />
  }

  return (
    <Provider>
      <Stack />
    </Provider>
  )
}
