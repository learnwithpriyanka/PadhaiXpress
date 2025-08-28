import './FirstYearNotes.css';
import { renderYearNotes } from './renderYearNotes';

export default function FirstYearNotes(){
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
        },
        {
            title: 'Variables and Data Types',
            description: 'Practice problems on variables and different data types.',
            items: [
                { name: 'Declare and Initialize' },
                { name: 'Type Conversion' }
            ]
        },
        {
            title: 'Strings',
            description: 'Practice basic concepts of strings in Java',
            items: [
                { name: 'String Concatenation' },
                { name: 'Substring and Index' }
            ]
        },
        {
            title: 'User Input',
            description: 'Practice problems related to taking input from the user and building custom programs.',
            items: [
                { name: 'Scanner Basics' },
                { name: 'Read Integers and Strings' }
            ]
        },
        {
            title: 'Algorithmic problems - 1',
            description: 'Practice simple problems on input, output and basic math',
            items: [
                { name: 'Sum and Average' },
                { name: 'Min/Max of Three' }
            ]
        }
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