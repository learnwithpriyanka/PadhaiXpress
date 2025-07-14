import React from 'react';
import { useLocation } from 'react-router-dom';
import SEOHead from './SEOHead';
import { getPageSEOData } from '../../utils/sitemapGenerator';

const SEOWrapper = ({ children }) => {
  const location = useLocation();
  const seoData = getPageSEOData(location.pathname);

  return (
    <>
      <SEOHead
        title={seoData.title}
        description={seoData.description}
        keywords={seoData.keywords}
        canonicalUrl={seoData.canonicalUrl}
        structuredData={seoData.structuredData}
      />
      {children}
    </>
  );
};

export default SEOWrapper; 