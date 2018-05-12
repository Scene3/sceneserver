/---------------------
 -- sceneserver_mgr.fun
 --
 -- The scene manager module for sceneserver.
 --
 -- Copyright (c) 2013-2017 by Michael St. Hippolyte
 --
 --/
 
site sceneserver {

    adopt three

    /** Global cache for world models from which content is obtained.  Content may include
     *  scenes, objects and other resources.  
     **/
    global fun_domain{} all_domains = {}
    
    /** Global main world name  **/
    global world_domain_name(nm) = nm

    dynamic fun_domain add_domain(domain_name, fun_domain dom) {
        keep by domain_name in all_domains: fun_domain new_domain = dom
        new_domain;
    }

    /** Global world model.  All primary scenes are retrieved from this model. **/ 
    global fun_domain world_domain = all_domains[world_domain_name]
    global fun_context world_context = world_domain.context
    global initial_scene_name = world_context.construct("initial_scene_name")

    /** Initialization of global world model. **/
    dynamic fun_domain domain_from_file(name, path) = this_domain.child_domain(name, "world", path, "*.world", true)

    dynamic load_world(name, path) {
        add_domain(name, domain_from_file(name, path));
    }
    
    dynamic set_main_world(name) {
        world_domain_name(: name :);
        world_domain;
        initial_scene_name;

        log("world domain: " + world_domain_name + "  main site: " + world_domain.main_site);
        log("initial scene is " + initial_scene_name);
    }

    /** Scene retrieval. **/    
    dynamic scene get_scene(nm) = retrieved_scene(nm)
    
    keep: scene retrieved_scene(nm) {
        keep: scene_name(n) = n
        keep: next_frame = world_domain.get_instance(scene_name + ".next_frame")
        keep: three_object objs[] = world_domain.get_instance(scene_name + ".objs")
        keep: camera cam = world_domain.get_instance(scene_name + ".cam")
        keep: aspect_ratio = world_domain.get_instance(scene_name + ".aspect_ratio")
        keep: scripts[] = world_domain.get_instance(scene_name + ".scripts")
        keep: instantiated_scene = world_domain.get_instance(scene_name)

        name = scene_name

        dynamic init_scene(scene_nm) {
            scene_name(: scene_nm :);
            objs;
            cam;
            aspect_ratio;
            next_frame;
            scripts;
        }

        if (nm && !scene_name) {
            eval(init_scene(nm));
            log("retrieved scene initialized to " + scene_name);
        }
        
        if (!scene_name) {
            redirect scene_not_specified_error(here)
        }
        
        if (!instantiated_scene) {
            redirect scene_not_found_error(here)
        }
        
        instantiated_scene;
    }
    
}
