import { useState } from 'react'
import { setDoc, updateDoc, doc, serverTimestamp } from 'firebase/firestore'
import { db } from '../firebase'

export default function BrandForm({ brand, onClose }) {
  const isEdit = !!brand

  const [form, setForm] = useState({
    id: brand?.id ?? '',
    name: brand?.name ?? '',
    logoUrl: brand?.logoUrl ?? '',
    order: brand?.order ?? 0,
  })
  const [saving, setSaving] = useState(false)
  const [error, setError] = useState('')

  const set = (key, val) => setForm((prev) => ({ ...prev, [key]: val }))

  const handleSubmit = async (e) => {
    e.preventDefault()
    setError('')
    if (!isEdit && !form.id.trim()) { setError('Brand ID is required.'); return }
    if (!form.name.trim()) { setError('Brand name is required.'); return }

    setSaving(true)
    try {
      const payload = {
        name: form.name.trim(),
        logoUrl: form.logoUrl.trim(),
        order: Number(form.order),
        updatedAt: serverTimestamp(),
      }

      if (isEdit) {
        await updateDoc(doc(db, 'brands', brand.id), payload)
      } else {
        await setDoc(doc(db, 'brands', form.id.trim()), { ...payload, createdAt: serverTimestamp() })
      }
      onClose()
    } catch (err) {
      setError(err.message)
    } finally {
      setSaving(false)
    }
  }

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-2xl shadow-2xl w-full max-w-md overflow-y-auto max-h-[90vh]">
        <div className="px-6 py-5 border-b border-gray-100 flex items-center justify-between">
          <h2 className="text-lg font-semibold text-gray-900">{isEdit ? 'Edit Brand' : 'Add Brand'}</h2>
          <button onClick={onClose} className="text-gray-400 hover:text-gray-600 transition text-xl leading-none">×</button>
        </div>

        <form onSubmit={handleSubmit} className="p-6 space-y-4">
          {error && (
            <div className="bg-red-50 border border-red-200 text-red-700 rounded-xl px-4 py-3 text-sm">{error}</div>
          )}

          {/* ID */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Brand ID *</label>
            <input
              type="text"
              className={`w-full border border-gray-300 rounded-xl px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-red-500 ${isEdit ? 'bg-gray-100 text-gray-400 cursor-not-allowed' : ''}`}
              value={form.id}
              onChange={(e) => set('id', e.target.value)}
              placeholder="e.g. gibson"
              disabled={isEdit}
              required={!isEdit}
            />
            {!isEdit && <p className="mt-1 text-xs text-gray-400">Unique ID — cannot be changed after saving.</p>}
          </div>

          {/* Name */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Brand Name *</label>
            <input
              type="text"
              className="w-full border border-gray-300 rounded-xl px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-red-500"
              value={form.name}
              onChange={(e) => set('name', e.target.value)}
              placeholder="e.g. Gibson"
              required
            />
          </div>

          {/* Logo URL */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Logo URL</label>
            <input
              type="url"
              className="w-full border border-gray-300 rounded-xl px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-red-500"
              value={form.logoUrl}
              onChange={(e) => set('logoUrl', e.target.value)}
              placeholder="https://..."
            />
            {form.logoUrl && (
              <div className="mt-2 flex items-center gap-3 bg-gray-50 rounded-xl px-3 py-2 border border-gray-100">
                <img
                  src={form.logoUrl}
                  alt="Logo preview"
                  className="w-10 h-10 rounded-full object-contain bg-white p-1 border border-gray-200"
                  onError={(e) => e.target.style.display = 'none'}
                />
                <span className="text-xs text-gray-500 truncate">Logo preview</span>
              </div>
            )}
          </div>

          {/* Order */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Display Order</label>
            <input
              type="number"
              className="w-full border border-gray-300 rounded-xl px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-red-500"
              value={form.order}
              onChange={(e) => set('order', e.target.value)}
              min="0"
            />
            <p className="mt-1 text-xs text-gray-400">Lower number = appears first</p>
          </div>

          <div className="flex gap-3 pt-2">
            <button type="button" onClick={onClose} className="flex-1 border border-gray-300 text-gray-700 py-2.5 rounded-xl text-sm font-medium hover:bg-gray-50 transition">Cancel</button>
            <button
              type="submit"
              disabled={saving}
              className="flex-1 bg-red-600 hover:bg-red-700 disabled:bg-red-400 text-white py-2.5 rounded-xl text-sm font-semibold transition"
            >
              {saving ? 'Saving…' : isEdit ? 'Save Changes' : 'Add Brand'}
            </button>
          </div>
        </form>
      </div>
    </div>
  )
}
