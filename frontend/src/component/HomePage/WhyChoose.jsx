import React from 'react';
import { Download, Truck, Shield, Recycle } from 'lucide-react';
import './WhyChoose.css';

const WhyChoose = () => {
  const benefits = [
    {
      icon: Download,
      title: 'Instant Digital Access',
      description: 'Download your study materials immediately after purchase'
    },
    {
      icon: Truck,
      title: 'Fast Physical Delivery',
      description: 'Quick delivery of physical workbooks to your doorstep'
    },
    {
      icon: Shield,
      title: 'Quality Guarantee',
      description: 'All materials are quality checked and curriculum aligned'
    },
    {
      icon: Recycle,
      title: 'Eco-Friendly Options',
      description: 'Recycle old books and contribute to sustainable education'
    }
  ];

  return (
    <section className="why-choose-section">
      <div className="why-choose-container">
        <h2 className="why-choose-title">
          Why Choose PadhaixPress?
        </h2>
        
        <div className="benefits-grid">
          {benefits.map((benefit, index) => (
            <div key={index} className="benefit-item">
              <div className="benefit-icon-container">
                <benefit.icon className="benefit-icon" />
              </div>
              <h3 className="benefit-title">
                {benefit.title}
              </h3>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};

export default WhyChoose;