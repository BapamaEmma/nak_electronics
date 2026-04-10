import { useState } from 'react'
import { signOut } from 'firebase/auth'
import { auth } from '../firebase'
import ProductsTab from './ProductsTab'
import FeaturedTab from './FeaturedTab'
import BrandsTab from './BrandsTab'

const TABS = ['Products', 'Featured Products', 'Brands']

export default function Dashboard({ user }) {
  const [activeTab, setActiveTab] = useState('Products')

  return (
    <div className="min-h-screen bg-gray-50">
      {/* ── Header ─────────────────────────────────────────────────────────── */}
      <header className="bg-white border-b border-gray-200 sticky top-0 z-30">
        <div className="max-w-7xl mx-auto px-6 py-4 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <div className="w-9 h-9 bg-red-600 rounded-xl flex items-center justify-center shadow">
              <span className="text-white font-bold">N</span>
            </div>
            <div>
              <h1 className="font-bold text-gray-900 leading-tight">NAK Electronics</h1>
              <p className="text-xs text-gray-400 leading-tight">Admin Dashboard</p>
            </div>
          </div>
          <div className="flex items-center gap-4">
            <span className="hidden sm:block text-sm text-gray-500">{user.email}</span>
            <button
              onClick={() => signOut(auth)}
              className="text-sm text-red-600 hover:text-red-800 font-medium border border-red-200 hover:border-red-400 px-3 py-1.5 rounded-lg transition"
            >
              Sign Out
            </button>
          </div>
        </div>

        {/* ── Tabs ───────────────────────────────────────────────────────── */}
        <div className="max-w-7xl mx-auto px-6 flex gap-1 border-t border-gray-100">
          {TABS.map((tab) => (
            <button
              key={tab}
              onClick={() => setActiveTab(tab)}
              className={`px-5 py-3 text-sm font-medium border-b-2 transition ${
                activeTab === tab
                  ? 'border-red-600 text-red-600'
                  : 'border-transparent text-gray-500 hover:text-gray-800'
              }`}
            >
              {tab}
            </button>
          ))}
        </div>
      </header>

      <div className="max-w-7xl mx-auto px-6 py-8">
        {activeTab === 'Products' && <ProductsTab />}
        {activeTab === 'Featured Products' && <FeaturedTab />}
        {activeTab === 'Brands' && <BrandsTab />}
      </div>
    </div>
  )
}
