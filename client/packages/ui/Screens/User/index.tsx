import { createParam } from 'solito'
import { TextLink } from 'solito/link'
import { Text } from '@ui/ds/atoms/Text'
import View from '@ui/ds/atoms/View'

const { useParam } = createParam<{ id: string }>()

export default function UserDetailScreen() {
  const [id] = useParam('id')

  return (
    <View className='flex-1 items-center justify-center'>
      <Text className='mb-4 text-center font-bold'>{`User ID: ${id}`}</Text>
      <TextLink href='/'>👈 Go Home</TextLink>
    </View>
  )
}
