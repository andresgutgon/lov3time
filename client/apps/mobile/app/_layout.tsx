import { Stack } from 'expo-router'
import Provider from '@ui/Provider'

export default function AppLayout() {
  return (
    <Provider>
      <Stack />
    </Provider>
  )
}
