import { useLayoutEffect } from 'react';
import { useLocation } from 'react-router-dom';

export default function ScrollToTop() {
  const { pathname } = useLocation();

  useLayoutEffect(() => {
    if ('scrollTo' in window) {
      window.scrollTo({ top: 0, left: 0, behavior: 'auto' });
    } else {
      window.scrollTo(0, 0);
    }
  }, [pathname]);

  return null;
} 