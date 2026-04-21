import React from 'react';
import Link from 'next/link';

export default function TermsOfService() {
  return (
    <div className="min-h-screen bg-[#FDFCFE] text-[#1A1523] py-24 px-6 sm:px-8 lg:px-10 font-[family-name:var(--font-outfit)]">
      <div className="max-w-4xl mx-auto bg-white p-12 md:p-20 rounded-[3rem] shadow-[0_50px_100px_-20px_rgba(26,21,35,0.1)] border border-gray-100 flex flex-col items-center">
        <Link href="/" className="inline-flex items-center text-violet-600 font-bold mb-12 hover:-translate-x-2 transition-transform group">
          <svg className="w-5 h-5 mr-3 group-hover:scale-125 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="3" d="M15 19l-7-7 7-7"></path></svg>
          Back to Sanctuary
        </Link>
        
        <div className="w-full">
          <h1 className="text-4xl md:text-6xl font-black mb-6 tracking-tighter text-center">Terms of Service</h1>
          <p className="text-gray-400 text-sm mb-16 font-bold uppercase tracking-widest text-center">Revision Date: April 16, 2026</p>

          <div className="space-y-12 text-gray-600 leading-relaxed font-medium">
            <section>
              <h2 className="text-2xl font-black text-[#1A1523] mb-6 flex items-center gap-4">
                <span className="w-8 h-8 rounded-lg bg-violet-100 text-violet-600 flex items-center justify-center text-sm italic">01</span>
                Acceptance of Mastery
              </h2>
              <p>By accessing InspiraVerse, you acknowledge that you have read, understood, and agreed to be bound by these Terms of Service. This Service is designed for elite motivational curation and personal evolution.</p>
            </section>

            <section>
              <h2 className="text-2xl font-black text-[#1A1523] mb-6 flex items-center gap-4">
                <span className="w-8 h-8 rounded-lg bg-violet-100 text-violet-600 flex items-center justify-center text-sm italic">02</span>
                Digital Stewardship
              </h2>
              <p>Users are responsible for the reflections and data they generate within the platform. While we provide the vessel, the journey is yours. Prohibited conduct includes attempts to destabilize the Service infrastructure or use for malicious non-motivational purposes.</p>
            </section>

            <section>
              <h2 className="text-2xl font-black text-[#1A1523] mb-6 flex items-center gap-4">
                <span className="w-8 h-8 rounded-lg bg-violet-100 text-violet-600 flex items-center justify-center text-sm italic">03</span>
                Intellectual Property
              </h2>
              <p>The InspiraVerse brand, design system, and proprietary curation algorithms are protected by global intellectual property laws. You retain absolute ownership of your personal reflections and journal data.</p>
            </section>

            <section>
              <h2 className="text-2xl font-black text-[#1A1523] mb-6 flex items-center gap-4">
                <span className="w-8 h-8 rounded-lg bg-violet-100 text-violet-600 flex items-center justify-center text-sm italic">04</span>
                Limitation & Disclaimer
              </h2>
              <p>InspiraVerse is provided on an "as-is" basis. We are not liable for any psychological outcomes or indirect damages resulting from the use of our motivational Service.</p>
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
