// Sitemap Generator for PadhaixPress
const baseUrl = 'https://www.padhaixpress.in';

export const sitemapData = [
  {
    url: '/',
    title: 'PadhaixPress - High-Quality Study Materials, Workbooks & Print-Ready PDFs',
    description: 'PadhaixPress is an innovative educational platform providing high-quality study materials, workbooks, and print-ready PDFs for students and lifelong learners.',
    priority: 1.0,
    changefreq: 'daily'
  },
  {
    url: '/about',
    title: 'About Us - PadhaixPress Educational Platform',
    description: 'Learn about PadhaixPress mission to make learning accessible, engaging, and affordable for everyone. Discover our team and educational vision.',
    priority: 0.8,
    changefreq: 'monthly'
  },
  {
    url: '/contact',
    title: 'Contact Us - PadhaixPress Support',
    description: 'Get in touch with PadhaixPress for support, feedback, or inquiries about our educational materials and services.',
    priority: 0.7,
    changefreq: 'monthly'
  },
  {
    url: '/workbook',
    title: 'Workbooks - Academic Study Materials | PadhaixPress',
    description: 'Browse comprehensive workbooks for all academic years and semesters. High-quality study materials for school and college students.',
    priority: 0.9,
    changefreq: 'weekly'
  },
  {
    url: '/workbook/year1/firstyearoddsem',
    title: 'First Year Odd Semester Workbooks - PadhaixPress',
    description: 'Comprehensive workbooks for First Year Odd Semester students. Download high-quality study materials and print-ready PDFs.',
    priority: 0.8,
    changefreq: 'weekly'
  },
  {
    url: '/workbook/year1/firstyearevensem',
    title: 'First Year Even Semester Workbooks - PadhaixPress',
    description: 'Comprehensive workbooks for First Year Even Semester students. Download high-quality study materials and print-ready PDFs.',
    priority: 0.8,
    changefreq: 'weekly'
  },
  {
    url: '/workbook/year1/secondyearoddsem',
    title: 'Second Year Odd Semester Workbooks - PadhaixPress',
    description: 'Comprehensive workbooks for Second Year Odd Semester students. Download high-quality study materials and print-ready PDFs.',
    priority: 0.8,
    changefreq: 'weekly'
  },
  {
    url: '/workbook/year1/secondyearevensem',
    title: 'Second Year Even Semester Workbooks - PadhaixPress',
    description: 'Comprehensive workbooks for Second Year Even Semester students. Download high-quality study materials and print-ready PDFs.',
    priority: 0.8,
    changefreq: 'weekly'
  },
  {
    url: '/workbook/year1/thirdyearoddsem',
    title: 'Third Year Odd Semester Workbooks - PadhaixPress',
    description: 'Comprehensive workbooks for Third Year Odd Semester students. Download high-quality study materials and print-ready PDFs.',
    priority: 0.8,
    changefreq: 'weekly'
  },
  {
    url: '/workbook/year1/thirdyearevensem',
    title: 'Third Year Even Semester Workbooks - PadhaixPress',
    description: 'Comprehensive workbooks for Third Year Even Semester students. Download high-quality study materials and print-ready PDFs.',
    priority: 0.8,
    changefreq: 'weekly'
  },
  {
    url: '/workbook/year1/fourthyearoddsem',
    title: 'Fourth Year Odd Semester Workbooks - PadhaixPress',
    description: 'Comprehensive workbooks for Fourth Year Odd Semester students. Download high-quality study materials and print-ready PDFs.',
    priority: 0.8,
    changefreq: 'weekly'
  },
  {
    url: '/workbook/year1/fourthyearevensem',
    title: 'Fourth Year Even Semester Workbooks - PadhaixPress',
    description: 'Comprehensive workbooks for Fourth Year Even Semester students. Download high-quality study materials and print-ready PDFs.',
    priority: 0.8,
    changefreq: 'weekly'
  },
  {
    url: '/notes',
    title: 'Study Notes - Academic Resources | PadhaixPress',
    description: 'Access comprehensive study notes and academic resources. High-quality educational content for students at all levels.',
    priority: 0.8,
    changefreq: 'weekly'
  },
  {
    url: '/recycle',
    title: 'Recycle & Donate - Sustainable Education | PadhaixPress',
    description: 'Support sustainable education through our recycle and donate program. Contribute to making education accessible for all.',
    priority: 0.7,
    changefreq: 'monthly'
  },
  {
    url: '/project',
    title: 'Projects - Academic Projects & Resources | PadhaixPress',
    description: 'Explore academic projects and resources. Comprehensive project materials for students and educators.',
    priority: 0.7,
    changefreq: 'monthly'
  },
  {
    url: '/signin',
    title: 'Sign In - PadhaixPress Account',
    description: 'Sign in to your PadhaixPress account to access personalized study materials and track your learning progress.',
    priority: 0.6,
    changefreq: 'monthly'
  },
  {
    url: '/signup',
    title: 'Sign Up - Create PadhaixPress Account',
    description: 'Create your PadhaixPress account to access high-quality study materials, workbooks, and educational resources.',
    priority: 0.6,
    changefreq: 'monthly'
  },
  {
    url: '/terms',
    title: 'Terms of Service - PadhaixPress',
    description: 'Read PadhaixPress terms of service and user agreement for our educational platform and services.',
    priority: 0.4,
    changefreq: 'yearly'
  },
  {
    url: '/privacy',
    title: 'Privacy Policy - PadhaixPress',
    description: 'Learn about PadhaixPress privacy policy and how we protect your data on our educational platform.',
    priority: 0.4,
    changefreq: 'yearly'
  }
];

