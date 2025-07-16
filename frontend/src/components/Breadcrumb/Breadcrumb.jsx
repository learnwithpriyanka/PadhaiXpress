import React from 'react';
import { Link, useLocation } from 'react-router-dom';
import './Breadcrumb.css';

const Breadcrumb = () => {
  const location = useLocation();
  const pathnames = location.pathname.split('/').filter((x) => x);

  const breadcrumbMap = {
    'about': 'About Us',
    'contact': 'Contact',
    'signin': 'Sign In',
    'signup': 'Sign Up',
    'cart': 'Shopping Cart',
    'profile': 'Profile',
    'orders': 'My Orders',
    'workbook': 'Workbooks',
    'notes': 'Study Notes',
    'recycle': 'Recycle & Donate',
    'project': 'Projects',
    'forgot-password': 'Forgot Password',
    'terms': 'Terms and Conditions',
    'privacy': 'Privacy Policy',
    'admin-dashboard': 'Admin Dashboard',
    'printer-dashboard': 'Printer Dashboard',
    'year1': 'First Year',
    'firstyearoddsem': 'First Year Odd Semester',
    'firstyearevensem': 'First Year Even Semester',
    'secondyearoddsem': 'Second Year Odd Semester',
    'secondyearevensem': 'Second Year Even Semester',
    'thirdyearoddsem': 'Third Year Odd Semester',
    'thirdyearevensem': 'Third Year Even Semester',
    'fourthyearoddsem': 'Fourth Year Odd Semester',
    'fourthyearevensem': 'Fourth Year Even Semester'
  };

  const generateStructuredData = () => {
    const items = [
      {
        "@type": "ListItem",
        "position": 1,
        "name": "Home",
        "item": "https://www.padhaixpress.in"
      }
    ];

    let currentPath = '';
    pathnames.forEach((name, index) => {
      currentPath += `/${name}`;
      const displayName = breadcrumbMap[name] || name.charAt(0).toUpperCase() + name.slice(1);
      items.push({
        "@type": "ListItem",
        "position": index + 2,
        "name": displayName,
        "item": `https://www.padhaixpress.in${currentPath}`
      });
    });

    return {
      "@context": "https://schema.org",
      "@type": "BreadcrumbList",
      "itemListElement": items
    };
  };

  return (
    <>
      <nav aria-label="breadcrumb" className="breadcrumb-nav">
        <ol className="breadcrumb">
          <li className="breadcrumb-item">
            <Link to="/" className="breadcrumb-link">
              <i className="fas fa-home"></i> Home
            </Link>
          </li>
          {pathnames.map((name, index) => {
            const routeTo = `/${pathnames.slice(0, index + 1).join('/')}`;
            const isLast = index === pathnames.length - 1;
            const displayName = breadcrumbMap[name] || name.charAt(0).toUpperCase() + name.slice(1);

            return (
              <li key={name} className={`breadcrumb-item ${isLast ? 'active' : ''}`}>
                {isLast ? (
                  <span className="breadcrumb-text">{displayName}</span>
                ) : (
                  <Link to={routeTo} className="breadcrumb-link">
                    {displayName}
                  </Link>
                )}
              </li>
            );
          })}
        </ol>
      </nav>
      
      {/* Structured Data for Breadcrumbs */}
      <script type="application/ld+json">
        {JSON.stringify(generateStructuredData())}
      </script>
    </>
  );
};

export default Breadcrumb; 