import React, { useState } from 'react';
import './NotesAccordion.css';

export function renderYearNotes({ heading, subheading, sections }) {
  return (
    <div className="year-notes-wrapper">
      {heading && (
        <div className="year-notes-header">
          <h1>{heading}</h1>
          {subheading && <p>{subheading}</p>}
        </div>
      )}
      <Accordion sections={sections} />
    </div>
  );
}

function Accordion({ sections }) {
  const [openIndex, setOpenIndex] = useState(null);

  const toggle = (idx) => {
    setOpenIndex(openIndex === idx ? null : idx);
  };

  return (
    <div className="accordion">
      {sections.map((sec, idx) => (
        <div className={`accordion-item ${openIndex === idx ? 'open' : ''}`} key={sec.id || idx}>
          <button className="accordion-summary" onClick={() => toggle(idx)}>
            <div className="summary-left">
              <div className="badge">{idx + 1}</div>
              <div>
                <div className="title">{sec.title}</div>
                {sec.description && (
                  <div className="subtitle">{sec.description}</div>
                )}
              </div>
            </div>
            <div className={`chev ${openIndex === idx ? 'rot' : ''}`}>▾</div>
          </button>
          <div className="accordion-content" role="region">
            {sec.items && sec.items.length > 0 ? (
              <ul className="content-list">
                {sec.items.map((it, i) => (
                  <li key={i} className="content-row">
                    <a href={it.href || '#'} target={it.href ? '_blank' : undefined} rel={it.href ? 'noopener noreferrer' : undefined}>
                      {it.name}
                    </a>
                    {it.meta && <span className="meta">{it.meta}</span>}
                  </li>
                ))}
              </ul>
            ) : (
              <div className="empty">No content added yet.</div>
            )}
          </div>
        </div>
      ))}
    </div>
  );
}
