import { NavLink } from 'react-router-dom';
import './AdminSidebar.css';

const links = [
  { to: '/admin-dashboard', label: 'Dashboard' },
  { to: '/admin-dashboard/product-manager', label: 'Products' },
  { to: '/admin-dashboard/coupons', label: 'Coupons' },
  { to: '/admin-dashboard/custom-workbooks', label: 'Custom Workbooks' },
];

export default function AdminSidebar() {
  return (
    <aside className="admin-sidebar">
      <div className="admin-sidebar-header">Admin Panel</div>
      <nav>
        {links.map(link => (
          <NavLink
            key={link.to}
            to={link.to}
            className={({ isActive }) =>
              isActive ? 'admin-sidebar-link active' : 'admin-sidebar-link'
            }
          >
            {link.label}
          </NavLink>
        ))}
      </nav>
    </aside>
  );
}