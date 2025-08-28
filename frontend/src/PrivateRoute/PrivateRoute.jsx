import React, { useEffect, useState } from 'react';
import { supabase } from '../supabaseClient';
import { Navigate, useLocation } from 'react-router-dom';

const PrivateRoute = ({ allowedRoles, children }) => {
  const [isAllowed, setIsAllowed] = useState(null); // null = loading, false = not allowed, true = allowed
  const location = useLocation();

  useEffect(() => {
    const checkAccess = async () => {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) {
        setIsAllowed(false);
        return;
      }
      const { data, error } = await supabase
        .from('users')
        .select('role')
        .eq('id', user.id)
        .single();
      if (!error && data && allowedRoles.includes(data.role)) {
        setIsAllowed(true);
      } else {
        setIsAllowed(false);
      }
    };
    checkAccess();
  }, [allowedRoles]);

  if (isAllowed === null) {
    return <div>Loading...</div>;
  }
  if (!isAllowed) {
    // If not logged in, redirect to signin. If logged in but not allowed, redirect to home.
    const token = localStorage.getItem('token');
    if (!token) {
      return <Navigate to="/signin" state={{ from: location }} replace />;
    }
    return <Navigate to="/" replace />;
  }
  return children;
};

export default PrivateRoute; 