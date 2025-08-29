import './FirstYearNotes.css';
import { renderYearNotes } from './renderYearNotes';

export default function FirstYearNotes(){
    const sections = [
        {
            title: 'c programming',
            description: 'prepare yourself for c programming languages.',
            items: [
                { name: 'Co1 & Co2 pdf notes' },
                { name: 'Co3 & Co4 pdf notes' },
                { name: 'importent question' },
                { name: 'practical question' }
                
            ]
        },
        {
            title: 'Vadic Maths',
            description: 'prepare yourself for vedic maths.',
            items: [
                { name: 'Co1 & Co2 pdf notes' },
                { name: 'Co3 & Co4 pdf notes' },
                { name: 'importent question' },
                { name: 'practical question' }
                
            ]
        },
        
        
    ];

    return (
        <>
        {renderYearNotes({
            heading: 'First Year – Practice Sets',
            subheading: 'Click a topic to view the list of problems.',
            sections
        })}
        </>
    );
}