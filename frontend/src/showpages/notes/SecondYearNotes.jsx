import { renderYearNotes } from './renderYearNotes';
import './SecondYearNotes.css';



export default function SecondYearNotes(){

    const sections = [
        {
            title: 'Print statement and Java Syntax',
            description: 'Practice the basic concepts of Java, one of the most widely used object-oriented programming languages.',
            items: [
                { name: 'Print Output in Java' },
                { name: 'Print Hello World' },
                { name: 'Identify Correct Syntax' },
                { name: 'Print difference of 10 and 3' },
                { name: 'Java Import Syntax' },
                { name: 'Print String num' }
            ]
        },]
    return(
        <>
       {renderYearNotes({
            heading: 'First Year – Practice Sets',
            subheading: 'Click a topic to view the list of problems.',
            sections
        })}
        </>
    );
}