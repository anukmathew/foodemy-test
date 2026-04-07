import { redirect } from 'react-router'
import { type Route } from './+types/legal._index.ts'

export async function loader({ request }: Route.LoaderArgs) {
	return redirect('/legal/tnc')
}
