/**
 * {
  "userId": 42,
  "username": "debug_test",
  "isActive": true,
  "roles": ["admin", "editor", "viewer"],
  "profile": {
    "firstName": "Alex",
    "lastName": "Johnson",
    "age": 29,
    "preferences": {
      "theme": "dark",
      "notifications": false,
      "language": "en-US"
    }
  },
  "lastLogin": "2026-03-10T13:50:00Z",
  "sessionToken": "abc123xyz789",
  "items": [
    {"id": 1, "name": "Widget", "price": 19.99},
    {"id": 2, "name": "Gadget", "price": 29.99},
    {"id": 3, "name": "Thingamajig", "price": 9.99}
  ]
}
 */


public  class SampleWrapperClass {
    public String userId {get;set;}
    public String username {get;set;}
    public Boolean isActive {get;set;}
    public List<String> roles {get;set;}
    public Profile profile {get;set;}
    public String LastLogin {get;set;}
    public String sessionToken {get;set;}
    public List<Item> items {get;set;}

    public class Profile {
        public String firstName{get;set;}
        public String lastName{get;set;}
        public Integer age{get;set;}
        public Preference preferences {get;set;} 
    }

    public class Preference{
        public String theme{get;set;}
        public Boolean notifications{get;set;}
        public String language{get;set;}
    }
    public class Item{
        public Integer id{get;set;}
        public String name{get;set;}
        public Decimal price {get;set;}
    }

}