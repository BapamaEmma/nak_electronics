import { initializeApp } from 'firebase/app'
import { getFirestore } from 'firebase/firestore'
import { getAuth } from 'firebase/auth'

const firebaseConfig = {
  apiKey: 'AIzaSyBYOfULcm558-goG0OzNCv7Dd0hsou4W70',
  authDomain: 'nak-online-shop.firebaseapp.com',
  projectId: 'nak-online-shop',
  storageBucket: 'nak-online-shop.firebasestorage.app',
  messagingSenderId: '872303369079',
  appId: '1:872303369079:web:3f767427afb9cf0d4bdf72',
  measurementId: 'G-X430EEXXJN',
}

const app = initializeApp(firebaseConfig)

export const db = getFirestore(app)
export const auth = getAuth(app)
