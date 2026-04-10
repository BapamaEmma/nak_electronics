import { useState, useEffect } from 'react'
import { collection, onSnapshot, deleteDoc, doc } from 'firebase/firestore'
import { db } from '../firebase'
import ProductForm from './ProductForm'

export default function ProductsTab() {
  const [products, setProducts] = useState([])
  const [loading, setLoading] = useState(true)
  const [showForm, setShowForm] = useState(false)
  const [editProduct, setEditProduct] = useState(null)
  const [search, setSearch] = useState('')
  const [deleteTarget, setDeleteTarget] = useState(null)

  useEffect(() => {
    const unsubscribe = onSnapshot(
      collection(db, 'products'),
      (snap) => {
        setProducts(snap.docs.map((d) => ({ id: d.id, ...d.data() })))
        setLoading(false)
      },
      () => setLoading(false),
    )
    return unsubscribe
  }, [])

  const handleCloseForm = () => {
    setShowForm(false)
    setEditProduct(null)
  }

  const confirmDelete = async () => {
    if (!deleteTarget) return
    await deleteDoc(doc(db, 'products', deleteTarget))
    setDeleteTarget(null)
  }

  const filtered = products.filter(
    (p) =>
      p.name?.toLowerCase().includes(search.toLowerCase()) ||
      p.brand?.toLowerCase().includes(search.toLowerCase()) ||
      p.category?.toLowerCase().includes(search.toLowerCase()),
  )

  const inStock = products.filter((p) =>
    p.availability?.toLowerCase().includes('in stock'),
  ).length
  const outOfStock = products.filter((p) =>
    p.availability?.toLowerCase().includes('out of stock'),
  ).length
  const newArrivals = products.filter((p) => p.isNew).length

  return (
    <div className="space-y-6">
      {/* Stats */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-4">
        {[
          { label: 'Total Products', value: products.length, icon: '📦', color: 'border-blue-200 bg-blue-50' },
          { label: 'In Stock', value: inStock, icon: '✅', color: 'border-green-200 bg-green-50' },
          { label: 'Out of Stock', value: outOfStock, icon: '❌', color: 'border-red-200 bg-red-50' },
          { label: 'New Arrivals', value: newArrivals, icon: '🆕', color: 'border-orange-200 bg-orange-50' },
        ].map((stat) => (
          <div key={stat.label} className={`rounded-xl border p-5 ${stat.color}`}>
            <div className="flex items-center justify-between mb-2">
              <p className="text-sm text-gray-500 font-medium">{stat.label}</p>
              <span className="text-lg">{stat.icon}</span>
            </div>
            <p className="text-3xl font-bold text-gray-900">{stat.value}</p>
          </div>
        ))}
      </div>

      {/* Table */}
      <div className="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
        <div className="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4 px-6 py-5 border-b border-gray-100">
          <h2 className="text-lg font-semibold text-gray-900">
            Products <span className="ml-1 text-sm font-normal text-gray-400">({filtered.length})</span>
          </h2>
          <div className="flex items-center gap-3 w-full sm:w-auto">
            <input
              type="text"
              placeholder="Search by name, brand, category…"
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              className="flex-1 sm:w-64 px-4 py-2 border border-gray-300 rounded-xl text-sm focus:ring-2 focus:ring-red-500 focus:border-transparent outline-none"
            />
            <button
              onClick={() => setShowForm(true)}
              className="shrink-0 bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-xl text-sm font-semibold whitespace-nowrap transition shadow-sm"
            >
              + Add Product
            </button>
          </div>
        </div>

        {loading ? (
          <div className="flex justify-center py-20">
            <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-red-600" />
          </div>
        ) : filtered.length === 0 ? (
          <div className="text-center py-20 text-gray-400">
            <p className="text-4xl mb-3">📭</p>
            <p className="font-medium">{search ? 'No products match your search.' : 'No products yet.'}</p>
          </div>
        ) : (
          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead>
                <tr className="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider bg-gray-50 border-b border-gray-100">
                  <th className="px-6 py-3">ID</th>
                  <th className="px-6 py-3">Product</th>
                  <th className="px-6 py-3">Brand</th>
                  <th className="px-6 py-3">Category</th>
                  <th className="px-6 py-3">Price</th>
                  <th className="px-6 py-3">Stock</th>
                  <th className="px-6 py-3">Availability</th>
                  <th className="px-6 py-3">Actions</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-50">
                {filtered.map((product) => (
                  <tr key={product.id} className="hover:bg-gray-50 transition">
                    <td className="px-6 py-4">
                      <span className="font-mono text-xs text-gray-400 bg-gray-100 px-2 py-1 rounded select-all">{product.id}</span>
                    </td>
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-3">
                        {product.image && (
                          <img
                            src={product.image}
                            alt={product.name}
                            className="w-10 h-10 rounded-lg object-cover bg-gray-100"
                            onError={(e) => e.target.style.display = 'none'}
                          />
                        )}
                        <div>
                          <p className="font-medium text-gray-900">{product.name}</p>
                          <p className="text-xs text-gray-400">{product.type}</p>
                        </div>
                      </div>
                    </td>
                    <td className="px-6 py-4 text-gray-600">{product.brand}</td>
                    <td className="px-6 py-4 text-gray-600">{product.category}</td>
                    <td className="px-6 py-4 font-semibold text-gray-900">
                      ₵{Number(product.price || 0).toFixed(2)}
                      {product.discount > 0 && (
                        <span className="ml-2 text-xs text-orange-500 font-normal">
                          -{Math.round(product.discount * 100)}%
                        </span>
                      )}
                    </td>
                    <td className="px-6 py-4 text-gray-600">{product.stock || '—'}</td>
                    <td className="px-6 py-4">
                      <span className={`inline-flex items-center px-2.5 py-1 rounded-full text-xs font-medium ${
                        product.availability?.toLowerCase().includes('in stock')
                          ? 'bg-green-100 text-green-700'
                          : product.availability?.toLowerCase().includes('low')
                            ? 'bg-yellow-100 text-yellow-700'
                            : 'bg-red-100 text-red-700'
                      }`}>
                        {product.availability || 'Unknown'}
                      </span>
                    </td>
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-3">
                        <button
                          onClick={() => { setEditProduct(product); setShowForm(true) }}
                          className="text-blue-600 hover:text-blue-800 font-medium"
                        >
                          Edit
                        </button>
                        <button
                          onClick={() => setDeleteTarget(product.id)}
                          className="text-red-500 hover:text-red-700 font-medium"
                        >
                          Delete
                        </button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>

      {showForm && <ProductForm product={editProduct} onClose={handleCloseForm} />}

      {deleteTarget && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
          <div className="bg-white rounded-2xl shadow-2xl p-6 w-full max-w-sm">
            <div className="text-center mb-5">
              <span className="text-4xl">🗑️</span>
              <h3 className="text-lg font-semibold text-gray-900 mt-3">Delete Product?</h3>
              <p className="text-gray-500 text-sm mt-1">This will permanently remove the product.</p>
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
