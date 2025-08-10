# Clique Bait E-commerce Analytics

## 1. Objectives and Scope
**Clique Bait** is an innovative online seafood store founded by Danny, who leverages his digital data analytics background to optimize business performance in the seafood industry. This project aims to:

- Analyze customer behavior patterns and user journeys
- Calculate funnel conversion rates and identify drop-off points
- Evaluate campaign performance and ROI
- Provide data-driven product recommendations
- Generate actionable insights for business growth

### Business Alignment
This analysis directly supports Clique Bait's strategic goals by:
- Optimizing the customer acquisition funnel
- Improving product placement and recommendations
- Enhancing marketing campaign effectiveness
- Increasing overall conversion rates and revenue

## 2. Dataset Overview

### Data Source and Structure
The project utilizes five interconnected tables representing different aspects of the e-commerce platform:

**Tables Structure:**
1. **users** - Customer registration and profile data
2. **events** - User interaction tracking (page views, clicks, purchases)
3. **page_hierarchy** - Website page structure and product catalog
4. **event_identifier** - Event type definitions
5. **campaign_identifier** - Marketing campaign metadata

### Key Variables and Meanings

**Users Table:**
- `user_id`: Unique customer identifier
- `cookie_id`: Browser tracking identifier
- `start_date`: Customer registration timestamp

**Events Table:**
- `visit_id`: Session identifier
- `cookie_id`: Links to user sessions
- `page_id`: Page visited
- `event_type`: Type of interaction (1=Page View, 2=Add to Cart, 3=Purchase)
- `sequence_number`: Order of events in session
- `event_time`: Timestamp of interaction

**Page Hierarchy:**
- `page_id`: Unique page identifier
- `page_name`: Descriptive page name
- `product_category`: Product classification
- `product_id`: Unique product identifier

