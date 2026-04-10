import { useState } from 'react'
import {
  setDoc,
  updateDoc,
  doc,
  serverTimestamp,
} from 'firebase/firestore'
import { db } from '../firebase'

const CATEGORIES = [
  'Guitars',
  'Amplifiers',
  'Drums',
  'Keyboards',
  'Microphones',
  'Headphones',
  'Monitors',
  'Mixers',
  'Recording',
  'Lighting',
  'PA Systems',
  'Accessories',
  'Other',
]

const AVAILABILITY_OPTIONS = ['In Stock', 'Out of Stock', 'Low Stock']

const emptyForm = {
  id: '',
  name: '',
  brand: '',
  category: 'Guitars',
  type: 'Instrument',
  price: '',
  discount: '',
  availability: 'In Stock',
  stock: '',
  description: '',
  image: '',
  isNew: false,
}

export default function ProductForm({ product, onClose }) {
  const isEdit = !!product
  const [form, setForm] = useState(
    isEdit
      ? {
          id: product.id ?? '',
          name: product.name ?? '',
          brand: product.brand ?? '',
          category: product.category ?? 'Guitars',
          type: product.type ?? 'Instrument',
          price: product.price ?? '',
          discount: product.discount ? (product.discount * 100).toFixed(0) : '',
          availability: product.availability ?? 'In Stock',
          stock: product.stock ?? '',
          description: product.description ?? '',
          image: product.image ?? '',
          isNew: product.isNew ?? false,
        }
      : emptyForm,
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
      setError('Product ID is required.')
      return
    }
    if (!form.name.trim() || !form.brand.trim() || form.price === '') {
      setError('Product name, brand, and price are required.')
      return
    }
    setError('')
    setLoading(true)
    try {
      const payload = {
        name: form.name.trim(),
        brand: form.brand.trim(),
        category: form.category,
        type: form.type,
        price: parseFloat(form.price),
        discount: form.discount !== '' ? parseFloat(form.discount) / 100 : null,
        availability: form.availability,
        stock: form.stock.trim(),
        description: form.description.trim(),
        image: form.image.trim(),
        isNew: form.isNew,
        updatedAt: serverTimestamp(),
      }

      if (isEdit) {
        await updateDoc(doc(db, 'products', product.id), payload)
      } else {
        await setDoc(doc(db, 'products', form.id.trim()), {
          ...payload,
          createdAt: serverTimestamp(),
        })
      }
      onClose()
    } catch (err) {
      console.error(err)
      setError('Failed to save. Please check your connection and try again.')
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-2xl shadow-2xl w-full max-w-2xl max-h-[92vh] flex flex-col">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-5 border-b border-gray-100 shrink-0">
          <h2 className="text-xl font-bold text-gray-900">
            {isEdit ? 'Edit Product' : 'Add New Product'}
          </h2>
          <button
            onClick={onClose}
            className="text-gray-400 hover:text-gray-600 transition text-2xl leading-none"
          >
            ×
          </button>
        </div>

        {/* Scrollable body */}
        <form
          onSubmit={handleSubmit}
          className="overflow-y-auto px-6 py-5 space-y-5 flex-1"
        >
          {error && (
            <div className="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-xl text-sm">
              ⚠️ {error}
            </div>
          )}

          {/* Product ID */}
          <Field label="Product ID *">
            <input
              name="id"
              value={form.id}
              onChange={set}
              required={!isEdit}
              disabled={isEdit}
              placeholder="e.g. fender-strat-sunburst"
              className={`${inputCls} ${isEdit ? 'bg-gray-100 text-gray-400 cursor-not-allowed' : ''}`}
            />
            {!isEdit && <p className="mt-1 text-xs text-gray-400">Unique ID — cannot be changed after saving. Use lowercase letters, numbers, and hyphens.</p>}
          </Field>

          {/* Row 1: Name + Brand */}
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <Field label="Product Name *">
              <input
                name="name"
                value={form.name}
                onChange={set}
                required
                placeholder="e.g. Fender Stratocaster"
                className={inputCls}
              />
            </Field>
            <Field label="Brand *">
              <input
                name="brand"
                value={form.brand}
                onChange={set}
                required
                placeholder="e.g. Fender"
                className={inputCls}
              />
            </Field>
          </div>

          {/* Row 2: Category + Type */}
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <Field label="Category">
              <select name="category" value={form.category} onChange={set} className={inputCls}>
                {CATEGORIES.map((c) => (
                  <option key={c}>{c}</option>
                ))}
              </select>
            </Field>
            <Field label="Type">
              <select name="type" value={form.type} onChange={set} className={inputCls}>
                <option>Instrument</option>
                <option>Accessory</option>
              </select>
            </Field>
          </div>

          {/* Row 3: Price + Discount */}
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <Field label="Price (₵) *">
              <input
                name="price"
                type="number"
                min="0"
                step="0.01"
                value={form.price}
                onChange={set}
                required
                placeholder="0.00"
                className={inputCls}
              />
            </Field>
            <Field label="Discount (%) — optional">
              <input
                name="discount"
                type="number"
                min="0"
                max="99"
                step="1"
                value={form.discount}
                onChange={set}
                placeholder="e.g. 10 for 10% off"
                className={inputCls}
              />
            </Field>
          </div>

          {/* Row 4: Availability + Stock qty */}
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <Field label="Availability">
              <select
                name="availability"
                value={form.availability}
                onChange={set}
                className={inputCls}
              >
                {AVAILABILITY_OPTIONS.map((a) => (
                  <option key={a}>{a}</option>
                ))}
              </select>
            </Field>
            <Field label="Stock Quantity">
              <input
                name="stock"
                value={form.stock}
                onChange={set}
                placeholder="e.g. 25"
                className={inputCls}
              />
            </Field>
          </div>

          {/* Image URL */}
          <Field label="Image URL — optional">
            <input
              name="image"
              type="url"
              value={form.image}
              onChange={set}
              placeholder="https://..."
              className={inputCls}
            />
          </Field>

          {/* Description */}
          <Field label="Description">
            <textarea
              name="description"
              value={form.description}
              onChange={set}
              rows={3}
              placeholder="Brief product description…"
              className={`${inputCls} resize-none`}
            />
          </Field>

          {/* New arrival toggle */}
          <label className="flex items-center gap-3 cursor-pointer select-none">
            <div className="relative">
              <input
                name="isNew"
                type="checkbox"
                checked={form.isNew}
                onChange={set}
                className="sr-only"
              />
              <div
                className={`w-10 h-6 rounded-full transition ${form.isNew ? 'bg-red-600' : 'bg-gray-300'}`}
              />
              <div
                className={`absolute top-1 left-1 w-4 h-4 bg-white rounded-full shadow transition-transform ${form.isNew ? 'translate-x-4' : ''}`}
              />
            </div>
            <span className="text-sm font-medium text-gray-700">Mark as New Arrival</span>
          </label>
        </form>

        {/* Footer */}
        <div className="flex gap-3 px-6 py-5 border-t border-gray-100 shrink-0">
          <button
            type="button"
            onClick={onClose}
            className="flex-1 border border-gray-300 text-gray-700 py-2.5 rounded-xl text-sm font-medium hover:bg-gray-50 transition"
          >
            Cancel
          </button>
          <button
            onClick={handleSubmit}
            disabled={loading}
            className="flex-1 bg-red-600 hover:bg-red-700 disabled:bg-red-400 text-white py-2.5 rounded-xl text-sm font-semibold transition"
          >
            {loading ? 'Saving…' : isEdit ? 'Update Product' : 'Add Product'}
          </button>
        </div>
      </div>
    </div>
  )
}

// ── Helpers ──────────────────────────────────────────────────────────────────
const inputCls =
  'w-full px-3.5 py-2.5 border border-gray-300 rounded-xl text-sm focus:ring-2 focus:ring-red-500 focus:border-transparent outline-none bg-white transition'

function Field({ label, children }) {
  return (
    <div>
      <label className="block text-sm font-medium text-gray-700 mb-1.5">{label}</label>
      {children}
    </div>
  )
}
