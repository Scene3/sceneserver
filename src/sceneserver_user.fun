/---------------------
 -- sceneserver_user.fun
 --
 -- A representation of a sceneserver user. 
 --
 -- Copyright (c) 2014 by Michael St. Hippolyte
 --
 --/
 
site sceneserver {

    subject {
        boolean is_authenticated [&]
        boolean authenticate(username, password) [&]            
    }
    
    
    
    subject user {
        name [/]
        
    
    }


}
