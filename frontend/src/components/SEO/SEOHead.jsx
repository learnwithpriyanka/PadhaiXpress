import React, { useEffect } from 'react';

const SEOHead = ({ 
  title, 
  description, 
  keywords, 
  canonicalUrl, 
  ogImage, 
  ogType = 'website',
  twitterCard = 'summary_large_image',
  structuredData = null 
}) => {
  const baseUrl = 'https://www.padhaixpress.in';
  const fullCanonicalUrl = canonicalUrl ? `${baseUrl}${canonicalUrl}` : baseUrl;
  const fullOgImage = ogImage ? `${baseUrl}${ogImage}` : `${baseUrl}/logo.jpg`;

  useEffect(() => {
    // Update document title
    document.title = title;

    // Update or create meta tags
    const updateMetaTag = (name, content) => {
      let meta = document.querySelector(`meta[name="${name}"]`);
      if (!meta) {
        meta = document.createElement('meta');
        meta.name = name;
        document.head.appendChild(meta);
      }
      meta.content = content;
    };

    const updatePropertyTag = (property, content) => {
      let meta = document.querySelector(`meta[property="${property}"]`);
      if (!meta) {
        meta = document.createElement('meta');
        meta.setAttribute('property', property);
        document.head.appendChild(meta);
      }
      meta.content = content;
    };

    // Update primary meta tags
    updateMetaTag('title', title);
    updateMetaTag('description', description);
    updateMetaTag('keywords', keywords);
    updateMetaTag('author', 'PadhaixPress');
    updateMetaTag('robots', 'index, follow');
    updateMetaTag('language', 'English');

    // Update Open Graph tags
    updatePropertyTag('og:type', ogType);
    updatePropertyTag('og:url', fullCanonicalUrl);
    updatePropertyTag('og:title', title);
    updatePropertyTag('og:description', description);
    updatePropertyTag('og:image', fullOgImage);
    updatePropertyTag('og:site_name', 'PadhaixPress');
    updatePropertyTag('og:locale', 'en_US');

    // Update Twitter Card tags
    updatePropertyTag('twitter:card', twitterCard);
    updatePropertyTag('twitter:url', fullCanonicalUrl);
    updatePropertyTag('twitter:title', title);
    updatePropertyTag('twitter:description', description);
    updatePropertyTag('twitter:image', fullOgImage);

    // Update canonical URL
    let canonical = document.querySelector('link[rel="canonical"]');
    if (!canonical) {
      canonical = document.createElement('link');
      canonical.rel = 'canonical';
      document.head.appendChild(canonical);
    }
    canonical.href = fullCanonicalUrl;

    // Add structured data
    if (structuredData) {
      // Remove existing structured data
      const existingScripts = document.querySelectorAll('script[type="application/ld+json"]');
      existingScripts.forEach(script => {
        if (script.textContent.includes('"@context":"https://schema.org"')) {
          script.remove();
        }
      });

      // Add new structured data
      const script = document.createElement('script');
      script.type = 'application/ld+json';
      script.textContent = JSON.stringify(structuredData);
      document.head.appendChild(script);
    }

    // Cleanup function
    return () => {
      // Reset title to default when component unmounts
      document.title = 'PadhaixPress - High-Quality Study Materials, Workbooks & Print-Ready PDFs';
    };
  }, [title, description, keywords, canonicalUrl, ogImage, ogType, twitterCard, structuredData, fullCanonicalUrl, fullOgImage]);

  // This component doesn't render anything visible
  return null;
};

export default SEOHead; 