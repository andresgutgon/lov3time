import { ReactNode } from 'react'

export type Props = { children: ReactNode }
export function Button({ children }: Props) {
  return (
    <div className='rounded-md '>
      <a href='https://turbo.build/repo/docs'>
        <div className='flex w-full items-center justify-center rounded-md border border-transparent px-8 py-3 text-base font-medium no-underline bg-white text-black hover:bg-gray-300 md:py-3 md:px-10 md:text-lg md:leading-6'>
          {children}
          <span className='ml-2 bg-gradient-to-r from-brandred to-brandblue bg-clip-text text-transparent'>
            →
          </span>
        </div>
      </a>
    </div>
  )
}