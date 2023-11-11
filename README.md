Original App Design Project
===

# Active Village 

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)
5. [Sprint Planning and Development](#Sprint-Planning-and-Development)

## Overview

### Description

Active Village serves as a social platform for fitness enthusiasts to document and share their fitness journey. Users can share workout tips, clothing and accessory recommendations, and meal prep ideas. It's a space for motivation, support, and exchanging fitness-related advice.

### App Evaluation

[Evaluation of your app across the following attributes]
- **Category:** Health & Fitness / Social 
    - This app falls under both the health and fitness and social networking categories. It's not just a tool for tracking physical activity or diet, but also a platform for social interaction, sharing, and community building among fitness enthusiasts.
- **Mobile:** A mobile app is crucial for this app, as users will likely want to post updates and photos on the go, either from the gym, during outdoor activities, or from their kitchen while preparing meals. The integration of the camera for sharing workout results, meal prep, and fitness attire is a key feature that enhances the mobile experience.
- **Story:** The app's story revolves around creating a supportive and motivating community for those passionate about fitness and healthy living. It encourages users to share their journey, celebrate milestones, and seek inspiration and advice from like-minded individuals. This narrative fosters a sense of belonging and keeps users engaged.
- **Market:** The primary market for this app includes fitness enthusiasts of all levels – from beginners to seasoned athletes. The app could attract a wide demographic interested in fitness, health, and wellness. Monetization strategies might include partnerships with fitness brands, offering premium features (such as personalized workout plans or diet consultations), and possibly incorporating sponsored content.
- **Habit:** The app is designed to encourage daily engagement. Users would regularly update their fitness activities, meal preps, and other health-related routines. Features like workout challenges, daily tips, or meal idea sharing can help maintain high user engagement and turn the app usage into a daily habit.
- **Scope:** Initially, the app would focus on basic social networking features such as posting updates, photos, and tips. Future expansions could see the app incorporating more comprehensive fitness tracking, meal planning tools, integration with wearable fitness devices, community challenges, and perhaps even live streaming fitness classes or cooking sessions. The scope can gradually increase to offer a more holistic fitness and wellness platform.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Log-In page
* Ability to Post
* Click on user profile 
* Following, liking users post, and commenting
* A feed with content from your followers 

**Optional Nice-to-have Stories**

* Filter by categorie (workout, accessoires, clothes)
* Posting workout videos for group exercises or challenges.
* Messaging Features
* Personalized workout and meal planning suggestions based on user preferences and goals.

### 2. Screen Archetypes

* Login / Registration Screen
    - User registration and profile creation.
* Feed Screen
    - Viewing recent updates and discoveries in the fitness community.
* Post Creation Screen
    - Posting workout updates and meal prep photos.
* Profile Screen
    - Viewing and editing personal profile and goals.
    - Tracking personal fitness journey.
* Search & Discover Screen
    - Discovering new fitness content and users to follow.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home (Feed Screen)
* Discover (Search & Discover Screen)
* Post (Post Creation Screen)
* Profile (Profile Screen)

**Flow Navigation** (Screen to Screen)

* Home (Feed) Screen: The primary screen users see after logging in. It displays recent updates from followed users and suggested content.
    - Post Interaction: Users can like, comment, or share posts directly from the feed.
* Discover Screen: Allows users to search for and discover new content and users.
    - User Interaction: Following new users or engaging with their content.
* Post Creation Screen: Accessed via a button/icon (e.g., a “+” icon), where users can create and upload new posts.
    - Camera Integration: For taking and uploading photos directly.
* Profile Screen: Displays the user’s own posts, profile details, and progress.

## Wireframes


<imgsrc="https://drive.google.com/file/d/1k4kHfwupPMvR9oEyVU5fUad9CLhVYFOr/view?usp=drive_link" width=900>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 

[This section will be completed in Unit 9]

### Models

* User

| Property      | Type     | Description                                    |
|---------------|----------|------------------------------------------------|
| userId        | String   | Unique id for the user (default field)         |
| username      | String   | Username for the user                          |
| email         | String   | Email address of the user                      |
| profileImage  | File     | Image file for user's profile picture          |

* General Model:
 
| Property      | Type            | Description                                    |
|---------------|-----------------|------------------------------------------------|
| postId        | String          | Unique id for the post (default field)         |
| author        | Pointer to User | Reference to the User who created the post     |
| image         | File            | Image that user posts                          |
| caption       | String          | Caption by the user for the post               |
| likesCount    | Number          | Number of likes for the post                   |
| createdAt     | DateTime        | Date when the post was created                 |



### Networking

* Home Feed Screen
    - (Read/GET) Query all posts from followed users
    - (Create/POST) Create a new like on a post
    - (Delete) Delete an existing like
* Create Post Screen
    - (Create/POST) Create a new post
* Profile Screen
    - (Read/GET) Query logged in user's profile
    - (Update/PUT) Update user profile details
* Search Screen
    - (Read/GET) Search for users or posts by keywords


- Create basic snippets for each Parse network request


```swift=
// Home Screen 
let query = PFQuery(className:"Post")
query.includeKeys(["author", "createdAt"])
query.limit = num
query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
   if let error = error { 
      // Handle error
   } else if let posts = posts 
                               {
      // Success, update UI
   }
}
// Creating post 
let newPost = PFObject(className:"Post")
newPost["caption"] = "A new post"
newPost["author"] = PFUser.current()
newPost.saveInBackground { (success, error) in
   if (success) {
      // The post has been saved to the server
   } else {
      // There was a problem, check error.description
   }
}

// Profile

let query = PFQuery(className:"User")
query.getObjectInBackground(withId: PFUser.current()?.objectId) { (user: PFObject?, error: Error?) in
   if let error = error {
      // Handle error
   } else if let user = user {
      // Success, update UI
   }
}

// Searching 

let userQuery = PFQuery(className:"_User")
userQuery.whereKey("username", contains: searchText)
userQuery.findObjectsInBackground { (users: [PFObject]?, error: Error?) in
    if let error = error {
        // Handle error
    } else if let users = users {
        // Success, update UI with found users
    }
}
```

- [OPTIONAL: List endpoints if using existing API such as Yelp]

### Sprint Planning and Development

- **Sprint 1:** 
    - Set up the project and integrate basic Read-only Networking. Design and implement the Home Screen.
- **Sprint 2:** 
    - Design and implement the Home Screen.
- **Sprint 3:** 
    - Build the User Profile screen.
- **Sprint 4:** 
    - Implement The Search Screen for user profile and post.

### Weekly CheckIn:
* Loom video:
[X] (https://www.loom.com/share/664e54c28707459387ebc5f9b9de6a19?sid=b36ab448-2ae3-4404-8d3c-5f8740313f9b)

Overall,starting the project has been really fun i have not encounteres any major problem yet. I'm excited for next week!
