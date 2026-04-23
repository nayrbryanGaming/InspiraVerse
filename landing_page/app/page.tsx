import React from 'react';
import Image from 'next/image';
import Link from 'next/link';

export const metadata = {
  title: 'InspiraVerse | Elite Daily Mindfulness & Resilience',
  description: 'Fuel your daily evolution with curated psychological insights and premium mindfulness tools designed for long-term mental resilience.',
};

export default function LandingPage() {
  return (
    <div className="min-h-screen bg-[#FDFCFE] text-[#1A1523] selection:bg-[#7C3AED] selection:text-white font-[family-name:var(--font-outfit)]">
      {/* Navigation */}
      <nav className="fixed top-0 w-full z-50 bg-white/70 backdrop-blur-xl border-b border-gray-100">
        <div className="max-w-7xl mx-auto px-6 sm:px-8 lg:px-10">
          <div className="flex justify-between h-20 items-center">
            <div className="flex items-center gap-4 group cursor-pointer">
              <div className="w-10 h-10 relative overflow-hidden rounded-xl shadow-lg group-hover:rotate-6 transition-all duration-500">
                <div className="absolute inset-0 bg-gradient-to-tr from-[#6366F1] via-[#A855F7] to-[#EC4899] opacity-90"></div>
                <div className="absolute inset-0 flex items-center justify-center text-white font-black">I</div>
              </div>
              <span className="text-xl font-black tracking-tighter text-[#1A1523] group-hover:text-[#A855F7] transition-colors">InspiraVerse</span>
            </div>
            <div className="hidden md:flex items-center gap-10 text-sm font-bold text-gray-500 uppercase tracking-widest">
              <Link href="#features" className="hover:text-[#A855F7] transition-colors">Experience</Link>
              <Link href="#transparency" className="hover:text-[#A855F7] transition-colors">Sovereignty</Link>
              <Link href="#download" className="bg-[#1A1523] text-white px-7 py-3 rounded-full hover:shadow-2xl hover:-translate-y-0.5 transition-all active:scale-95">Deploy App</Link>
            </div>
          </div>
        </div>
      </nav>

      {/* Hero Section */}
      <section className="pt-40 pb-32 overflow-hidden relative">
        <div className="absolute top-0 left-1/2 -translate-x-1/2 w-[120%] h-[120%] bg-[radial-gradient(circle_at_center,_var(--tw-gradient-stops))] from-violet-100/40 via-transparent to-transparent -z-10"></div>
        
        <div className="max-w-7xl mx-auto px-6 sm:px-8 lg:px-10">
          <div className="lg:grid lg:grid-cols-2 lg:gap-20 items-center">
            <div className="mb-20 lg:mb-0">
              <div className="inline-flex items-center gap-3 px-4 py-1.5 rounded-full bg-gradient-to-r from-violet-50 to-fuchsia-50 border border-violet-100 text-violet-600 text-[10px] font-black uppercase tracking-[0.2em] mb-8">
                <span className="relative flex h-2 w-2">
                  <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-violet-400 opacity-75"></span>
                  <span className="relative inline-flex rounded-full h-2 w-2 bg-violet-500"></span>
                </span>
                Production Version 1.2 Released
              </div>
              <h1 className="text-6xl lg:text-[5.5rem] font-black leading-[1.05] mb-8 tracking-[-0.04em] text-[#1A1523]">
                Daily quotes <br/>for the <span className="text-transparent bg-clip-text bg-gradient-to-r from-[#6366F1] via-[#A855F7] to-[#EC4899]">modern mind.</span>
              </h1>
              <p className="text-xl text-gray-500 mb-12 leading-relaxed max-w-xl font-medium">
                Elevate your consciousness with psychological precision. Curated insights meet premium craftsmanship to build unshakeable mental resilience.
              </p>
              <div id="download" className="flex flex-col sm:flex-row gap-5">
                <button className="bg-[#1A1523] text-white px-10 py-5 rounded-2xl font-bold text-lg hover:shadow-[0_20px_50px_rgba(26,21,35,0.2)] transition-all active:scale-95 flex items-center justify-center gap-4">
                  <svg className="w-6 h-6" viewBox="0 0 24 24" fill="currentColor"><path d="M17.525 18.06c-.443.048-.903.072-1.378.072-1.157 0-2.008-.13-2.541-.39-.533-.26-1.026-.7-1.479-1.319l-4.116-5.694c-.453-.625-.946-1.068-1.479-1.328-.533-.26-1.384-.39-2.541-.39-.475 0-.935.024-1.378.072V4.414c0-.78.632-1.414 1.414-1.414h10.5c.78 0 1.414.634 1.414 1.414v13.646zm-2.574-13.646h-10.5v13.646c0 .78.634 1.414 1.414 1.414h10.5c.78 0 1.414-.634 1.414-1.414V4.414c0-.78-.634-1.414-1.414-1.414z" /></svg>
                  App Store
                </button>
                <button className="bg-white border-2 border-gray-100 text-[#1A1523] px-10 py-5 rounded-2xl font-bold text-lg hover:border-[#A855F7]/30 hover:bg-violet-50/30 transition-all active:scale-95 flex items-center justify-center gap-4">
                  <svg className="w-6 h-6" viewBox="0 0 24 24" fill="currentColor"><path d="M5 3.5c0-.8.7-1.5 1.5-1.5h11c.8 0 1.5.7 1.5 1.5v17c0 .8-.7 1.5-1.5 1.5h-11c-.8 0-1.5-.7-1.5-1.5v-17zm1.5-1h11c.3 0 .5.2.5.5v17c0 .3-.2.5-.5.5h-11c-.3 0-.5-.2-.5-.5v-17c0-.3.2-.5.5-.5zM12 18.5c.6 0 1 .4 1 1s-.4 1-1 1-1-.4-1-1 .4-1 1-1z" /></svg>
                  Google Play
                </button>
              </div>
            </div>
            <div className="relative group">
              <div className="absolute -inset-10 bg-gradient-to-tr from-[#6366F1]/20 via-[#A855F7]/20 to-[#EC4899]/20 blur-[80px] rounded-full group-hover:scale-110 transition-transform duration-1000"></div>
              <div className="relative transform lg:rotate-[12deg] group-hover:rotate-[8deg] transition-all duration-700">
                <div className="absolute -inset-1 bg-gradient-to-tr from-[#6366F1] to-[#EC4899] rounded-[3.5rem] blur opacity-20 group-hover:opacity-40 transition-opacity"></div>
                <Image 
                  src="/inspiraverse_app_mockup_1776010881927.png" 
                  alt="InspiraVerse Mobile Interface" 
                  width={420} 
                  height={860} 
                  className="rounded-[3.2rem] shadow-[0_50px_100px_-20px_rgba(26,21,35,0.3)] border-[12px] border-[#0F172A] mx-auto bg-[#0F172A]"
                />
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Transparency Section */}
      <section id="transparency" className="py-32 bg-white">
        <div className="max-w-7xl mx-auto px-6 sm:px-8 lg:px-10">
          <div className="max-w-3xl mb-24">
            <h2 className="text-4xl md:text-5xl font-black mb-8 tracking-tight">Radical Transparency. <br/><span className="text-gray-300">Absolute Sovereignty.</span></h2>
            <p className="text-xl text-gray-500 leading-relaxed font-medium">
              Your psychological journey belongs to you. We implement the world's most rigorous data safety standards to ensure your focus remains inward.
            </p>
          </div>

          <div className="grid lg:grid-cols-12 gap-10">
            <div className="lg:col-span-7 grid sm:grid-cols-2 gap-8">
              {[
                { title: 'AES-256 Vault', desc: 'Industry-standard encryption for every journal entry and reflection.', icon: '🔒' },
                { title: 'Zero Tracking', desc: 'No profiling. No diagnostic selling. No third-party reporting.', icon: '🛡️' },
                { title: 'Local-First', desc: 'Data is processed on-device first for maximum privacy.', icon: '📲' },
                { title: 'Verified Deletion', desc: 'Permanent server-side purge on request. No ghost data.', icon: '🗑️' }
              ].map((feature, i) => (
                <div key={i} className="p-10 rounded-[2.5rem] bg-[#FDFCFE] border border-gray-100 hover:border-violet-200 hover:shadow-xl transition-all group">
                  <div className="text-3xl mb-6 group-hover:scale-110 transition-transform inline-block">{feature.icon}</div>
                  <h4 className="text-xl font-bold mb-4">{feature.title}</h4>
                  <p className="text-gray-500 text-sm leading-relaxed">{feature.desc}</p>
                </div>
              ))}
            </div>
            
            <div className="lg:col-span-5 p-12 rounded-[3rem] bg-[#1A1523] text-white relative overflow-hidden group">
              <div className="absolute top-0 right-0 w-64 h-64 bg-gradient-to-br from-[#A855F7]/20 to-transparent blur-3xl -mr-20 -mt-20"></div>
              <div className="relative z-10">
                <div className="w-16 h-16 rounded-2xl bg-white/10 flex items-center justify-center mb-8 text-2xl">⚡</div>
                <h3 className="text-2xl font-bold mb-6 italic">The Right to be Forgotten.</h3>
                <p className="text-gray-400 mb-10 leading-relaxed font-medium">
                  We honor the Google Play Data Safety requirement for simplified account deletion. You have full recursive control over your digital footprint.
                </p>
                <Link href="/legal/delete-request" className="inline-flex items-center gap-3 text-violet-400 font-bold hover:text-violet-300 transition-colors group/link">
                  Execution Instructions
                  <svg className="w-5 h-5 group-hover/link:translate-x-2 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M17 8l4 4m0 0l-4 4m4-4H3"></path></svg>
                </Link>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer className="py-20 bg-[#FDFCFE] border-t border-gray-100">
        <div className="max-w-7xl mx-auto px-6 sm:px-8 lg:px-10">
          <div className="flex flex-col md:flex-row justify-between items-start md:items-center gap-12">
            <div>
              <div className="flex items-center gap-3 mb-6">
                <div className="w-8 h-8 rounded-lg bg-gradient-to-tr from-[#6366F1] to-[#EC4899] flex items-center justify-center text-white font-black text-xs shadow-lg">I</div>
                <span className="text-xl font-black tracking-tighter">InspiraVerse</span>
              </div>
              <p className="text-sm text-gray-400 max-w-xs font-medium">Crafting the future of psychological resilience through premium curated wisdom.</p>
            </div>
            
            <div className="flex flex-wrap gap-x-12 gap-y-6 text-sm font-bold text-gray-400 uppercase tracking-widest">
              <Link href="/legal/privacy" className="hover:text-[#A855F7] transition-colors">Privacy Policy</Link>
              <Link href="/legal/terms" className="hover:text-[#A855F7] transition-colors">Terms of Service</Link>
              <Link href="/legal/delete-request" className="text-[#EC4899] hover:text-[#D946EF] transition-colors">Data Deletion Request</Link>
            </div>
          </div>
          <div className="mt-20 pt-10 border-t border-gray-100 flex flex-col md:flex-row justify-between gap-6">
            <p className="text-xs text-gray-400 font-medium">© 2026 InspiraVerse Labs. Engineered for the modern mind.</p>
            <div className="flex gap-4">
              <div className="w-2 h-2 rounded-full bg-green-500 animate-pulse"></div>
              <span className="text-[10px] font-black text-gray-400 uppercase tracking-[0.2em]">Systems Operational</span>
            </div>
          </div>
        </div>
      </footer>
    </div>
  );
}
