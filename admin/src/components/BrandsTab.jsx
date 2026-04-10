import { useState, useEffect } from 'react'
import { collection, onSnapshot, deleteDoc, doc } from 'firebase/firestore'
import { db } from '../firebase'
import BrandForm from './BrandForm'

export default function BrandsTab() {
  const [brands, setBrands] = useState([])
  const [loading, setLoading] = useState(true)
  const [showForm, setShowForm] = useState(false)
  const [editBrand, setEditBrand] = useState(null)
  const [deleteTarget, setDeleteTarget] = useState(null)

  useEffect(() => {
    const unsubscribe = onSnapshot(
      collection(db, 'brands'),
      (snap) => {
        const data = snap.docs
          .map((d) => ({ id: d.id, ...d.data() }))
          .sort((a, b) => (a.order ?? 0) - (b.order ?? 0))
        setBrands(data)
        setLoading(false)
      },
      () => setLoading(false),
    )
    return unsubscribe
  }, [])

  const confirmDelete = async () => {
    if (!deleteTarget) return
    await deleteDoc(doc(db, 'brands', deleteTarget))
    setDeleteTarget(null)
  }

  return (
    <div className="space-y-6">
      <div className="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
        <div className="flex items-center justify-between px-6 py-5 border-b border-gray-100">
          <h2 className="text-lg font-semibold text-gray-900">
            Brands <span className="ml-1 text-sm font-normal text-gray-400">({brands.length})</span>
          </h2>
          <button
            onClick={() => { setEditBrand(null); setShowForm(true) }}
            className="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-xl text-sm font-semibold transition shadow-sm"
          >
            + Add Brand
          </button>
        </div>

        {loading ? (
          <div className="flex justify-center py-20">
            <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-red-600" />
          </div>
        ) : brands.length === 0 ? (
          <div className="text-center py-20 text-gray-400">
            <p className="text-4xl mb-3">🎸</p>
            <p className="font-medium">No brands yet.</p>
            <p className="text-sm mt-1">Click <strong>+ Add Brand</strong> to get started.</p>
          </div>
        ) : (
          <div className="p-6">
            <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-6 gap-4">
              {brands.map((brand) => (
                <div key={brand.id} className="bg-gray-50 rounded-xl p-4 flex flex-col items-center gap-2 border border-gray-100 hover:border-red-200 transition group">
                  {brand.logoUrl ? (
                    <img
                      src={brand.logoUrl}
                      alt={brand.name}
                      className="w-14 h-14 rounded-full object-contain bg-white p-1 border border-gray-200"
                      onError={(e) => e.target.style.display = 'none'}
                    />
                  ) : (
                    <div className="w-14 h-14 rounded-full bg-gray-200 flex items-center justify-center text-xl">🎸</div>
                  )}
                  <p className="text-sm font-medium text-gray-800 text-center">{brand.name}</p>
                  <p className="font-mono text-xs text-gray-400 bg-gray-200 px-1.5 py-0.5 rounded select-all w-full text-center truncate" title={brand.id}>{brand.id}</p>
                  <p className="text-xs text-gray-400">Order: {brand.order ?? 0}</p>
                  <div className="flex gap-2 opacity-0 group-hover:opacity-100 transition">
                    <button onClick={() => { setEditBrand(brand); setShowForm(true) }} className="text-xs text-blue-600 hover:text-blue-800 font-medium">Edit</button>
                    <button onClick={() => setDeleteTarget(brand.id)} className="text-xs text-red-500 hover:text-red-700 font-medium">Delete</button>
                  </div>
                </div>
              ))}
            </div>
          </div>
        )}
      </div>

      {showForm && <BrandForm brand={editBrand} onClose={() => { setShowForm(false); setEditBrand(null) }} />}

      {deleteTarget && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
          <div className="bg-white rounded-2xl shadow-2xl p-6 w-full max-w-sm">
            <div className="text-center mb-5">
              <span className="text-4xl">🗑️</span>
              <h3 className="text-lg font-semibold text-gray-900 mt-3">Remove Brand?</h3>
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
