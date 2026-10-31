import { createFileRoute } from '@tanstack/react-router'
import Marketplace from '../marketplace'

export const Route = createFileRoute('/account')({
  head: () => ({ meta: [{ title: 'Your account | RealTalent' }] }),
  component: Marketplace,
})
