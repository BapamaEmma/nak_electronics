import { useState } from 'react'
import { setDoc, updateDoc, doc, serverTimestamp } from 'firebase/firestore'
import { db } from '../firebase'

const empty = {
  id: '', name: '', price: '', originalPrice: '', imageUrl: '',
  rating: '', reviewCount: '', isBestSeller: false, order: '0',
}

export default function FeaturedForm({ item, onClose }) {
  const isEdit = !!item
  const [form, setForm] = useState(
    isEdit
      ? { id: item.id ?? '', name: item.name ?? '', price: item.price ?? '', originalPrice: item.originalPrice ?? '',
          imageUrl: item.imageUrl ?? '', rating: item.rating ?? '', reviewCount: item.reviewCount ?? '',
          isBestSeller: item.isBestSeller ?? false, order: item.order ?? '0' }
      : empty,
  )
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')

  const set = (e) => {
    const { name, value, type, checked } = e.target
    setForm((prev) => ({ ...prev, [name]: type === 'checkbox' ? checked : value }))
  }

  const handleSubmit = async (e) => {
    e.preventDefault()
    if (!isEdit && !form.id.trim()) {
      setError('ID is required.')
      return
    }
    if (!form.name.trim() || form.price === '') {
      setError('Name and price are required.')
      return
    }
    setError('')
    setLoading(true)
    try {
      const payload = {
        name: form.name.trim(),
        price: parseFloat(form.price),
        originalPrice: parseFloat(form.originalPrice) || parseFloat(form.price),
        imageUrl: form.imageUrl.trim(),
        rating: parseFloat(form.rating) || 0,
        reviewCount: parseInt(form.reviewCount) || 0,
        isBestSeller: form.isBestSeller,
        order: parseInt(form.order) || 0,
        updatedAt: serverTimestamp(),
      }
      if (isEdit) {
        await updateDoc(doc(db, 'featured_products', item.id), payload)
      } else {
        await setDoc(doc(db, 'featured_products', form.id.trim()), { ...payload, createdAt: serverTimestamp() })
      }
      onClose()
    } catch {
      setError('Failed to save. Please try again.')
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-2xl shadow-2xl w-full max-w-lg max-h-[90vh] flex flex-col">
        <div className="flex items-center justify-between px-6 py-5 border-b border-gray-100 shrink-0">
          <h2 className="text-xl font-bold text-gray-900">{isEdit ? 'Edit Featured Product' : 'Add Featured Product'}</h2>
          <button onClick={onClose} className="text-gray-400 hover:text-gray-600 text-2xl leading-none">×</button>
        </div>

        <form onSubmit={handleSubmit} className="overflow-y-auto px-6 py-5 space-y-4 flex-1">
          {error && <div className="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-xl text-sm">⚠️ {error}</div>}

          <Field label="Product ID *">
            <input name="id" value={form.id} onChange={set} required={!isEdit} disabled={isEdit} placeholder="e.g. studio-headphones-pro" className={`${inp} ${isEdit ? 'bg-gray-100 text-gray-400 cursor-not-allowed' : ''}`} />
            {!isEdit && <p className="mt-1 text-xs text-gray-400">Unique ID — cannot be changed after saving.</p>}
          </Field>

          <Field label="Product Name *">
            <input name="name" value={form.name} onChange={set} required placeholder="e.g. Pro Studio Headphones" className={inp} />
          </Field>

          <div className="grid grid-cols-2 gap-4">
            <Field label="Sale Price (₵) *">
              <input name="price" type="number" min="0" step="0.01" value={form.price} onChange={set} required placeholder="0.00" className={inp} />
            </Field>
            <Field label="Original Price (₵)">
              <input name="originalPrice" type="number" min="0" step="0.01" value={form.originalPrice} onChange={set} placeholder="0.00" className={inp} />
            </Field>
          </div>

          <div className="grid grid-cols-2 gap-4">
            <Field label="Rating (0–5)">
              <input name="rating" type="number" min="0" max="5" step="0.1" value={form.rating} onChange={set} placeholder="4.8" className={inp} />
            </Field>
            <Field label="Review Count">
              <input name="reviewCount" type="number" min="0" value={form.reviewCount} onChange={set} placeholder="124" className={inp} />
            </Field>
          </div>

          <Field label="Image URL">
            <input name="imageUrl" type="url" value={form.imageUrl} onChange={set} placeholder="https://..." className={inp} />
          </Field>

          <Field label="Display Order (lower = first)">
            <input name="order" type="number" min="0" value={form.order} onChange={set} className={inp} />
          </Field>

          <label className="flex items-center gap-3 cursor-pointer select-none">
            <div className="relative">
              <input name="isBestSeller" type="checkbox" checked={form.isBestSeller} onChange={set} className="sr-only" />
              <div className={`w-10 h-6 rounded-full transition ${form.isBestSeller ? 'bg-red-600' : 'bg-gray-300'}`} />
              <div className={`absolute top-1 left-1 w-4 h-4 bg-white rounded-full shadow transition-transform ${form.isBestSeller ? 'translate-x-4' : ''}`} />
            </div>
            <span className="text-sm font-medium text-gray-700">Mark as Best Seller</span>
          </label>
        </form>

        <div className="flex gap-3 px-6 py-5 border-t border-gray-100 shrink-0">
          <button type="button" onClick={onClose} className="flex-1 border border-gray-300 text-gray-700 py-2.5 rounded-xl text-sm font-medium hover:bg-gray-50 transition">Cancel</button>
          <button onClick={handleSubmit} disabled={loading} className="flex-1 bg-red-600 hover:bg-red-700 disabled:bg-red-400 text-white py-2.5 rounded-xl text-sm font-semibold transition">
            {loading ? 'Saving…' : isEdit ? 'Update' : 'Add Featured'}
          </button>
        </div>
      </div>
    </div>
  )
}

const inp = 'w-full px-3.5 py-2.5 border border-gray-300 rounded-xl text-sm focus:ring-2 focus:ring-red-500 focus:border-transparent outline-none bg-white transition'
function Field({ label, children }) {
  return (
    <div>
      <label className="block text-sm font-medium text-gray-700 mb-1.5">{label}</label>
      {children}
    </div>
  )
}
