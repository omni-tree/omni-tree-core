# Design

## TBD

* Should the Timestamp type be a primitive or a user-defined primitive alias?
  * The system will definitely deal with networking, so should IP Address and
    MAC Address be predefined primitives?
  * Can't the system use aliases defined in a base package?
  * Pre-defines primitives might be needed if the schema needs it as a first
    class concept. For example, to create timestamp fields for time rollups. 
    * Can schema for time rollups be captured outside the primary data schema?

