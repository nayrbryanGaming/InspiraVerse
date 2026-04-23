import React from 'react';
import Link from 'next/link';

export default function DataUsagePolicy() {
  return (
    <div className="min-h-screen bg-[#FDFCFE] text-[#1A1523] py-24 px-6 sm:px-8 lg:px-10 font-[family-name:var(--font-outfit)]">
      <div className="max-w-4xl mx-auto bg-white p-12 md:p-20 rounded-[3rem] shadow-[0_50px_100px_-20px_rgba(26,21,35,0.1)] border border-gray-100 flex flex-col items-center">
        <Link href="/" className="inline-flex items-center text-violet-600 font-bold mb-12 hover:-translate-x-2 transition-transform group">
          <svg className="w-5 h-5 mr-3 group-hover:scale-125 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="3" d="M15 19l-7-7 7-7"></path></svg>
          Back to Sanctuary
        </Link>
        
        <div className="w-full">
          <h1 className="text-4xl md:text-6xl font-black mb-6 tracking-tighter text-center">Data Usage</h1>
          <p className="text-gray-400 text-sm mb-16 font-bold uppercase tracking-widest text-center">Revision Date: April 23, 2026</p>

          <div className="space-y-12 text-gray-600 leading-relaxed font-medium">
            <section>
              <h2 className="text-2xl font-black text-[#1A1523] mb-6 flex items-center gap-4">
                Google Play Data Safety
              </h2>
              <p>This policy explains how InspiraVerse collects and uses data to satisfy Google Play transparency requirements.</p>
              <ul className="list-disc pl-6 mt-4 space-y-2">
                <li><strong>Personal Info:</strong> Email for authentication.</li>
                <li><strong>App Activity:</strong> Interaction with quotes to improve curation.</li>
                <li><strong>Device ID:</strong> For push notifications via FCM.</li>
              </ul>
            </section>

            <section>
              <h2 className="text-2xl font-black text-[#1A1523] mb-6 flex items-center gap-4">
                No Third-Party Sharing
              </h2>
              <p>We do not share your personal data with any third-party advertisers. Data is processed solely by Google Firebase to provide the Service infrastructure.</p>
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
