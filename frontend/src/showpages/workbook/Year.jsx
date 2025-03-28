
import React, { useState } from "react";
import "./WorkBook.css";

const workbooksData = [
    { "id": 1, "title": "Computer Networks", "image": "media/image/work.jpg", "info": "Learn about networks" },
    { "id": 2, "title": "Data Structures", "image": "media/image/work.jpg", "info": "Master DSA concepts" },
    { "id": 3, "title": "Operating Systems", "image": "media/image/work.jpg", "info": "Understand OS concepts" },
    { "id": 4, "title": "Database Management", "image": "media/image/work.jpg", "info": "SQL and NoSQL databases" },
    { "id": 5, "title": "Software Engineering", "image": "media/image/work.jpg", "info": "Develop better software" },
    { "id": 6, "title": "Artificial Intelligence", "image": "media/image/work.jpg", "info": "AI and Machine Learning" },
    { "id": 7, "title": "Cyber Security", "image": "media/image/work.jpg", "info": "Protect systems from threats" },
    { "id": 8, "title": "Cloud Computing", "image": "media/image/work.jpg", "info": "AWS, Azure, GCP" },
    { "id": 9, "title": "Blockchain Technology", "image": "media/image/work.jpg", "info": "Decentralized networks" },
    { "id": 10, "title": "Internet of Things", "image": "media/image/work.jpg", "info": "Connected devices" },
    { "id": 11, "title": "Embedded Systems", "image": "media/image/work.jpg", "info": "Microcontrollers and IoT" },
    { "id": 12, "title": "Computer Graphics", "image": "media/image/work.jpg", "info": "3D Rendering" },
    { "id": 13, "title": "Digital Logic Design", "image": "media/image/work.jpg", "info": "Boolean algebra & circuits" },
    { "id": 14, "title": "Big Data Analytics", "image": "media/image/work.jpg", "info": "Analyze large datasets" },
    { "id": 15, "title": "Quantum Computing", "image": "media/image/work.jpg", "info": "Future of computing" },
    { "id": 16, "title": "Wireless Communication", "image": "media/image/work.jpg", "info": "5G & beyond" },
    { "id": 17, "title": "Image Processing", "image": "media/image/work.jpg", "info": "Computer vision" },
    { "id": 18, "title": "Machine Learning", "image": "media/image/work.jpg", "info": "AI model training" },
    { "id": 19, "title": "Human-Computer Interaction", "image": "media/image/work.jpg", "info": "UX/UI design principles" },
    { "id": 20, "title": "Software Testing", "image": "media/image/work.jpg", "info": "Improve code quality" }
  ];

function Year()
{
  const [search,setSearch]=useState("");

  const filteredWorkbookData = workbooksData.filter((wb) =>
    wb.title.toLowerCase().includes(search.toLowerCase())
);



  return(
    <>
    <div className="all" >
    <div className="ner">
      <div className="search-bar">
     <input
        type="text"
        placeholder=" Search Engineering books..."
        value={search}
        onChange={(e)=>
          setSearch(e.target.value)
        }
      />
     
      </div>
    </div>


      {/* Book Grid */}
      <div className="grid" >
        {filteredWorkbookData.length > 0 ? (
          filteredWorkbookData.map((wb) => (
            <div key={wb.id} className="card">
              <img src={wb.image} alt={wb.title} />
              <h4 className="card-title">{wb.title}</h4>
              <p className="card-info">{wb.info}</p>
            </div>
          ))
        ) : (
          <p>No books found.</p>
        )}
      </div>
    </div>
    </>
  );
}

export default Year;