export const generateXMLSitemap = () => {
  const xmlHeader = '<?xml version="1.0" encoding="UTF-8"?>';
  const urlsetStart = '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">';
  const urlsetEnd = '</urlset>';
  
  const urls = sitemapData.map(item => {
    const lastmod = new Date().toISOString().split('T')[0];
    return `  <url>
    <loc>${baseUrl}${item.url}</loc>
    <lastmod>${lastmod}</lastmod>
    <changefreq>${item.changefreq}</changefreq>
    <priority>${item.priority}</priority>
  </url>`;
  }).join('\n');
  
  return `${xmlHeader}\n${urlsetStart}\n${urls}\n${urlsetEnd}`;
};

export const getPageSEOData = (pathname) => {
  const page = sitemapData.find(item => item.url === pathname);
  if (page) {
    return {
      title: page.title,
      description: page.description,
      keywords: generateKeywordsForPage(pathname),
      canonicalUrl: page.url,
      structuredData: generateStructuredDataForPage(pathname, page)
    };
  }
  
  // Default SEO data
  return {
    title: 'PadhaixPress - High-Quality Study Materials, Workbooks & Print-Ready PDFs',
    description: 'PadhaixPress is an innovative educational platform providing high-quality study materials, workbooks, and print-ready PDFs.',
    keywords: 'PadhaixPress, study materials, workbooks, educational platform, print-ready PDFs',
    canonicalUrl: pathname,
    structuredData: null
  };
};

const generateKeywordsForPage = (pathname) => {
  const keywordMap = {
    '/': 'PadhaixPress, study materials, workbooks, educational platform, print-ready PDFs, school students, college students, learning resources',
    '/about': 'PadhaixPress about, educational platform, learning mission, student resources, academic materials',
    '/contact': 'PadhaixPress contact, support, feedback, educational platform help',
    '/workbook': 'workbooks, academic workbooks, study materials, semester workbooks, college workbooks, student workbooks',
    '/notes': 'study notes, academic notes, educational resources, student notes, learning materials',
    '/recycle': 'recycle education, donate books, sustainable education, educational donation, student support',
    '/project': 'academic projects, student projects, educational projects, learning projects',
    '/signin': 'PadhaixPress login, sign in, account access, student portal',
    '/signup': 'PadhaixPress registration, create account, student signup, educational platform account'
  };
  
  return keywordMap[pathname] || 'PadhaixPress, educational platform, study materials, workbooks';
};

const generateStructuredDataForPage = (pathname, page) => {
  const baseStructuredData = {
    "@context": "https://schema.org",
    "@type": "WebPage",
    "name": page.title,
    "description": page.description,
    "url": `${baseUrl}${page.url}`,
    "mainEntity": {
      "@type": "Organization",
      "name": "PadhaixPress",
      "url": baseUrl,
      "description": "Innovative educational platform providing high-quality study materials, workbooks, and print-ready PDFs"
    }
  };

  // Add specific structured data for different page types
  if (pathname.includes('/workbook')) {
    baseStructuredData["@type"] = "CollectionPage";
    baseStructuredData["about"] = {
      "@type": "EducationalOrganization",
      "name": "PadhaixPress",
      "description": "Educational platform providing academic workbooks and study materials"
    };
  }

  if (pathname === '/') {
    baseStructuredData["@type"] = "WebSite";
    baseStructuredData["potentialAction"] = {
      "@type": "SearchAction",
      "target": `${baseUrl}/search?q={search_term_string}`,
      "query-input": "required name=search_term_string"
    };
  }

  return baseStructuredData;
}; 