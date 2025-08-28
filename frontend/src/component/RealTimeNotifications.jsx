import React, { useEffect, useState } from 'react';
import { supabase } from '../supabaseClient';
import './RealTimeNotifications.css';

const RealTimeNotifications = () => {
  const [notifications, setNotifications] = useState([]);
  const [user, setUser] = useState(null);

  // Always keep user state in sync with Supabase auth
  useEffect(() => {
    const fetchUser = async () => {
      const { data: { user } } = await supabase.auth.getUser();
      setUser(user);
    };
    fetchUser();
    // Subscribe to auth state changes
    const { data: listener } = supabase.auth.onAuthStateChange((_event, session) => {
      setUser(session?.user || null);
    });
    return () => { listener?.unsubscribe(); };
  }, []);

  useEffect(() => {
    if (!user) return;

    // Subscribe to order status changes
    const orderSubscription = supabase
      .channel('order_notifications')
      .on(
        'postgres_changes',
        {
          event: 'UPDATE',
          schema: 'public',
          table: 'orders',
          filter: `user_id=eq.${user.id}`
        },
        (payload) => {
          console.log('Order update notification triggered:', payload);
          const newNotification = {
            id: Date.now(),
            type: 'order_update',
            message: `Order #${payload.new.id} has been updated`,
            timestamp: new Date(),
            orderId: payload.new.id
          };
          
          setNotifications(prev => [newNotification, ...prev]);
          
          // Auto-remove notification after 5 seconds
          setTimeout(() => {
            setNotifications(prev => 
              prev.filter(n => n.id !== newNotification.id)
            );
          }, 5000);
        }
      )
      .subscribe();

    // Subscribe to new orders
    const newOrderSubscription = supabase
      .channel('new_order_notifications')
      .on(
        'postgres_changes',
        {
          event: 'INSERT',
          schema: 'public',
          table: 'orders',
          filter: `user_id=eq.${user.id}`
        },
        (payload) => {
          console.log('New order notification triggered:', payload);
          const newNotification = {
            id: Date.now(),
            type: 'new_order',
            message: `New order #${payload.new.id} has been placed successfully!`,
            timestamp: new Date(),
            orderId: payload.new.id
          };
          
          setNotifications(prev => [newNotification, ...prev]);
          
          // Auto-remove notification after 5 seconds
          setTimeout(() => {
            setNotifications(prev => 
              prev.filter(n => n.id !== newNotification.id)
            );
          }, 5000);
        }
      )
      .subscribe();

    // Subscribe to cart changes
    const cartSubscription = supabase
      .channel('cart_notifications')
      .on(
        'postgres_changes',
        {
          event: 'INSERT',
          schema: 'public',
          table: 'cart_items',
          filter: `user_id=eq.${user.id}`
        },
        async (payload) => {
          console.log('Cart item added notification triggered:', payload);
          
          // Fetch product details for better notification
          const { data: product } = await supabase
            .from('products')
            .select('name')
            .eq('id', payload.new.product_id)
            .single();
          
          const newNotification = {
            id: Date.now() + Math.random(), // Ensure unique id for each notification
            type: 'cart_add',
            message: `${product?.name || 'Item'} added to cart`,
            timestamp: new Date(),
            productId: payload.new.product_id
          };
          
          setNotifications(prev => [newNotification, ...prev]);
          
          // Auto-remove notification after 3 seconds
          setTimeout(() => {
            setNotifications(prev => 
              prev.filter(n => n.id !== newNotification.id)
            );
          }, 3000);
        }
      )
      .subscribe();

    // Subscribe to cart item removal
    const cartRemoveSubscription = supabase
      .channel('cart_remove_notifications')
      .on(
        'postgres_changes',
        {
          event: 'DELETE',
          schema: 'public',
          table: 'cart_items',
          filter: `user_id=eq.${user.id}`
        },
        (payload) => {
          console.log('Cart item removed notification triggered:', payload);
          const newNotification = {
            id: Date.now(),
            type: 'cart_remove',
            message: 'Item removed from cart',
            timestamp: new Date()
          };
          
          setNotifications(prev => [newNotification, ...prev]);
          
          // Auto-remove notification after 3 seconds
          setTimeout(() => {
            setNotifications(prev => 
              prev.filter(n => n.id !== newNotification.id)
            );
          }, 3000);
        }
      )
      .subscribe();

    return () => {
      orderSubscription.unsubscribe();
      newOrderSubscription.unsubscribe();
      cartSubscription.unsubscribe();
      cartRemoveSubscription.unsubscribe();
    };
  }, [user]);

  const removeNotification = (id) => {
    setNotifications(prev => prev.filter(n => n.id !== id));
  };

  if (notifications.length === 0) return null;

  return (
    <div className="notifications-container">
      {notifications.map((notification) => (
        <div 
          key={notification.id} 
          className={`notification ${notification.type}`}
        >
          <div className="notification-content">
            <p>{notification.message}</p>
            <small>{notification.timestamp.toLocaleTimeString()}</small>
          </div>
          <button 
            className="notification-close"
            onClick={() => removeNotification(notification.id)}
          >
            ×
          </button>
        </div>
      ))}
    </div>
  );
};

export default RealTimeNotifications; 