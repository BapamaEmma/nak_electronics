import { useState, useEffect } from 'react'
import { collection, onSnapshot, deleteDoc, doc } from 'firebase/firestore'
import { db } from '../firebase'
import FeaturedForm from './FeaturedForm'

export default function FeaturedTab() {
  const [items, setItems] = useState([])
  const [loading, setLoading] = useState(true)
  const [showForm, setShowForm] = useState(false)
  const [editItem, setEditItem] = useState(null)
  const [deleteTarget, setDeleteTarget] = useState(null)

  useEffect(() => {
    const unsubscribe = onSnapshot(
      collection(db, 'featured_products'),
      (snap) => {
        const data = snap.docs
          .map((d) => ({ id: d.id, ...d.data() }))
          .sort((a, b) => (a.order ?? 0) - (b.order ?? 0))
        setItems(data)
        setLoading(false)
      },
      () => setLoading(false),
    )
    return unsubscribe
  }, [])

  const confirmDelete = async () => {
    if (!deleteTarget) return
    await deleteDoc(doc(db, 'featured_products', deleteTarget))
    setDeleteTarget(null)
  }

  return (
    <div className="space-y-6">
      <div className="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
        <div className="flex items-center justify-between px-6 py-5 border-b border-gray-100">
          <h2 className="text-lg font-semibold text-gray-900">
            Featured Products <span className="ml-1 text-sm font-normal text-gray-400">({items.length})</span>
          </h2>
          <button
            onClick={() => { setEditItem(null); setShowForm(true) }}
            className="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-xl text-sm font-semibold transition shadow-sm"
          >
            + Add Featured
          </button>
        </div>

        {loading ? (
          <div className="flex justify-center py-20">
            <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-red-600" />
          </div>
        ) : items.length === 0 ? (
          <div className="text-center py-20 text-gray-400">
            <p className="text-4xl mb-3">⭐</p>
            <p className="font-medium">No featured products yet.</p>
            <p className="text-sm mt-1">Click <strong>+ Add Featured</strong> to get started.</p>
          </div>
        ) : (
          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead>
                <tr className="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider bg-gray-50 border-b border-gray-100">
                  <th className="px-6 py-3">ID</th>
                  <th className="px-6 py-3">Product</th>
                  <th className="px-6 py-3">Price</th>
                  <th className="px-6 py-3">Original Price</th>
                  <th className="px-6 py-3">Rating</th>
                  <th className="px-6 py-3">Best Seller</th>
                  <th className="px-6 py-3">Order</th>
                  <th className="px-6 py-3">Actions</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-50">
                {items.map((item) => (
                  <tr key={item.id} className="hover:bg-gray-50 transition">
                    <td className="px-6 py-4">
                      <span className="font-mono text-xs text-gray-400 bg-gray-100 px-2 py-1 rounded select-all">{item.id}</span>
                    </td>
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-3">
                        {item.imageUrl && (
                          <img
                            src={item.imageUrl}
                            alt={item.name}
                            className="w-10 h-10 rounded-lg object-cover bg-gray-100"
                            onError={(e) => e.target.style.display = 'none'}
                          />
                        )}
                        <p className="font-medium text-gray-900">{item.name}</p>
                      </div>
                    </td>
                    <td className="px-6 py-4 font-semibold text-gray-900">GH₵{Number(item.price || 0).toFixed(2)}</td>
                    <td className="px-6 py-4 text-gray-500 line-through">GH₵{Number(item.originalPrice || 0).toFixed(2)}</td>
                    <td className="px-6 py-4 text-gray-600">⭐ {item.rating} ({item.reviewCount})</td>
                    <td className="px-6 py-4">
                      <span className={`px-2.5 py-1 rounded-full text-xs font-medium ${item.isBestSeller ? 'bg-orange-100 text-orange-700' : 'bg-gray-100 text-gray-500'}`}>
                        {item.isBestSeller ? 'Yes' : 'No'}
                      </span>
                    </td>
                    <td className="px-6 py-4 text-gray-600">{item.order ?? 0}</td>
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-3">
                        <button onClick={() => { setEditItem(item); setShowForm(true) }} className="text-blue-600 hover:text-blue-800 font-medium">Edit</button>
                        <button onClick={() => setDeleteTarget(item.id)} className="text-red-500 hover:text-red-700 font-medium">Delete</button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>

      {showForm && <FeaturedForm item={editItem} onClose={() => { setShowForm(false); setEditItem(null) }} />}

      {deleteTarget && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
          <div className="bg-white rounded-2xl shadow-2xl p-6 w-full max-w-sm">
            <div className="text-center mb-5">
              <span className="text-4xl">🗑️</span>
              <h3 className="text-lg font-semibold text-gray-900 mt-3">Remove Featured Product?</h3>
            </div>
            <div className="flex gap-3">
              <button onClick={() => setDeleteTarget(null)} className="flex-1 border border-gray-300 text-gray-700 py-2.5 rounded-xl text-sm font-medium hover:bg-gray-50 transition">Cancel</button>
              <button onClick={confirmDelete} className="flex-1 bg-red-600 hover:bg-red-700 text-white py-2.5 rounded-xl text-sm font-semibold transition">Delete</button>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
