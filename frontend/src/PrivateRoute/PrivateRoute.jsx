import React, { useEffect, useState } from 'react';
import { Navigate } from 'react-router-dom';
import { supabase } from '../supabaseClient';

const PrivateRoute = ({ children, allowedRoles = [] }) => {
  const [loading, setLoading] = useState(true);
  const [isAllowed, setIsAllowed] = useState(false);

  useEffect(() => {
    const checkRole = async () => {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) {
        setIsAllowed(false);
        setLoading(false);
        return;
      }
      const { data, error } = await supabase
        .from('users')
        .select('role')
        .eq('id', user.id)
        .single();
      if (error || !data || !data.role) {
        setIsAllowed(false);
      } else {
        setIsAllowed(Array.isArray(allowedRoles) && allowedRoles.includes(data.role));
      }
      setLoading(false);
    };
    checkRole();
  }, [allowedRoles]);

  if (loading) return <div>Loading...</div>;
  if (!isAllowed) return <Navigate to="/signin" replace />;
  return children;
};

export default PrivateRoute;