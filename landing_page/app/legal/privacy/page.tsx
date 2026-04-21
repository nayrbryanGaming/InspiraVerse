import React from 'react';
import Link from 'next/link';

export default function PrivacyPolicy() {
  return (
    <div className="min-h-screen bg-[#FDFCFE] text-[#1A1523] py-24 px-6 sm:px-8 lg:px-10 font-[family-name:var(--font-outfit)]">
      <div className="max-w-4xl mx-auto bg-white p-12 md:p-20 rounded-[3rem] shadow-[0_50px_100px_-20px_rgba(26,21,35,0.1)] border border-gray-100 flex flex-col items-center">
        <Link href="/" className="inline-flex items-center text-violet-600 font-bold mb-12 hover:-translate-x-2 transition-transform group">
          <svg className="w-5 h-5 mr-3 group-hover:scale-125 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="3" d="M15 19l-7-7 7-7"></path></svg>
          Back to Sanctuary
        </Link>
        
        <div className="w-full">
          <h1 className="text-4xl md:text-6xl font-black mb-6 tracking-tighter text-center">Privacy Policy</h1>
          <p className="text-gray-400 text-sm mb-16 font-bold uppercase tracking-widest text-center">Revision Date: April 16, 2026</p>

          <div className="space-y-12 text-gray-600 leading-relaxed font-medium">
            <section>
              <h2 className="text-2xl font-black text-[#1A1523] mb-6 flex items-center gap-4">
                <span className="w-8 h-8 rounded-lg bg-violet-100 text-violet-600 flex items-center justify-center text-sm italic">01</span>
                Data Collection Philosophy
              </h2>
              <p className="mb-4">InspiraVerse adheres to a policy of minimal data collection. We only acquire the data necessary to facilitate your psychological journey and maintain Service integrity.</p>
              <ul className="list-disc pl-6 space-y-2">
                <li><strong>Identity:</strong> Email and Display Name via encrypted Firebase Authentication.</li>
                <li><strong>Content:</strong> Journal entries and mood records, stored using AES-256 equivalent encryption.</li>
                <li><strong>Telemetry:</strong> Anonymized usage metrics via Firebase Analytics to optimize curation logic.</li>
              </ul>
            </section>

            <section>
              <h2 className="text-2xl font-black text-[#1A1523] mb-6 flex items-center gap-4">
                <span className="w-8 h-8 rounded-lg bg-violet-100 text-violet-600 flex items-center justify-center text-sm italic">02</span>
                Sovereignty & Control
              </h2>
              <p>We do not sell, rent, or trade your personal data. Your metrics and reflections are private. We utilize industry-standard data protection protocols to ensure your digital footprint remains secure.</p>
            </section>

            <section className="bg-violet-50/50 p-10 rounded-[2rem] border border-violet-100">
              <h2 className="text-2xl font-black text-violet-600 mb-6">Google Play Compliance</h2>
              <p className="mb-6">In accordance with Google Play Store standards, we provide simplified and absolute account deletion rights. You can purge your entire digital history directly from the application settings or through our verified request protocol.</p>
              <Link href="/legal/delete-request" className="inline-flex items-center gap-2 text-violet-600 font-bold hover:underline">
                View Deletion Instructions
                <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M17 8l4 4m0 0l-4 4m4-4H3"></path></svg>
              </Link>
            </section>

            <section>
              <h2 className="text-2xl font-black text-[#1A1523] mb-6 flex items-center gap-4">
                <span className="w-8 h-8 rounded-lg bg-violet-100 text-violet-600 flex items-center justify-center text-sm italic">03</span>
                Contact
              </h2>
              <p>For inquiries regarding this policy or to exercise your data rights, please contact our Data Protection Officer at <span className="text-violet-600 font-bold">privacy@inspiraverse.app</span>.</p>
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
