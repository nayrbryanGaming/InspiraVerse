import { Download, Sparkles, Share2, Layers, ShieldCheck } from "lucide-react";
import Image from "next/image";

export default function Home() {
  return (
    <main className="min-h-screen bg-background">
      {/* Navbar */}
      <nav className="container mx-auto px-6 py-4 flex justify-between items-center">
        <div className="flex items-center gap-2">
          <div className="w-8 h-8 rounded-lg bg-primary flex items-center justify-center">
            <Sparkles className="w-5 h-5 text-white" />
          </div>
          <span className="text-xl font-bold font-outfit">InspiraVerse</span>
        </div>
        <div className="hidden md:flex items-center gap-8 text-sm font-medium">
          <a href="#features" className="hover:text-primary transition-colors">Features</a>
          <a href="#preview" className="hover:text-primary transition-colors">App Preview</a>
          <button className="bg-primary text-white px-6 py-2 rounded-full hover:opacity-90 transition-opacity">
            Download App
          </button>
        </div>
      </nav>

      {/* Hero Section */}
      <section className="container mx-auto px-6 pt-24 pb-32 text-center">
        <h1 className="text-5xl md:text-7xl font-bold font-outfit mb-6 tracking-tight">
          Fuel your <span className="text-primary">Mindset</span>.<br />
          Shape your <span className="text-secondary">Future</span>.
        </h1>
        <p className="text-lg md:text-xl text-gray-600 mb-10 max-w-2xl mx-auto">
          Daily curated quotes, personalized inspiration, and aesthetic shareable cards 
          to keep you motivated in a distracted world.
        </p>
        <div className="flex flex-col sm:flex-row justify-center gap-4">
          <button className="bg-primary text-white px-8 py-4 rounded-full font-semibold flex items-center justify-center gap-2 hover:opacity-90 transition-transform hover:scale-105">
            <Download className="w-5 h-5" />
            Download for iOS
          </button>
          <button className="bg-black text-white px-8 py-4 rounded-full font-semibold flex items-center justify-center gap-2 hover:opacity-90 transition-transform hover:scale-105">
            <img src="https://upload.wikimedia.org/wikipedia/commons/d/d0/Google_Play_Arrow_logo.svg" className="w-5 h-5 filter brightness-0 invert" alt="Play Store" />
            Download for Android
          </button>
        </div>
      </section>

      {/* Features Section */}
      <section id="features" className="bg-white py-24">
        <div className="container mx-auto px-6">
          <h2 className="text-3xl md:text-5xl font-bold font-outfit text-center mb-16">
            Everything you need for daily inspiration.
          </h2>
          <div className="grid md:grid-cols-3 gap-12">
            <FeatureCard 
              icon={<Sparkles className="w-8 h-8 text-primary" />}
              title="Daily Curated Feed"
              desc="Wake up to a personalized quote selected by our psychological datasets to boost your morning."
            />
            <FeatureCard 
              icon={<Share2 className="w-8 h-8 text-primary" />}
              title="Viral Card Generator"
              desc="Create stunning, aesthetic quote cards to share directly on your Instagram or TikTok stories."
            />
            <FeatureCard 
              icon={<Layers className="w-8 h-8 text-primary" />}
              title="Offline Library"
              desc="Save your favorite quotes and access them anywhere, anytime. Complete minimal distraction reading."
            />
          </div>
        </div>
      </section>

      {/* Call to Action */}
      <section className="bg-primary text-white py-24">
        <div className="container mx-auto px-6 text-center">
          <h2 className="text-4xl font-bold font-outfit mb-6">Ready to transform your mindset?</h2>
          <p className="text-xl opacity-90 mb-10 max-w-xl mx-auto">
            Join thousands of users who have found focus, resilience, and daily motivation with InspiraVerse.
          </p>
          <button className="bg-white text-primary px-8 py-4 rounded-full font-bold text-lg hover:bg-gray-50 transition-colors shadow-lg">
            Get Started for Free
          </button>
        </div>
      </section>

      {/* Footer */}
      <footer className="bg-gray-50 pt-16 pb-8 border-t border-gray-100">
        <div className="container mx-auto px-6 flex flex-col md:flex-row justify-between items-center">
          <div className="flex items-center gap-2 mb-4 md:mb-0">
            <Sparkles className="w-5 h-5 text-primary" />
            <span className="font-bold font-outfit text-xl">InspiraVerse</span>
          </div>
          <p className="text-sm text-gray-500 text-center md:text-left">
            © 2026 InspiraVerse App. All rights reserved. Built for growth.
          </p>
          <div className="flex gap-4 mt-4 md:mt-0 text-sm text-gray-500">
            <a href="/legal/privacy" className="hover:text-primary">Privacy</a>
            <a href="/legal/terms" className="hover:text-primary">Terms</a>
            <a href="/legal/data" className="hover:text-primary">Data Policy</a>
          </div>
        </div>
      </footer>
    </main>
  );
}

function FeatureCard({ icon, title, desc }: { icon: React.ReactNode, title: string, desc: string }) {
  return (
    <div className="p-8 rounded-2xl bg-gray-50 hover:bg-white hover:shadow-xl transition-all border border-transparent hover:border-gray-100">
      <div className="w-16 h-16 rounded-2xl bg-white shadow-sm flex items-center justify-center mb-6">
        {icon}
      </div>
      <h3 className="text-xl font-bold font-outfit mb-3">{title}</h3>
      <p className="text-gray-600 leading-relaxed">{desc}</p>
    </div>
  );
}
