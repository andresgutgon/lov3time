import { ReactNode } from 'react'
import { SafeArea } from './SafeArea'

export default function Provider({ children }: { children: ReactNode }) {
  return <SafeArea>{children}</SafeArea>
}
