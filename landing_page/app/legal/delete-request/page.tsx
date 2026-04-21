import React from 'react';
import Link from 'next/link';

export default function DeleteRequest() {
  return (
    <div className="min-h-screen bg-[#FDFCFE] text-[#1A1523] py-24 px-6 sm:px-8 lg:px-10 font-[family-name:var(--font-outfit)]">
      <div className="max-w-4xl mx-auto bg-white p-12 md:p-20 rounded-[3rem] shadow-[0_50px_100px_-20px_rgba(26,21,35,0.1)] border border-gray-100 flex flex-col items-center">
        <Link href="/" className="inline-flex items-center text-violet-600 font-bold mb-12 hover:-translate-x-2 transition-transform group">
          <svg className="w-5 h-5 mr-3 group-hover:scale-125 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="3" d="M15 19l-7-7 7-7"></path></svg>
          Back to Sanctuary
        </Link>
        
        <div className="w-full">
          <h1 className="text-4xl md:text-6xl font-black mb-6 tracking-tighter text-center">Right to be Forgotten</h1>
          <p className="text-gray-400 text-sm mb-16 font-bold uppercase tracking-widest text-center">Google Play Compliance Portal</p>

          <div className="space-y-12 text-gray-600 leading-relaxed font-medium">
            <section className="bg-red-50/50 p-10 rounded-[2.5rem] border border-red-100">
              <h2 className="text-2xl font-black text-red-600 mb-6 flex items-center gap-4">
                Critical Sovereignty
              </h2>
              <p className="text-red-700/80 mb-6 font-bold leading-relaxed">
                In absolute compliance with Google Play Store Data Safety policies, InspiraVerse provides a recursive data purge mechanism. This action is irreversible and wipes your entire digital footprint on our systems.
              </p>
            </section>
            
            <section>
              <h2 className="text-2xl font-black text-[#1A1523] mb-8 flex items-center gap-4">
                <span className="w-8 h-8 rounded-lg bg-violet-100 text-violet-600 flex items-center justify-center text-sm italic">01</span>
                Execution Methods
              </h2>
              <div className="grid md:grid-cols-2 gap-8">
                <div className="p-8 rounded-[2rem] border border-gray-100 bg-gray-50/30">
                  <h3 className="text-lg font-bold mb-4">In-App Mechanism</h3>
                  <p className="text-sm text-gray-500 mb-6">Open the app, navigate to <strong>Profile &gt; Privacy &amp; Data Hub &gt; Request Account Deletion</strong>. This triggers an immediate server-side script.</p>
                  <div className="px-4 py-2 rounded-xl bg-violet-600 text-white text-[10px] font-black uppercase tracking-widest text-center shadow-lg">Recommended</div>
                </div>
                <div className="p-8 rounded-[2rem] border border-gray-100 bg-gray-50/30">
                  <h3 className="text-lg font-bold mb-4">Verified Web Submission</h3>
                  <p className="text-sm text-gray-500 mb-6">If the app is uninstalled, contact our Sovereignty Officer at <strong>privacy@inspiraverse.app</strong> from your registered email address.</p>
                  <div className="px-4 py-2 rounded-xl border-2 border-gray-200 text-gray-400 text-[10px] font-black uppercase tracking-widest text-center">Verification Required</div>
                </div>
              </div>
            </section>

            <section>
              <h2 className="text-2xl font-black text-[#1A1523] mb-6 flex items-center gap-4">
                <span className="w-8 h-8 rounded-lg bg-violet-100 text-violet-600 flex items-center justify-center text-sm italic">02</span>
                Purge Scope
              </h2>
              <p className="mb-6">The following data clusters are permanently destroyed upon execution:</p>
              <div className="flex flex-wrap gap-4">
                {['Authentication ID', 'Journal Archives', 'Mood History', 'Curation Preferences', 'Telemetry Logs'].map((item, i) => (
                  <span key={i} className="px-5 py-2.5 rounded-full bg-gray-50 text-[#1A1523] font-bold text-xs border border-gray-100">{item}</span>
                ))}
              </div>
            </section>
          </div>
          
          <div className="mt-20 pt-10 border-t border-gray-100 text-center">
            <p className="text-gray-400 text-xs font-bold uppercase tracking-tighter">© 2026 InspiraVerse Labs. All rights reserved.</p>
          </div>
        </div>
      </div>
    </div>
  );
}
