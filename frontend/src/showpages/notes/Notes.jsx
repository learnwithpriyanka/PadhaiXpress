// NotesPage.jsx
import { motion } from 'framer-motion';
import './NotesPage.css';

export default function NotesPage() {
  return (
    <div className="notes-container">
      <motion.div 
        initial={{ opacity: 0, scale: 0.8, y: -50 }} 
        animate={{ opacity: 1, scale: 1, y: 0 }} 
        transition={{ duration: 1, ease: 'easeOut' }}
        className="notes-card"
      >
        <motion.h1 
          className="title"
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 1.2, delay: 0.5 }}
        >
           Coming Soon!
        </motion.h1>
        <motion.p 
          className="subtitle"
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 1.2, delay: 0.7 }}
        >
          We're working on something amazing for you.
        </motion.p>
        <motion.div 
          animate={{ y: [0, -15, 0] }} 
          transition={{ repeat: Infinity, duration: 1.2, ease: 'easeInOut' }}
          className="icon"
        >
          <motion.span
            animate={{ rotate: [0, 10, -10, 0] }}
            transition={{ repeat: Infinity, duration: 1.5, ease: 'easeInOut' }}
          >
            📖✨
          </motion.span>
        </motion.div>
      </motion.div>
    </div>
  );
}
