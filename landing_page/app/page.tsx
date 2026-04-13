import React from 'react';
import Image from 'next/image';
import Link from 'next/link';

export default function LandingPage() {
  return (
    <div className="min-h-screen bg-[#F9FAFB] text-[#0F172A] selection:bg-[#6C63FF] selection:text-white">
      {/* Navigation */}
      <nav className="fixed top-0 w-full z-50 bg-white/80 backdrop-blur-md border-b border-gray-100">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between h-20 items-center">
            <div className="flex items-center gap-2">
              <div className="w-10 h-10 bg-[#6C63FF] rounded-xl flex items-center justify-center text-white font-bold text-xl">
                I
              </div>
              <span className="text-2xl font-bold tracking-tight text-[#0F172A]">InspiraVerse</span>
            </div>
            <div className="hidden md:flex items-center gap-8 text-sm font-medium text-gray-600">
              <Link href="#features" className="hover:text-[#6C63FF] transition-colors">Features</Link>
              <Link href="#testimonials" className="hover:text-[#6C63FF] transition-colors">Testimonials</Link>
              <Link href="#download" className="bg-[#6C63FF] text-white px-6 py-2.5 rounded-full hover:shadow-lg transition-all active:scale-95">Download Now</Link>
            </div>
          </div>
        </div>
      </nav>

      {/* Hero Section */}
      <section className="pt-32 pb-20 overflow-hidden">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="lg:grid lg:grid-cols-2 lg:gap-12 items-center">
            <div className="mb-12 lg:mb-0">
              <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-[#6C63FF]/10 text-[#6C63FF] text-xs font-bold uppercase tracking-wider mb-6">
                <span className="relative flex h-2 w-2">
                  <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-[#6C63FF] opacity-75"></span>
                  <span className="relative inline-flex rounded-full h-2 w-2 bg-[#6C63FF]"></span>
                </span>
                Now available for Early Access
              </div>
              <h1 className="text-5xl lg:text-7xl font-bold leading-[1.1] mb-6 tracking-tight">
                Daily quotes that fuel your <span className="text-[#6C63FF]">mindset.</span>
              </h1>
              <p className="text-xl text-gray-500 mb-10 leading-relaxed max-w-xl">
                Elevate your daily routine with curated psychological insights and elite-grade tools designed to build long-term mental resilience and focus.
              </p>
              <div id="download" className="flex flex-col sm:flex-row gap-4">
                <button className="bg-[#0F172A] text-white px-8 py-4 rounded-full font-bold text-lg hover:shadow-xl transition-all active:scale-95 flex items-center justify-center gap-3">
                  <svg className="w-6 h-6" viewBox="0 0 24 24" fill="currentColor"><path d="M17.525 18.06c-.443.048-.903.072-1.378.072-1.157 0-2.008-.13-2.541-.39-.533-.26-1.026-.7-1.479-1.319l-4.116-5.694c-.453-.625-.946-1.068-1.479-1.328-.533-.26-1.384-.39-2.541-.39-.475 0-.935.024-1.378.072V4.414c0-.78.632-1.414 1.414-1.414h10.5c.78 0 1.414.634 1.414 1.414v13.646zm-2.574-13.646h-10.5v13.646c0 .78.634 1.414 1.414 1.414h10.5c.78 0 1.414-.634 1.414-1.414V4.414c0-.78-.634-1.414-1.414-1.414z" /></svg>
                  App Store
                </button>
                <button className="bg-white border-2 border-gray-100 px-8 py-4 rounded-full font-bold text-lg hover:border-[#6C63FF] transition-all active:scale-95 flex items-center justify-center gap-3">
                  <svg className="w-6 h-6" viewBox="0 0 24 24" fill="currentColor"><path d="M5 3.5c0-.8.7-1.5 1.5-1.5h11c.8 0 1.5.7 1.5 1.5v17c0 .8-.7 1.5-1.5 1.5h-11c-.8 0-1.5-.7-1.5-1.5v-17zm1.5-1h11c.3 0 .5.2.5.5v17c0 .3-.2.5-.5.5h-11c-.3 0-.5-.2-.5-.5v-17c0-.3.2-.5.5-.5zM12 18.5c.6 0 1 .4 1 1s-.4 1-1 1-1-.4-1-1 .4-1 1-1z" /></svg>
                  Google Play
                </button>
              </div>
            </div>
            <div className="relative">
              <div className="absolute -inset-4 bg-gradient-to-tr from-[#6C63FF]/20 to-transparent blur-3xl rounded-full"></div>
              <div className="relative transform lg:rotate-6 scale-110">
                <Image 
                  src="/inspiraverse_app_mockup_1776010881927.png" 
                  alt="InspiraVerse App Mockup" 
                  width={500} 
                  height={1000} 
                  className="rounded-[3rem] shadow-2xl border-8 border-gray-900 mx-auto"
                />
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Features Section */}
      <section id="features" className="py-24 bg-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-16">
            <h2 className="text-4xl font-bold mb-4">Engineered for Mental Resilience</h2>
            <p className="text-gray-500 max-w-2xl mx-auto">InspiraVerse isn&apos;t just another quote app. We combine psychology with elite design.</p>
          </div>
          <div className="grid md:grid-cols-3 gap-12">
            {[
              {
                title: 'Zen Feed',
                description: 'A distraction-free, vertical scrolling environment optimized for deep reading.',
                icon: '✨'
              },
              {
                title: 'Designer Studio',
                description: 'Generate viral, aesthetic share cards with premium typography and gradients.',
                icon: '🎨'
              },
              {
                title: 'Mindset Analytics',
                description: 'Track your growth over time with streak counters and resilience heatmaps.',
                icon: '📈'
              }
            ].map((f, i) => (
              <div key={i} className="p-8 rounded-3xl bg-[#F9FAFB] hover:shadow-xl transition-all group">
                <div className="text-4xl mb-6 group-hover:scale-125 transition-transform inline-block">{f.icon}</div>
                <h3 className="text-xl font-bold mb-3">{f.title}</h3>
                <p className="text-gray-500 leading-relaxed">{f.description}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer className="py-12 bg-[#0F172A] text-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex flex-col md:flex-row justify-between items-center gap-8">
            <div className="flex items-center gap-2">
              <div className="w-8 h-8 bg-[#6C63FF] rounded-lg flex items-center justify-center font-bold">I</div>
              <span className="text-xl font-bold">InspiraVerse</span>
            </div>
            <div className="flex gap-8 text-sm text-gray-400">
              <Link href="/legal/privacy" className="hover:text-white transition-colors">Privacy Policy</Link>
              <Link href="/legal/terms" className="hover:text-white transition-colors">Terms of Service</Link>
              <Link href="/legal/delete-request" className="hover:text-[#FFB84D] transition-colors font-semibold">Data Deletion Request</Link>
            </div>
            <div className="text-sm text-gray-500">
              © 2026 InspiraVerse Labs. All rights reserved.
            </div>
          </div>
        </div>
      </footer>
    </div>
  );
}
