// Comprehensive SEO Keywords for PadhaixPress
export const seoKeywords = {
  // Primary Keywords
  primary: [
    'PadhaixPress',
    'study materials',
    'workbooks',
    'K L UNIVERSITY workbooks', 
    'educational platform',
    'print-ready PDFs',
    'academic resources',
    'student materials',
    'college workbooks',
    'school workbooks',
    'educational content'
  ],

  // Educational Keywords
  educational: [
    'K L UNIVERSITY workbooks',
    'semester workbooks',
    'academic workbooks',
    'study guides',
    'learning resources',
    'educational materials',
    'student resources',
    'academic materials',
    'college study materials',
    'university workbooks',
    'engineering workbooks',
    'technical education',
    'higher education materials'
  ],

  // Year and Semester Specific
  yearSpecific: [
    'first year workbooks',
    'second year workbooks',
    'third year workbooks',
    'fourth year workbooks',
    'odd semester workbooks',
    'even semester workbooks',
    'first year odd semester',
    'first year even semester',
    'second year odd semester',
    'second year even semester',
    'third year odd semester',
    'third year even semester',
    'fourth year odd semester',
    'fourth year even semester'
  ],

  // Subject Specific
  subjects: [
    'engineering workbooks',
    'computer science workbooks',
    'mechanical engineering workbooks',
    'electrical engineering workbooks',
    'civil engineering workbooks',
    'electronics workbooks',
    'mathematics workbooks',
    'physics workbooks',
    'chemistry workbooks',
    'technical workbooks'
  ],

  // Action Keywords
  actions: [
    'download workbooks',
    'print workbooks',
    'study materials download',
    'educational PDFs',
    'print-ready materials',
    'academic downloads',
    'student resources download',
    'educational content download'
  ],

  // Location and Institution
  location: [
    'K L UNIVERSITY',
    'KLU workbooks',
    'Andhra Pradesh education',
    'Indian education',
    'university workbooks India',
    'college materials India',
    'engineering education India'
  ],

  // Sustainability Keywords
  sustainability: [
    'recycle books',
    'donate books',
    'sustainable education',
    'educational donation',
    'book recycling',
    'sustainable learning',
    'environmental education',
    'green education'
  ],

  // User Intent Keywords
  userIntent: [
    'buy workbooks',
    'download study materials',
    'find academic resources',
    'college study materials',
    'university workbooks',
    'student study guides',
    'educational platform',
    'online learning resources'
  ],

  // Long-tail Keywords
  longTail: [
    'K L UNIVERSITY first year workbooks download',
    'engineering workbooks for college students',
    'print-ready PDF workbooks for university',
    'academic study materials for engineering students',
    'college workbooks for odd semester',
    'university study guides for even semester',
    'download educational workbooks for students',
    'online academic resources for engineering'
  ]
};

// Generate keywords for specific pages
export const getPageKeywords = (page) => {
  const keywordMap = {
    '/': [...seoKeywords.primary, ...seoKeywords.educational, ...seoKeywords.userIntent],
    '/about': [...seoKeywords.primary, 'about PadhaixPress', 'educational mission', 'learning platform'],
    '/workbook': [...seoKeywords.educational, ...seoKeywords.yearSpecific, ...seoKeywords.subjects],
    '/notes': [...seoKeywords.educational, 'study notes', 'academic notes', 'learning notes'],
    '/recycle': [...seoKeywords.sustainability, 'recycle education', 'donate books'],
    '/project': [...seoKeywords.educational, 'academic projects', 'student projects'],
    '/contact': [...seoKeywords.primary, 'contact PadhaixPress', 'support'],
    '/signin': [...seoKeywords.primary, 'login', 'sign in', 'account access'],
    '/signup': [...seoKeywords.primary, 'register', 'create account', 'sign up']
  };

  return keywordMap[page] || seoKeywords.primary;
};

// Generate structured data for different page types
export const generateStructuredData = (page, data = {}) => {
  const baseData = {
    "@context": "https://schema.org",
    "@type": "WebPage",
    "name": data.title || "PadhaixPress",
    "description": data.description || "Educational platform providing high-quality study materials",
    "url": `https://www.padhaixpress.in${page}`,
    "mainEntity": {
      "@type": "Organization",
      "name": "PadhaixPress",
      "url": "https://www.padhaixpress.in",
      "description": "Innovative educational platform providing high-quality study materials, workbooks, and print-ready PDFs"
    }
  };

  // Add specific structured data based on page type
  if (page.includes('/workbook')) {
    baseData["@type"] = "CollectionPage";
    baseData["about"] = {
      "@type": "EducationalOrganization",
      "name": "PadhaixPress",
      "description": "Educational platform providing academic workbooks and study materials"
    };
  }

  if (page === '/') {
    baseData["@type"] = "WebSite";
    baseData["potentialAction"] = {
      "@type": "SearchAction",
      "target": "https://www.padhaixpress.in/search?q={search_term_string}",
      "query-input": "required name=search_term_string"
    };
  }

  return baseData;
}; 