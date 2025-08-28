import React from 'react'
import Notes from './Notes';
import NotesHero from './NotesHero';
import Footer from '../../Footer.jsx';

function NotesPage() {
    return (  
        <>
        <div>
        <NotesHero/>
        <Notes/>
        </div>
        <Footer/>
        </>
    );
}

export default NotesPage;
