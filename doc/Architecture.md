# GGIRCS Architecture

## SQL Conventions

GGIRCS establishes several conventions in harmony with the [High Level Data Design Guidelines]
and the [system architecure proposal].

1. Schemas are used to separate concerns.
   - This ensures that each application reads and writes to/from its own namespace.
     eg. ETL pipeline operations write to `swrs_transform` while the
     reporting tools read from `ggircs` and the audit tools read from `ggircs_history`.
2. Tables are preferred over materialized views.
   - In cases where data integrity is required, GGIRCS prefers to drop and re-create derived tables
     using stored procedures instead of relying on materialized views in order to ensure
     related tables have foreign key constraints.
3. Automated Testing of the Database.
   - This ensures that established conventions are enshrined in code and can be verified.
   - This ensures developer expectations align with reality.

[high level data design guidelines]: https://buttoninc.sharepoint.com/:b:/r/sites/bc-cas2/Shared%20Documents/Data/High%20Level%20Data%20Design%20Guidelines.pdf?csf=1&e=erpmdJ
[system architecure proposal]: https://buttoninc.sharepoint.com/:w:/r/sites/bc-cas2/Shared%20Documents/Wireframes%20and%20Design/GGIRCS%20Database%20Architecture%20and%20Process.docx?d=w44768c53b54a42e6b3323b2d1d415720&csf=1&e=JAe1Zy
